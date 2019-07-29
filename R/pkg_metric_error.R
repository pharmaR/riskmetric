#' Error handler for assessments with safe fallback
#' @export
assessment_error_empty <- function(e) {
  new_pkg_metric(e, class = "pkg_metric_error")
}



#' Error handler for assessments to throw error immediately
#' @export
assessment_error_throw <- function(e) {
  stop(e$message)
}



#' Error handler for assessments to deescalate to warning
#' @export
assessment_error_throw <- function(e) {
  warning(e$message)
  assess_error_empty(e)
}



#' @export
score.pkg_metric_error <- function(x, ...) {
  NA_real_
}
