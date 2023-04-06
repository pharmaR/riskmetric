#' Helper function to prompt to install a package if it is not present
#'
#' @keywords internal
#'
validate_suggests_install <- function(pkg_name, calling_fn = deparse(match.call()[[1]])) {
  # check if package is installed
  if (!requireNamespace(pkg_name, quietly = TRUE)) {
    # if not, prompt for install
    suggests_install_helper(pkg_name, calling_fn)
  }
}

#' Helper function to guide user through install of a package
#'
#' @keywords internal
#'
suggests_install_helper <- function(pkg_name, calling_fn) {
  op_nm <- sprintf("riskmetric.skip_%s_install", pkg_name)
  if (interactive() & !getOption(op_nm)) {
    inst_yn <- utils::menu(
      choices = c("Yes", "No"),
      title = sprintf(
        "Running %s requires installation of the of the %s package.
         Would you like to install this now?",
        calling_fn, pkg_name
      )
    )

    if (inst_yn == "1") {
      utils::install.packages(pkg_name)
    } else {
      # if user skipped once, don't prompt again until session restarts
      if (inst_yn == "2") do.call(options, as.list(setNames(TRUE, op_nm)))
      stop(sprintf(
        "%s not run. Please install the %s package if you wish to proceed.",
        calling_fn, pkg_name
      ))
    }
  }
}
