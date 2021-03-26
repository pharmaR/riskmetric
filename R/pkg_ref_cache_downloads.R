#' Cache a list of available help files as LaTeX objects
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
#' @importFrom cranlogs cran_downloads
#' @keywords internal
pkg_ref_cache.downloads <- function(x, ...) {
  cran_downloads(x$name, from=Sys.Date()-365, to=Sys.Date())
}
