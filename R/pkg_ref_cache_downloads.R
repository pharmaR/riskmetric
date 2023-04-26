#' Cache a data frame of package downloads from the RStudio CRAN mirror
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
#' @importFrom cranlogs cran_downloads
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.downloads <- function(x, ...) {
  UseMethod("pkg_ref_cache.downloads")
}

#' @importFrom cranlogs cran_downloads
#' @keywords internal
pkg_ref_cache.downloads.default <- function(x, ...) {
  # Downloads since Oct2012 - when RStudio CRAN mirror started publishing logs
  from_date <- as.Date("2012-10-01", format = "%Y-%m-%d")
  cran_downloads(x$name, from = from_date, to = Sys.Date())
}

#' @importFrom cranlogs cran_downloads
#' @keywords internal
pkg_ref_cache.downloads.pkg_cran_remote <- function(x, name, ...) {
  from_date <- x$archive_release_dates[1, 'date'][[1]]
  cran_downloads(x$name, from = from_date, to = Sys.Date())
}
