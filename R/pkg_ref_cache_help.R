#' Cache a list of available help files as LaTeX objects
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.help <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.help")
}


#' Cache a list of available help files as LaTeX objects
#'
#' @importFrom tools Rd_db parseLatex
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.help.pkg_install <- function(x, name, ...) {
  tools::Rd_db(package = x$name)
}


#' Cache a list of available help files as LaTeX objects
#'
#' @importFrom tools Rd_db parseLatex
#' @keywords internal
pkg_ref_cache.help.pkg_source <- function(x, name, ...) {
  tools::Rd_db(dir = x$path)
}
