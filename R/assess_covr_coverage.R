#' Assess a package code coverage using the `covr` package
#'
#' @eval roxygen_assess_family(
#'   "covr_coverage",
#'   paste0("a list containing fields 'filecoverage' and 'totalcoverage' ",
#'     "containing a named numeric vector of file unit test coverage and a ",
#'     "singular numeric value representing overall test coverage ",
#'     "respectively."),
#'   dontrun = TRUE  # execution time can exceed CRAN limits
#' )
#'
#' @export
assess_covr_coverage <- function(x, ...) {
  UseMethod("assess_covr_coverage")
}

attributes(assess_covr_coverage)$column_name <- "covr_coverage"
attributes(assess_covr_coverage)$label <- "Package unit test coverage"



#' @export
assess_covr_coverage.default <- function(x, ...) {
  as_pkg_metric_na(pkg_metric(class = "pkg_metric_covr_coverage"))
}



#' @importFrom covr coverage_to_list
#' @export
assess_covr_coverage.pkg_source <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_covr_coverage", {
    covr::coverage_to_list(x$covr_coverage)
  })
}



#' Score a package for unit test coverage
#'
#' Returns the overall test coverage from a covr coverage report
#'
#' @eval roxygen_score_family("covr_coverage")
#' @return A \code{numeric}
#'
#' @export
metric_score.pkg_metric_covr_coverage <- function(x, ...) {
  x$totalcoverage / 100
}

attributes(metric_score.pkg_metric_covr_coverage)$label <-
  "The fraction of lines of code which are covered by a unit test."
