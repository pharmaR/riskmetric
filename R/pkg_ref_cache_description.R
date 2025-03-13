#' Cache the DESCRIPTION file contents for a package reference
#'
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
#' @noRd
pkg_ref_cache.description <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.description")
}


#' @export
#' @method pkg_ref_cache.description pkg_install
pkg_ref_cache.description.pkg_install <- function(x, name, ...) {
  read.dcf(file.path(x$path, "DESCRIPTION"))
}



#' @export
#' @method pkg_ref_cache.description pkg_source
pkg_ref_cache.description.pkg_source <- function(x, name, ...) {
  read.dcf(file.path(x$path, "DESCRIPTION"))
}
