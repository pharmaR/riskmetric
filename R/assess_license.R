#' Assess a package for an up-to-date NEWS file
#'
#' @eval roxygen_assess_family(
#'   "license",
#'   "a string indicating the license under which the package is released")
#'
#' @export
assess_license <- function(x, ...) {
  UseMethod("assess_license")
}

attributes(assess_license)$column_name <- "license"
attributes(assess_license)$label <-
  "software is released with an acceptable license"



#' @export
assess_license.pkg_ref <- function(x, ...) {
  license <- if ("License" %in% colnames(x$description)) {
    unname(x$description[,"License"])
  } else {
    NA_character_
  }

  pkg_metric(license, class = "pkg_metric_license")
}



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
