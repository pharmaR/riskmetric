#' Assess a package for the presence of a url field where bugs can be reported.
#'
#' @eval roxygen_assess_family("has_bug_reports_url", 
#' "a character value containing the BugReports field contents")
#'
#' @export
assess_has_bug_reports_url <- function(x, ...){
  has_bug_reports_url <- x$bug_reports_url
  pkg_metric(has_bug_reports_url, class = "pkg_metric_has_bug_reports_url") 
}

# assign a friendly name for assess column
attr(assess_has_bug_reports_url,"column_name") <- "has_bug_reports_url"
attr(assess_has_bug_reports_url,"label") <- "presence of a bug_reports_url in repository"

#' Score a package for the presence of a bug report url
#'
#' @eval roxygen_score_family("has_bug_reports_url")
#' 
#' @return A logical value indicating whether the package has a BugReports field
#'   filled in
#' 
#' @export
score.pkg_metric_has_bug_reports_url <- function(x, ...) {
  # Return a score of TRUE if a bug report url is found, false otherwise
  ifelse(!is.null(x), TRUE, FALSE)
}