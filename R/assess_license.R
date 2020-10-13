#' Assess a package for an acceptable license
#'
#' @eval roxygen_assess_family(
#'   "license",
#'   "a string indicating the license under which the package is released")
#'
#' @export
assess_license <- function(x, ...) {
  pkg_metric(x$license, class = "pkg_metric_license")
}

attributes(assess_license)$column_name <- "license"
attributes(assess_license)$label <-
  "software is released with an acceptable license"



#' Score a package for acceptable license
#'
#' Maps a license string to a score
#'
#' @eval roxygen_score_family("license")
#'
#' @export
metric_score.pkg_metric_license <- function(x, ...) {
  # defering scoring of licenses until we have a bit more consensus or guidance
  NA_real_
}

attributes(metric_score.pkg_metric_license)$label <- 
  "A binary indicator of whether the package ships with an acceptable license."
