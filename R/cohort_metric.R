#' A helper for structuring assessment return objects for dispatch with the
#' score function
#'
#' @param x data to store as a \code{cohort_metric}
#' @param ... additional attributes to bind to the \code{cohort_metric} object
#' @param class a subclass to differentiate the \code{cohort_metric} object
#'
#' @return a \code{cohort_metric} object
#'
#' @export
cohort_metric <- function(x = NA, ..., class = c()) {
  if (is.null(x)) x <- list()
  structure(x, ..., class = c(class, "cohort_metric", class(x)))
}

#' Convert an object to a \code{cohort_metric}
#'
#' @inheritParams pkg_metric
#' @return a \code{cohort_metric} object
#' @export
as_cohort_metric <- function(x, class = c()) {
  UseMethod("as_cohort_metric")
}



#' @export
as_cohort_metric.default <- function(x, class = c()) {
  cohort_metric(x, class = class)
}



#' @export
as_cohort_metric.expr_output <- function(x, class = c()) {
  x_metric <- cohort_metric(x, class = class)
  if (is_error(x))
    x_metric <- as_cohort_metric_error(x_metric)
  x_metric
}

#' Evaluate a cohort metric
#'
#' Evalute code relevant to a cohort metric, capturing the evaluated code as well as
#' any messages, warnings or errors that are thrown in the process.
#'
#' @param expr An expression to evaluate in order to calculate a
#'   \code{cohort_metric}
#' @param env An environment in which \code{expr} is to be evaluated
#' @inheritParams cohort_metric
#'
#' @return a \code{cohort_metric} object containing the result of \code{expr}
#' @keywords internal
cohort_metric_eval <- function(expr, ..., class = c(), env = parent.frame()) {
  out <- capture_expr_output(substitute(expr), env = env, quoted = TRUE)
  out_metric <- as_pkg_metric(out, class = class)
  if (inherits(out, "error")) out_metric <- as_pkg_metric_error(out_metric)
  out_metric
}

#' @export
format.cohort_metric_error <- function(x, ...) {
  class_str <- gsub("^cohort_metric_", "", class(x)[[1]])
  pillar::style_na(paste0("<", class_str, ">"))
}



#' @export
format.cohort_metric <- function(x, ...) {
  class_str <- gsub("^cohort_metric_", "", class(x)[[1]])
  data_str <- with_unclassed_to(x, "cohort_metric", pillar::pillar_shaft(x))
  paste0(capture.output(data_str), collapse = "")
}

#' A subclass wrapping an error with an additional parent class
#'
#' @param error an error condition object to capture
#'
#' @return an error condition object after wrap \code{pkg_metric_error} class.
#' @keywords internal
as_cohort_metric_error <- function(error) {
  as_cohort_metric_condition(error, subclass = "cohort_metric_error")
}

#' A pkg_metric subclass for general metric evaluation conditions
#'
#' @param x an object to wrap in a \code{pkg_metric_condition} class
#' @param ... additional arguments added as attributes to object \code{x}
#' @param subclass an optional subclass of \code{pkg_metric_condition} to
#'   include
#'
#' @return an object after wrap \code{pkg_metric_condition} class.
#' @keywords internal
as_cohort_metric_condition <- function(x, ..., subclass = c()) {
  dots <- list(...)
  if (length(names(dots)) != length(dots))
    stop("All ellipsis arguments must be named")
  dots <- dots[setdiff(names(dots), "class")]
  attributes(x)[names(dots)] <- dots
  class(x) <- c(subclass, "cohort_metric_condition", class(x))
  x
}
