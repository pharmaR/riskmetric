#' Assess a package for the presence of Vignettes files
#'
#' @eval roxygen_assess_family(
#'   "has_vignettes",
#'   "an integer value indicating the number of discovered vignettes files")
#'
#' @export
assess_has_vignettes <- function(x, ...) {
  UseMethod("assess_has_vignettes")
}

# assign a friendly name for assess column
attributes(assess_has_vignettes)$column_name <- "has_vignettes"
attributes(assess_has_vignettes)$label <- "number of discovered vignettes files"



#' @export
assess_has_vignettes.pkg_ref <- function(x, ...) {
  pkg_metric(length(x$vignettes), class = "pkg_metric_has_vignettes")
}



#' Score a package for the presence of a Vignettes file
#'
#' Coerce the number of vignettes files to binary indication of valid Vignettes
#'
#' @eval roxygen_score_family("has_vignettes")
#' @return \code{1} if any Vignettes files are found, otherwise \code{0}
#'
#' @export
metric_score.pkg_metric_has_vignettes <- function(x, ...) {
  as.numeric(x > 0)
}
