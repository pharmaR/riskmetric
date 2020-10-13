#' Assess a package for an up-to-date NEWS file
#'
#' @eval roxygen_assess_family(
#'   "news_current",
#'   "a logical vector indicating whether each discovered NEWS file is up-to-date")
#'
#' @export
assess_news_current <- function(x, ...) {
  UseMethod("assess_news_current")
}

attributes(assess_news_current)$column_name <- "news_current"
attributes(assess_news_current)$label <- "NEWS file contains entry for current version number"



#' @export
assess_news_current.pkg_ref <- function(x, ...) {
  news_current <- grepl(search_version_string(x$version), x$news)
  pkg_metric(news_current, class = "pkg_metric_news_current")
}



#' @export
assess_news_current.pkg_remote <- function(x, ...) {
  html_nodes <- lapply(x$news,
    xml2::xml_find_all,
    sprintf("//text()[contains(., '%s')]", search_version_string(x$version)))
  news_current <- vapply(html_nodes, function(i) length(i) > 0, logical(1L))
  pkg_metric(news_current, class = "pkg_metric_news_current")
}



#" filter trailing 0 minor versions (e.g. 0.1.0 => "0.1")
search_version_string <- function(ver) {
  gsub("(\\.0)+$", "", as.character(ver))
}



#' Score a package for NEWS files updated to current version
#'
#' Coerce a logical vector of discovered up-to-date NEWS to a metric score
#'
#' @eval roxygen_score_family("news_current")
#' @return \code{1} if any NEWS files are up-to-date, otherwise \code{0}
#'
#' @export
metric_score.pkg_metric_news_current <- function(x, ...) {
  as.numeric(length(x) && all(x))
}

attributes(metric_score.pkg_metric_news_current)$label <- paste0(
  "A binary indicator of whether the associated NEWS file has an entry for ",
  "the current version of the package.")
