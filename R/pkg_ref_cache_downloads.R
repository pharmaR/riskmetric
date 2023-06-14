#' Cache a list of available help files as LaTeX objects
#' @param n Number of days to look back with default value of 365 days
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
#' @importFrom cranlogs cran_downloads
#' @return a \code{pkg_ref} object
#' @keywords internal
#' @noRd
pkg_ref_cache.downloads <- function(x, ..., n=365) {
  cran_downloads(x$name, from=Sys.Date()-n, to=Sys.Date())
}
