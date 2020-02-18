#' Assess a package for the presence of a NEWS file
#'
#' @eval roxygen_assess_family(
#'   "has_news",
#'   "an integer value indicating the number of discovered NEWS files")
#'
#' @export
assess_has_news <- function(x, ...) {
  UseMethod("assess_has_news")
}

# assign a friendly name for assess column
attributes(assess_has_news)$column_name <- "has_news"
attributes(assess_has_news)$label <- "number of discovered NEWS files"



#' @export
assess_has_news.pkg_ref <- function(x, ...) {
  pkg_metric(length(x$news), class = "pkg_metric_has_news")
}



#' Score a package for the presence of a NEWS file
#'
#' Coerce the number of news files to binary indication of valid NEWS files
#'
#' @eval roxygen_score_family("has_news")
#' @return \code{1} if any NEWS files are found, otherwise \code{0}
#'
#' @export
score.pkg_metric_has_news <- function(x, ...) {
  as.numeric(x > 0)
}
