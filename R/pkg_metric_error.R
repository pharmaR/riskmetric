#' Error handler for assessments with safe fallback
#' @export
assessment_error_empty <- function(e) {
  pkg_metric(e, class = "pkg_metric_error")
}



#' Error handler for assessments to throw error immediately
#' @export
assessment_error_throw <- function(e, name, assessment) {
  stop(format_assessment_message(e, name, assessment))
}



#' Error handler for assessments to deescalate to warning
#' @export
assessment_error_as_warning <- function(e, name, assessment) {
  warning(format_assessment_message(e, name, assessment), call. = FALSE)
  assessment_error_empty(e)
}



format_assessment_message <- function(x, name, assessment) {
  out <- "In "

  if (!missing(name))
    out <- paste0(out, "package '", name, "' ")
  if (!missing(assessment))
    out <- paste0(out, "while assessing '", assessment, "' ")

  paste0(out,
    "`", paste(capture.output(x$call), collapse = " "), "` : \n",
    x$message)
}



#' @export
pillar_shaft.pkg_metric_error <- function(x) {
  pillar::new_pillar_shaft_simple(pillar::style_na(paste0(
    "<",
    gsub("pkg_metric_", "", class(x)[[1]]),
    ">")))
}
