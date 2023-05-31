#' Retrieve output of covr::package_coverage
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
#' @noRd
pkg_ref_cache.covr_coverage <- function(x, ...) {
  UseMethod("pkg_ref_cache.covr_coverage")
}


#' Retrieve output of covr::package_coverage
#'
#' @importFrom tools testInstalledPackage
#' @importFrom covr package_coverage
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.covr_coverage.pkg_source <- function(x, ...) {
  # use custom 'code' to avoid triggering errors upon test failure.
  # practically identical to covr::package_coverage with the exclusion of
  # `if (result != 0L) show_failures(out_dir)`
  expr <- bquote(tools::testInstalledPackage(.(x$name), types = 'tests'))
  cnsl <- capture_expr_output({
    res <- covr::package_coverage(
      path = x$path,
      type = "none",
      code = deparse(expr))
  })

  res
}
