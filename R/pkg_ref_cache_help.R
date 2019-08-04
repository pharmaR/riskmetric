#' Cache a list of available help files as LaTeX objects
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.help <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.help")
}



#' @importFrom tools Rd_db parseLatex
pkg_ref_cache.help.pkg_install <- function(x, name, ...) {
  lapply(tools::Rd_db(package = x$name), tools::parseLatex)
}



#' @importFrom tools Rd_db parseLatex
pkg_ref_cache.help.pkg_source <- function(x, name, ...) {
  lapply(tools::Rd_db(dir = x$path), tools::parseLatex)
}
