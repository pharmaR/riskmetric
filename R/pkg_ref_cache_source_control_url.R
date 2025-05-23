#' @describeIn riskmetric_metadata_caching
#' Cache package's Source Control URL
#'
#' @keywords internal
#' @usage NULL
#' @export
pkg_ref_cache.source_control_url <- function(x, name, ...) {
  grep(
    "(github\\.com|bitbucket\\.org|gitlab\\.com)",
    x$website_urls,
    value = TRUE)
}
