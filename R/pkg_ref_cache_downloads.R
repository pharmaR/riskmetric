#' Cache a data frame of package downloads from the RStudio CRAN mirror
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
#' @importFrom cranlogs cran_downloads
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.downloads <- function(x, ...) {
  # Downloads since October of 2012, the month RStudio CRAN mirror started publishing logs
  from_date <- as.Date("2012-10-01", format = "%Y-%m-%d")
  cran_downloads(x$name, from = from_date, to = Sys.Date())
}
