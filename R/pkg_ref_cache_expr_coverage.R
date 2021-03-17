#' Retrieve output of covr::package_coverage, tallied by expression
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @keywords internal
pkg_ref_cache.expression_coverage <- function(x, ...) {
  UseMethod("pkg_ref_cache.expr_coverage")
}

#' @importFrom covr tally_coverage
#' @keywords internal
pkg_ref_cache.expression_coverage.pkg_source <- function(x, ...) {
  covr::tally_coverage(x$covr_coverage, by = "expression")
}
