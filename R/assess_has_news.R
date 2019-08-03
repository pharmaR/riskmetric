#' Assess a package for the presence of a NEWS file
#'
#' @param x a packge reference object
#' @param ... additional arguments unused
#'
#' @return a \code{pkg_metric} object
#' @export
#'
assess_has_news <- function(x, ...) {
  UseMethod("assess_has_news")
}

#' assign a friendly name for assess column
attributes(assess_has_news)$column_name <- "has_news"
attributes(assess_has_news)$label <- "number of discovered NEWS files"


#' @export
assess_has_news.pkg_ref <- function(x, ...) {
  pkg_metric(length(x$news), class = "pkg_metric_has_news")
}



#' @export
score.pkg_metric_has_news <- function(x, ...) {
  as.numeric(x)
}
