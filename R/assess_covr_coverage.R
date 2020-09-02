#' Assess a package code coverage using the `covr` package
#'
#' @eval roxygen_assess_family(
#'   "covr_coverage",
#'   paste0("a list containing fields 'filecoverage' and 'totalcoverage' ",
#'     "containing a named numeric vector of file unit test coverage and a ",
#'     "singular numeric value representing overall test coverage ",
#'     "respectively."))
#'
#' @export
assess_covr_coverage <- function(x, ...) {
  UseMethod("assess_covr_coverage")
}

attributes(assess_covr_coverage)$column_name <- "covr_coverage"
attributes(assess_covr_coverage)$label <- "Package unit test coverage"



#' @importFrom covr coverage_to_list
#' @export
assess_covr_coverage.pkg_source <- function(x, ...) {
  pkg_metric(
    covr::coverage_to_list(x$covr_coverage),
    class = "pkg_metric_covr_coverage")
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
