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
  validate_suggests_install(pkg_name = "oysteR")

  UseMethod("assess_security")
}

attributes(assess_security)$column_name <- "security"
attributes(assess_security)$label <-
  "number of vulnerabilities detected in OSS Index"

# set as a "Suggests" package to be excluded from all_assessments if the package
# is not installed
attributes(assess_security)$suggests <- !requireNamespace("oysteR", quietly = TRUE)
attributes(assess_security)$suggests_pkg <- "oysteR"


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



