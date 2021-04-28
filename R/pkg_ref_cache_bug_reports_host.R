#' Get the host name of a BugReports url
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.bug_reports_host <- function(x, ...) {
  UseMethod("pkg_ref_cache.bug_reports_host")
}


#' Get the host name of a BugReports url
#'
#' @importFrom urltools domain
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.bug_reports_host.default <- function(x, ...) {
  if (is.null(x$bug_reports_url)) return(NULL)
  sapply(strsplit(domain(x$bug_reports_url), "\\."), function(dm) dm[length(dm)-1])
}
