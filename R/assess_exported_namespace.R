#' Assess a package's exported namespace
#'
#' @eval roxygen_assess_family(
#'   "exported_namespace",
#'   "List of functions and objects exported by a package, excluding S3methods",
#' )
#'
#' @importFrom pkgload parse_ns_file
#' @export
assess_exported_namespace <- function(x, ...) {
  UseMethod("assess_exported_namespace")
}

attributes(assess_exported_namespace)$column_name <- "exported_namespace"
attributes(assess_exported_namespace)$label <- "Objects exported by package"

#' @export
assess_exported_namespace.default <- function(x, ...) {
  as_pkg_metric_na(
    pkg_metric(class = "pkg_metric_exported_namespace"),
    message = sprintf("Cannot export namespace from a %s", x$source))
}

#' @export
assess_exported_namespace.pkg_install <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_exported_namespace", {
    # ignore S3-dispatched methods
    return(getNamespaceExports(x$name))
  })
}

#' @export
assess_exported_namespace.pkg_source <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_exported_namespace", {
    # ignore S3-dispatched methods
    return(pkgload::parse_ns_file(x$path)$exports)
  })
}

#' @export
assess_exported_namespace.cohort_ref <- function(x, ...) {
  ns <- unlist(lapply(x$cohort, assess_exported_namespace))
  return(cohort_metric_eval(class = "cohort_metric_exported_namespaces",
                            ns
  ))
}


#' Score a package for the number of exported objects
#'
#' Score a package for the number of exported objects it has; regularized
#' Convert the number of exported objects \code{length(x)} into a validation
#' score [0,1] \deqn{ 1 / (1 + exp(-0.5 * (sqrt(length(x)) + sqrt(5)))) }
#'
#' The scoring function is the classic logistic curve \deqn{
#' 1 / (1 + exp(-k(x-x[0])) } with a square root scale for the number of exported objects
#' \eqn{x = sqrt(length(x))}, sigmoid midpoint is 25 exported objects, ie. \eqn{x[0] =
#' sqrt(5)}, and logistic growth rate of \eqn{k = 0.25}.
#'
#' \deqn{ 1 / (1 + exp(-0.25 * sqrt(length(x))-sqrt(25))) }
#'
#' @eval roxygen_score_family("exported_namespace")
#' @return numeric value between \code{0} (high number of exported objects) and
#'   \code{1} (low number of exported objects)
#'
#' @export
metric_score.pkg_metric_exported_namespace <- function(x, ...) {
  1 - 1 / (1 + exp(-0.25 * (sqrt(length(x)) - sqrt(25))))
}

attributes(metric_score.pkg_metric_exported_namespace)$label <-
  "The number of exported objects in a package"
