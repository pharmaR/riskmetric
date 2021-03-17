#' Cache value of a package's source tarball URL
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @keywords internal
pkg_ref_cache.tarball_url <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.tarball_url")
}



pkg_ref_cache.tarball_url.pkg_remote <- function(x, name, ...) {
  sprintf("%s/%s_%s.tar.gz", x$repo, x$name, x$version)
}
