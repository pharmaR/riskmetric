#' Generate list of Reverse Dependencies for a package
#'
#' @details The more packages that depend on a package the more chance
#' for errors/bugs to be found
#'
#' @eval roxygen_assess_family(
#'   "reverse_dependencies",
#'   "A character vector of reverse dependencies")
#'
#' @export
assess_reverse_dependencies <- function(x, ...){
  UseMethod("assess_reverse_dependencies")
}

#' @importFrom devtools revdep
#' @export
assess_reverse_dependencies.default <- function(x, ...){
  pkg_metric_eval(class = "pkg_metric_reverse_dependencies",
                  devtools::revdep(x$name, bioconductor = TRUE)
  )
}

#' @importFrom devtools revdep
#' @export
assess_reverse_dependencies.cohort_ref <- function(x, ...){
  cohort_rev_deps <- lapply(x$cohort, assess_reverse_dependencies)
  cohort_nm <- sapply(x$cohort, "[[", "name")

  cohort_rev_deps <- data.frame(pkg=rep(cohort_nm, sapply(cohort_rev_deps, length)),
                                revdep=unlist(cohort_rev_deps))

  if(length(x$library)){
    lib_pkgs <- sapply(x$library, function(x) x$name)
  }

  return(cohort_metric_eval(class = "cohort_metric_reverse_dependencies",
                  cohort_rev_deps[cohort_rev_deps$revdep %in% c(lib_pkgs, cohort_nm), ]
    )
  )
}

attr(assess_reverse_dependencies, "column_name") <- "reverse_dependencies"
attr(assess_reverse_dependencies, "label") <- "Table of reverse dependencies for each package."


#' Scoring method for number of reverse dependencies a package has
#'
#' Score a package for the number of reverse dependencies it has; regularized
#' Convert the number of reverse dependencies \code{length(x)} into a validation
#' score [0,1] \deqn{ 1 / (1 + exp(-0.5 * (sqrt(length(x)) + sqrt(5)))) }
#'
#' The scoring function is the classic logistic curve \deqn{
#' 1 / (1 + exp(-k(x-x[0])) } with a square root scale for the number of reverse dependencies
#' \eqn{x = sqrt(length(x))}, sigmoid midpoint is 5 reverse dependencies, ie. \eqn{x[0] =
#' sqrt(5)}, and logistic growth rate of \eqn{k = 0.5}.
#'
#' \deqn{ 1 / (1 + -0.5 * exp(sqrt(length(x)) - sqrt(5))) }

#' @eval roxygen_score_family("reverse_dependencies", dontrun = TRUE)
#' @return numeric value between \code{1} (high number of reverse dependencies) and
#'   \code{0} (low number of reverse dependencies)
#'
#' @export
metric_score.pkg_metric_reverse_dependencies <- function(x,...){
  1 / (1 + exp(-0.5 * (sqrt(length(x)) - sqrt(5))))
}

attributes(metric_score.pkg_metric_reverse_dependencies)$label <-
  "The (log10) number of packages that depend on this package."


#' Metric for the assessment of reverse dependencies of a cohort.
#'
#' @importFrom igraph fit_power_law
#' @export
cohort_metric.cohort_metric_reverse_dependencies <- function(x, ...){
  igraph::fit_power_law(tapply(cohort_rev_deps$revdep,cohort_rev_deps$pkg, length))$KS.p
}
attributes(cohort_metric.cohort_metric_reverse_dependencies)$label <-
  "p-value of power law distribution fit"

