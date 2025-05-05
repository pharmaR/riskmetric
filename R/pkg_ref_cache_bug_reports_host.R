#' @describeIn riskmetric_metadata_caching
#' Get the host name of a BugReports url
#'
#' @keywords internal
#' @usage NULL
#' @export
pkg_ref_cache.bug_reports_host <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.bug_reports_host")
}

#' @importFrom urltools domain
#' @keywords internal
#' @export
#' @method pkg_ref_cache.bug_reports_host default
pkg_ref_cache.bug_reports_host.default <- function(x, name, ...) {
  if (is.null(x$bug_reports_url)) return(NULL)
  sapply(strsplit(domain(x$bug_reports_url), "\\."), function(dm) dm[length(dm)-1])
}
