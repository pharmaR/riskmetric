#' Assess how many recent BugReports have been closed
#'
#' @eval roxygen_assess_family(
#'   "last_30_bugs_status",
#'   "a logical vector indicating whether a recent BugReport was closed",
#'   dontrun = TRUE)
#'
#' @export
assess_last_30_bugs_status <- function(x, ...) {
  bug_reports_status(x)
}

attributes(assess_last_30_bugs_status)$column_name <- "bugs_status"
attributes(assess_last_30_bugs_status)$label <- "vector indicating whether BugReports status is closed"



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
#' @eval roxygen_score_family("last_30_bugs_status", dontrun = TRUE)
#' @return a fractional value indicating percentage of last 30 bug reports that
#'   are now closed
#'
#' @export
score.pkg_metric_last_30_bugs_status <- function(x, ...) {
  mean(x, na.rm = TRUE)
}
