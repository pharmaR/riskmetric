pkg_ref_cache.DESCRIPTION <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.DESCRIPTION")
}

pkg_ref_cache.DESCRIPTION.pkg_install <- function(x, name, ...) {
  x$DESCRIPTION <- read.dcf(file.path(x$path, "DESCRIPTION"))
}

pkg_ref_cache.DESCRIPTION.pkg_source <- function(x, name, ...) {
  x$DESCRIPTION <- read.dcf(file.path(x$path, "DESCRIPTION"))
}
