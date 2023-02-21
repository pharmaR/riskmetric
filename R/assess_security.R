#' Assess a package for known security vulnerabilities in the OSS Index
#'
#' @param x a \code{pkg_ref} package reference object
#' @param ... additional arguments passed on to S3 methods, rarely used
#' @return a \code{pkg_metric} containing Assess for any known security vulnerabilities in the OSS Index via oysteR
#' @seealso \code{\link{metric_score.pkg_metric_security}}
#'
#' @importFrom utils install.packages menu
#' @export
assess_security <- function(x, ...) {

  # checks whether a compatible version of oysteR is installed. prompts user to
  # install or upgrade if needed when running interactively. an error is thrown
  # in the event a valid oysteR package is not installed.
  validate_oyster_install()

  UseMethod("assess_security")
}

attributes(assess_security)$column_name <- "security"
attributes(assess_security)$label <- "OSS Scan Results"

# set as a "Suggests" package to be excluded from all_assessments if the package
# is not installed
attributes(assess_security)$suggests <- !requireNamespace("oysteR", quietly = TRUE)

#' @export
assess_security.default <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_security", {
    x$security
  })
}


#' Score a package for known security vulnerabilities in the OSS Index
#'
#' Coerce the count of reported vulnerabilities to a binary indicator.
#'
#' @eval roxygen_score_family("security", dontrun = TRUE)
#' @return \code{1} if no vulnerabilities are found, otherwise \code{0}
#'
#' @export
metric_score.pkg_metric_security <- function(x, ...) {
  as.numeric(x < 1)
}
attributes(metric_score.pkg_metric_security)$label <-
  "A binary indicator of whether a package has OSS Index listed vulnerabilities."



#' Helper function to check if valid version of oysteR is installed.
#'
#' @keywords internal
#'
validate_oyster_install <- function() {
  # check if oysteR package is installed
  if (!requireNamespace("oysteR", quietly = TRUE)) {
    # if not, prompt for install
    oyster_install_helper()
  } else {
    # if it is installed, check version, and prompt for upgrade if less than 0.1.0
    v <- packageVersion("oysteR")
    is_old <- v$major == 0 && v$minor < 1
    if (is_old) {
      oyster_install_helper(is_upgrade = TRUE)
    }
  }
}

#' Helper function to guide user through install of oysteR
#'
#' @param is_upgrade Are you upgrading an older version of oysteR?
#' @keywords internal
#'
oyster_install_helper <- function(is_upgrade = FALSE) {
  if (is_upgrade) {
    ptxt <- "an upgrade"
    stxt <- "upgrade"
  } else {
    ptxt <- "installation"
    stxt <- "install"
  }

  if (interactive()) {
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
      stop(paste(
        "asssess_security not run. Please",
        stxt,
        "the oysteR package if you wish to assess security."
      ))
    }
  }
}
