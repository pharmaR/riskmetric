#' @describeIn riskmetric_metadata_caching
#' Cache value of a package's source tarball URL
#'
#' @family package reference cache
#' @keywords internal
#'
#' @usage NULL
#' @export
pkg_ref_cache.tarball_url <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.tarball_url")
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.tarball_url pkg_remote
pkg_ref_cache.tarball_url.pkg_remote <- function(x, name, ...) {
  sprintf("%s/%s_%s.tar.gz", x$repo, x$name, x$version)
}
