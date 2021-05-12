#' Cache package's Source Control URL
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.source_control_url <- function(x, name, ...) {
  grep(
    "(github\\.com|bitbucket\\.org|gitlab\\.com)",
    x$website_urls,
    value = TRUE)
}
