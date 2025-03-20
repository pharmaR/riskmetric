#' @describeIn riskmetric_metadata_caching
#' Retrieve output of covr::package_coverage
#'
#' @keywords internal
#' @usage NULL
#' @export
pkg_ref_cache.covr_coverage <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.covr_coverage")
}

#' @importFrom tools testInstalledPackage
#' @importFrom covr package_coverage
#' @keywords internal
#' @export
#' @method pkg_ref_cache.covr_coverage pkg_source
pkg_ref_cache.covr_coverage.pkg_source <- function(x, name, ...) {
  # use custom 'code' to avoid triggering errors upon test failure.
  # practically identical to covr::package_coverage with the exclusion of
  # `if (result != 0L) show_failures(out_dir)`
  expr <- bquote(tools::testInstalledPackage(.(x$name), types = "tests"))
  capture_expr_output({
    res <- covr::package_coverage(
      path = x$path,
      type = "none",
      code = deparse(expr)
    )
  })

  res
}
