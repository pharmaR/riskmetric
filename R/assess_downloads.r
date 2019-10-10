#' Assess a package for the number of downloads in the past year
#' 
#' @details The more times a package has been downloaded the more extensive the user testing and the greater chance there is of someone finding a bug and logging it.
#'
#' @eval assess_family_roxygen(
#'   "downloads_1yr",
#'   "a numeric value between [0,1] indicating the volume of downloads")
#'
#' @export
assess_downloads_1yr <- function(x, ...){
  UseMethod("assess_downloads_1yr")
}
# assign a friendly name for assess column
attr(assess_downloads_1yr,"column_name") <- "downloads_1yr"
attr(assess_downloads_1yr,"label") <- "number of downloads in the past year"

pkg_ref_cache.downloads_1yr <- function(x, name, ...) {
  cran_downloads(x$name, from=Sys.Date()-365, to=Sys.Date()) %>% group_by(package) %>% summarize(downloads_1yr = sum(count))
}

#' @import cranlogs
#' @export
assess_downloads_1yr.pkg_ref <- function(x, ...) {
  pkg_metric(x$downloads_1yr, class = "pkg_metric_downloads_1yr")
}

# Defining an Assessment Scoring Function
#' Score a package for the number of downloads in the past year
#'
#' Convert the number of downloads \code{x} in the past year into a validation score [0,1] 
#' \deqn{ 1 - \frac{150,000}{X + 150,000} }
#'
#' @eval score_family_roxygen("downloads_1yr")
#' @return numeric value between \code{0} (low) and \code{1} (high download volume) converting the number of downloads. 
#'
#' @export
score.pkg_metric_downloads_1yr <- function(x, ...) {
  # simplification from logistic: 1 - 1 / (1 + exp(log(x)-log(1.5e5)))
  1 - 1.5e5 / (x + 1.5e5) 
}
