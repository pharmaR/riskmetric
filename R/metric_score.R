#' Score a package metric
#'
#' Convert a package metric into a numeric value between 0 to 1
#'
#' @param x A \code{pkg_metric_*} class object to score
#' @param ... Additional arguments unused
#'
#' @export
#'
metric_score <- function(x, ...) {
  UseMethod("metric_score")
}



#' @export
metric_score.default <- function(x, ...) {
  if (!inherits(x, "pkg_metric")) {
    warning(sprintf(paste0(
        "Don't know how to score object of class %s. score is only intended ",
        "to be used with objects inheriting class 'pkg_metric', ",
        "returning default score of 0."),
      paste0('"', class(x), '"', collapse = ", ")))
  } else {
    warning(sprintf(paste0(
        "no available scoring algorithm for metric of class %s, ",
        "returning default score of 0."),
      paste0('"', class(x)[1], '"')))
  }

  0L
}



#' @export
metric_score.pkg_metric_error <- function(x, ...,
    error_handler = score_error_default) {
  error_handler(x, ...)
}



#' Default score error handling, emitting a warning and returning 0
#'
#' @inheritParams metric_score
#'
#' @export
#' @family \code{score_error_*} functions
score_error_default <- metric_score.default



#' Score error handler to silently return 0
#'
#' @inheritParams metric_score
#'
#' @export
#' @family \code{score_error_*} functions
score_error_zero <- function(...) 0



#' Score error handler to silently return NA
#'
#' @inheritParams metric_score
#'
#' @export
#' @family \code{score_error_*} functions
score_error_NA <- function(...) NA_real_

