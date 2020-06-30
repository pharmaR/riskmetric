#' Assess a package for the number of downloads in the past year
#'
#' @details The more times a package has been downloaded the more extensive the user testing and the greater chance there is of someone finding a bug and logging it.
#'
#' @eval roxygen_assess_family(
#'   "downloads_1yr",
#'   "a numeric value between [0,1] indicating the volume of downloads")
#'
#' @export
assess_downloads_1yr <- function(x, ...){
  UseMethod("assess_downloads_1yr")
}

# assign a friendly name for assess column
attr(assess_downloads_1yr, "column_name") <- "downloads_1yr"
attr(assess_downloads_1yr, "label") <- "number of downloads in the past year"



#' @export
assess_downloads_1yr.pkg_ref <- function(x, ...) {
  downloads_1yr <- sum(x$downloads$count)
  pkg_metric(downloads_1yr, class = "pkg_metric_downloads_1yr")
}



#' Defining an Assessment Scoring Function
#' Score a package for the number of downloads in the past year
#'
#' Convert the number of downloads \code{x} in the past year into a validation
#' score [0,1] \deqn{ 1 - 150,000 / (x + 150,000) }
#'
#' The scoring function is a simplification of the classic logistic curve \deqn{
#' 1 / (1 + exp(-k(x-x[0])) } with a log scale for the number of downloads
#' \eqn{x = log(x)}, sigmoid midpoint is 1000 downloads, ie. \eqn{x[0] =
#' log(1,000)}, and logistic growth rate of \eqn{k = 0.5}.
#'
#' \deqn{ 1 - 1 / (1 + exp(log(x)-log(1.5e5))) = 1 - 150,000 / (x + 150,000) }
#'
#' @eval roxygen_score_family("downloads_1yr")
#' @return numeric value between \code{0} (low) and \code{1} (high download
#'   volume) converting the number of downloads.
#'
#' @export
metric_score.pkg_metric_downloads_1yr <- function(x, ...) {
  # simplification from logistic: 1 - 1 / (1 + exp(log(x)-log(1.5e5)))
  1 - 1.5 / (x / 1e5 + 1.5)
}
