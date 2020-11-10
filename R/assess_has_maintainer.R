#' Assess a package for an associated maintainer
#'
#' @eval roxygen_assess_family(
#'   "has_maintainer",
#'   "a character vector of maintainers associated with the package")
#'
#' @export
assess_has_maintainer <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_has_maintainer", {
    as.character(x$maintainer)
  })
}

attributes(assess_has_maintainer)$column_name <- "has_maintainer"
attributes(assess_has_maintainer)$label <- "a vector of associated maintainers"



#' Score a package for inclusion of an associated maintainer
#'
#' Coerce a list of maintainers into a numeric value indicating whether the
#' number of listed maintainers is greater than 0.
#'
#' @eval roxygen_score_family("has_maintainer")
#' @return \code{1} if any maintainer is provided, otherwise \code{0}
#'
#' @export
metric_score.pkg_metric_has_maintainer <- function(x, ...) {
  as.numeric(length(x) > 0)
}

attributes(metric_score.pkg_metric_has_maintainer)$label <-
  "A binary indicator of whether a package has a maintainer."
