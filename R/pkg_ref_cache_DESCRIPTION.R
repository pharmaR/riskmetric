pkg_ref_cache.description <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.description")
}

pkg_ref_cache.description.pkg_install <- function(x, name, ...) {
  x$description <- read.dcf(file.path(x$path, "description"))
}

pkg_ref_cache.description.pkg_source <- function(x, name, ...) {
  x$description <- read.dcf(file.path(x$path, "description"))
}
