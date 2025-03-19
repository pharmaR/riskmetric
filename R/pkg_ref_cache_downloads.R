#' @describeIn riskmetric_metadata_caching
#' Cache a list of available help files as LaTeX objects
#'
#' @family package reference cache
#' @keywords internal
#'
#' @importFrom cranlogs cran_downloads
#' @usage NULL
#' @export
pkg_ref_cache.downloads <- function(x, ..., n = 365) {
  cran_downloads(x$name, from = Sys.Date() - n, to = Sys.Date())
}
