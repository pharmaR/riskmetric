#' Assess a package for an associated source control url
#'
#' @eval roxygen_assess_family(
#'   "has_source_control",
#'   "a character vector of source control urls associated with the package")
#'
#' @export
assess_has_source_control <- function(x, ...) {
  pkg_metric(x$source_control_url, class = "pkg_metric_has_source_control")
}

attributes(assess_has_source_control)$column_name <- "has_source_control"
attributes(assess_has_source_control)$label <- "a vector of associated source control urls"



#' Score a package for inclusion of an associated source control url
#'
#' Coerce a list of source control urls into a numeric value indicating whether
#' the number of listed urls is greater than 0.
#'
#' @eval roxygen_score_family("has_source_control")
#' @return \code{1} if any source control url is provided, otherwise \code{0}
#'
#' @export
score.pkg_metric_has_source_control <- function(x, ...) {
  as.numeric(length(x) > 0)
}
