#' @describeIn riskmetric_metadata_caching
#' Cache the DESCRIPTION file contents for a package reference
#'
#' @keywords internal
#' @usage NULL
#' @export
pkg_ref_cache.description <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.description")
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.description pkg_install
pkg_ref_cache.description.pkg_install <- function(x, name, ...) {
  read.dcf(file.path(x$path, "DESCRIPTION"))
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.description pkg_source
pkg_ref_cache.description.pkg_source <- function(x, name, ...) {
  read.dcf(file.path(x$path, "DESCRIPTION"))
}
