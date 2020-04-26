#' Retrieve output of covr::package_coverage
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.covr_coverage <- function(x, ...) {
  UseMethod("pkg_ref_cache.covr_coverage")
}

#' @importFrom tools testInstalledPackage
#' @importFrom covr package_coverage
pkg_ref_cache.covr_coverage.pkg_source <- function(x, ...) {
  expr <- bquote(tools::testInstalledPackage(.(x$name), types = 'tests'))
  covr::package_coverage(type = "none", code = deparse(expr))
}
