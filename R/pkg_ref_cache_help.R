#' @describeIn riskmetric_metadata_caching
#' Cache a list of available help files as LaTeX objects
#'
#' @keywords internal
#' @usage NULL
#' @export
pkg_ref_cache.help <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.help")
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.help pkg_install
pkg_ref_cache.help.pkg_install <- function(x, name, ...) {
  tools::Rd_db(package = x$name)
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.help pkg_source
pkg_ref_cache.help.pkg_source <- function(x, name, ...) {
  tools::Rd_db(dir = x$path)
}
