#' Assess a package for an associated website url
#'
#' @eval roxygen_assess_family(
#'   "has_website",
#'   "a character vector of website urls associated with the package")
#'
#' @export
assess_has_website <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_has_website", {
    x$website_urls
  })
}

attributes(assess_has_website)$column_name <- "has_website"
attributes(assess_has_website)$label <- "a vector of associated website urls"



#' Score a package for inclusion of an associated website url
#'
#' Coerce a list of website urls into a numeric value indicating whether the
#' number of listed urls is greater than 0.
#'
#' @eval roxygen_score_family("has_website")
#' @return \code{1} if any website url is provided, otherwise \code{0}
#'
#' @export
metric_score.pkg_metric_has_website <- function(x, ...) {
  as.numeric(length(x) > 0)
}

attributes(metric_score.pkg_metric_has_website)$label <- 
  "A binary indicator of whether the package has an acompanying website."
