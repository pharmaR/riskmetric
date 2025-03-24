#' @describeIn riskmetric_metadata_caching
#' Cache a list of available help files as LaTeX objects
#'
#' @keywords internal
#' @importFrom cranlogs cran_downloads
#' @usage NULL
#' @export
pkg_ref_cache.downloads <- function(x, name, ..., n = 365) {
  cran_downloads(x$name, from = Sys.Date() - n, to = Sys.Date())
}
