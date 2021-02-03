#' Retrieve output of covr::package_coverage, tallied by function
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.function_coverage <- function(x, ...) {
  UseMethod("pkg_ref_cache.function_coverage")
}

#' @importFrom covr tally_coverage
pkg_ref_cache.function_coverage.pkg_source <- function(x, ...) {
  covr::tally_coverage(x$covr_coverage, by = "expression")
}
