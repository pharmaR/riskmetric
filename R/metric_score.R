#' Score a package metric
#'
#' Convert a package metric into a numeric value between 0 to 1
#'
#' @param x A \code{pkg_metric_*} class object to score
#' @param ... Additional arguments unused
#'
#' @return score of a package risk metric
#' @export
#'
metric_score <- function(x, ...) {
  if (inherits(x, "pkg_metric_condition"))
    return(metric_score_condition(x, ...))
  UseMethod("metric_score")
}


#' @export
metric_score.default <- function(x, ...) {
  if (!inherits(x, "pkg_metric") | !inherits(x, "cohort_metric")) {
    warning(sprintf(paste0(
        "Don't know how to score object of class %s. score is only intended ",
        "to be used with objects inheriting class 'pkg_metric' or 'cohort_metric', ",
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

metric_score_condition <- function(x, ...) {
  UseMethod("metric_score_condition")
}

metric_score_condition.pkg_metric_error <- function(x, ...,
    error_handler = score_error_default) {
  error_handler(x, ...)
}


metric_score_condition.pkg_metric_na <- function(x, ...) {
  structure(NA_real_, class = c("pkg_score_na", "numeric"),
  label="No scoring method for metric" )
}

metric_score_condition.pkg_metric_error <- function(x, ...) {
  structure(NA_real_, class = c("pkg_score_error", "numeric"),
            label="There was an error scoring this assessment" )
}

metric_score_condition.pkg_metric_todo <- function(x, ...) {
  structure(NA_real_, class = c("pkg_score_todo", "numeric"),
            label="A scoring method for this assessment will be implemented in the future" )
}



#' Default score error handling, emitting a warning and returning 0
#'
#' @inheritParams metric_score
#' @return a value of package score
#' @export
score_error_default <- metric_score.default



#' Score error handler to silently return 0
#'
#' @inheritParams metric_score
#'
#' @return a value of package score
#' @export
score_error_zero <- function(...) 0



#' Score error handler to silently return NA
#'
#' @inheritParams metric_score
#' @return a value of package score
#' @export
score_error_NA <- function(...) NA_real_

