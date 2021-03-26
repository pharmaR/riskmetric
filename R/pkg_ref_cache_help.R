#' Cache a list of available help files as LaTeX objects
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @keywords internal
pkg_ref_cache.help <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.help")
}



#' @importFrom tools Rd_db parseLatex
#' @keywords internal
pkg_ref_cache.help.pkg_install <- function(x, name, ...) {
  tools::Rd_db(package = x$name)
}



#' @importFrom tools Rd_db parseLatex
#' @keywords internal
pkg_ref_cache.help.pkg_source <- function(x, name, ...) {
  tools::Rd_db(dir = x$path)
}
