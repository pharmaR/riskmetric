pkg_ref_cache.tarball_url <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.tarball_url")
}

pkg_ref_cache.tarball_url.pkg_remote <- function(x, name, ...) {
  x$tarball_url <- sprintf("%s/%s_%s.tar.gz", x$repo, x$name, x$version)
}
