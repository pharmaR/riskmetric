#' A helper for structuring assessment return objects for dispatch with the
#' score function
#'
#' @param x data to store as a \code{pkg_metric}
#' @param ... additional attributes to bind to the \code{pkg_metric} object
#' @param class a subclass to differentiate the \code{pkg_metric} object
#'
#' @return a \code{pkg_metric} object
#'
#' @export
pkg_metric <- function(x = NA, ..., class = c()) {
  if (is.null(x)) x <- list()
  structure(x, ..., class = c(class, "pkg_metric", class(x)))
}



#' Convert an object to a \code{pkg_metric}
#'
#' @inheritParams pkg_metric
#' @return a \code{pkg_metric} object
#' @export
as_pkg_metric <- function(x, class = c()) {
  UseMethod("as_pkg_metric")
}



#' @export
as_pkg_metric.default <- function(x, class = c()) {
  pkg_metric(x, class = class)
}



#' @export
as_pkg_metric.expr_output <- function(x, class = c()) {
  x_metric <- pkg_metric(x, class = class)
  if (is_error(x))
    x_metric <- as_pkg_metric_error(x_metric)
  x_metric
}



#' Evaluate a metric
#'
#' Evalute code relevant to a metric, capturing the evaluated code as well as
#' any messages, warnings or errors that are thrown in the process.
#'
#' @param expr An expression to evaluate in order to calculate a
#'   \code{pkg_metric}
#' @param env An environment in which \code{expr} is to be evaluated
#' @inheritParams pkg_metric
#'
#' @return a \code{pkg_metric} object containing the result of \code{expr}
#' @keywords internal
pkg_metric_eval <- function(expr, ..., class = c(), env = parent.frame()) {
  out <- capture_expr_output(substitute(expr), env = env, quoted = TRUE)
  out_metric <- as_pkg_metric(out, class = class)
  if (inherits(out, "error")) out_metric <- as_pkg_metric_error(out_metric)
  out_metric
}



#' @importFrom vctrs vec_ptype_abbr
#' @method vec_ptype_abbr pkg_metric
#' @export
vec_ptype_abbr.pkg_metric <- function(x, ...) {
  "pkg_metric"
}



#' @export
format.pkg_metric_error <- function(x, ...) {
  class_str <- gsub("^pkg_metric_", "", class(x)[[1]])
  pillar::style_na(paste0("<", class_str, ">"))
}



#' @export
format.pkg_metric <- function(x, ...) {
  class_str <- gsub("^pkg_metric_", "", class(x)[[1]])
  data_str <- with_unclassed_to(x, "pkg_metric", pillar::pillar_shaft(x))
  paste0(capture.output(data_str), collapse = "")
}
