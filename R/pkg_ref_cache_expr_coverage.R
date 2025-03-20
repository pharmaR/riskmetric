#' @describeIn riskmetric_metadata_caching
#' Retrieve output of covr::package_coverage, tallied by expression
#'
#' @keywords internal
#' @usage NULL
#' @export
pkg_ref_cache.expression_coverage <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.expr_coverage")
}

#' @importFrom covr tally_coverage
#' @keywords internal
#' @export
#' @method pkg_ref_cache.expression_coverage pkg_source
pkg_ref_cache.expression_coverage.pkg_source <- function(x, name, ...) {
  covr::tally_coverage(x$covr_coverage, by = "expression")
}
