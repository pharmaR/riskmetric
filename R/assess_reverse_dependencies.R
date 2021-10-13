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

attr(assess_reverse_dependencies, "column_name") <- "reverse_dependencies"
attr(assess_reverse_dependencies, "label") <- "List of reverse dependencies a package has"

#' Scoring method for number of reverse dependencies a package has
#'
#' @eval roxygen_score_family("reverse_dependencies", dontrun = TRUE)
#' @return The count of reverse dependencies a package has
#'
#' @export
metric_score.pkg_metric_reverse_dependencies <- function(x,...){
  length(x)
}

attributes(metric_score.pkg_metric_reverse_dependencies)$label <-
  "The number of packages that depend on this package."

