#' Cache package's Source Control URL
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.source_control_url <- function(x, name, ...) {
  grep(
    "(github\\.com|bitbucket\\.org|gitlab\\.com)",
    x$pkg_websites,
    value = TRUE)
}
