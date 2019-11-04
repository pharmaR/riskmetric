#' Assess how many recent BugReports have been closed
#'
#' @eval assess_family_roxygen(
#'   "bug_reports_closed",
#'   "a logical vector indicating whether a recent BugReport was closed")
#'
#' @export
assess_last_30_bugs_status <- function(x, ...) {
  bug_reports_status(x)
}

attributes(assess_news_current)$column_name <- "bugs_status"
attributes(assess_news_current)$label <- "vector indicating whether BugReports status is closed"



bug_reports_status <- function(x, ...) {
  UseMethod("bug_reports_status", x$bug_reports)
}



bug_reports_status.github_bug_report <- function(x, ...) {
  pkg_metric(
    vapply(x$bug_reports, "[[", character(1L), "state") == "closed",
    class = "pkg_metric_last_30_bugs_status")
}



bug_reports_status.gitlab_bug_report <- function(x, ...) {
  pkg_metric(
    vapply(x$bug_reports, "[[", character(1L), "state") == "closed",
    class = "pkg_metric_last_30_bugs_status")
}



#' Score a package for number of recently opened BugReports that are now closed
#'
#' @eval score_family_roxygen("last_30_bugs_status")
#' @return a fractional value indicating percentage of last 30 bug reports that
#'   are now closed
#'
#' @export
score.pkg_metric_last_30_bugs_status <- function(x, ...) {
  mean(x, na.rm = TRUE)
}
