#' Helper function to check if valid version of oysteR is installed.
#'
#' @keywords internal
#'
validate_suggests_install <- function(pkg_name, min_version) {
  # check if oysteR package is installed
  if (!requireNamespace(pkg_name, quietly = TRUE)) {
    # if not, prompt for install
    suggests_install_helper()
  } else {
    # if it is installed, check version, and prompt for upgrade if less than 0.1.0
    v <- packageVersion(pkg_name)
    is_old <- v$major == 0 && v$minor < 1
    if (is_old) {
      suggests_install_helper(pkg_name, is_upgrade = TRUE)
    }
  }
}

#' Helper function to guide user through install of oysteR
#'
#' @param is_upgrade Are you upgrading an older version of oysteR?
#' @keywords internal
#'
suggests_install_helper <- function(pkg_name, is_upgrade = FALSE) {
  if (is_upgrade) {
    ptxt <- "an upgrade"
    stxt <- "upgrade"
  } else {
    ptxt <- "installation"
    stxt <- "install"
  }

  if (interactive() & !getOption("riskmetric.skip_oyster_install")) {
    inst_yn <- utils::menu(
      choices = c("Yes", "No"),
      title = paste(
        "Assessing security requires",
        ptxt,
        "of the oysteR package.",
        "Would you like to install this now?"
      )
    )

    if (inst_yn == "1") {
      utils::install.packages("oysteR")
    } else {
      # if user skipped once, don't prompt again until session restarts
      if (inst_yn == "2") options("riskmetric.skip_oyster_install" = TRUE)

      stop(paste(
        "asssess_security not run. Please",
        stxt,
        "the oysteR package if you wish to assess security."
      ))
    }
  }
}
