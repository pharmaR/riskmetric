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



#' @rdname assess_has_news
#' @export
#' @importFrom xml2 xml_find_all xml_attrs
assess_has_news.pkg_cran_remote <- function(x, ...) {
  news_result <- rep(list(content = NULL, valid = TRUE), length(x$NEWS_urls))
  new_pkg_metric(news_result, class = "pkg_metric_has_news")
}



#' @rdname assess_has_news
#' @export
#' @importFrom xml2 xml_find_all xml_attrs
assess_has_news.pkg_bioc_remote <- function(x, ...) {
  news_result <- rep(list(content = NULL, valid = TRUE), length(x$NEWS_urls))
  new_pkg_metric(news_result, class = "pkg_metric_has_news")
}



#' @rdname assess_has_news
#' @export
assess_has_news.pkg_remote <- function(x, ...) {
  stop(
    "don't know how to scrape for NEWS files for an unknown remote repo. \n",
    "repo: '", x$repo, "'")
}



#' @rdname assess_has_news
#' @export
assess_has_news.pkg_install <- function(x, ...) {
  news_result <- assess_news_in_dir(system.file(package = x$name), ...)
  new_pkg_metric(news_result, class = "pkg_metric_has_news")
}



#' @rdname assess_has_news
#' @export
assess_has_news.pkg_source <- function(x, ...) {
  news_result <- assess_news_in_dir(x$path, ...)
  new_pkg_metric(news_result, class = "pkg_metric_has_news")
}



#' @importFrom tools file_ext
assess_news_in_dir <- function(x) {
  news <- list()

  # accommodate NEWS.Rd, NEWS.md, etc
  news$files <- list.files(x, pattern = "^NEWS\\.*")
  if (!length(news$files)) {
    news$message <- "no NEWS file found"
    return(news)
  }

  news$content <- rep(NULL, length(news$files))
  news$valid <- vector(length(news$files), mode = "logical")

  # attempt to parse all NEWS.* files
  file_paths <- file.path(x, news$files)
  for (i in seq_along(file_paths)) {
    f <- file_paths[[i]]
    tryCatch({
      if (tolower(tools::file_ext(f)) == "rd") {
        news$content[[i]] <- .tools()$.news_reader_default(f)
      } else if (tolower(tools::file_ext(f)) == "md") {
        # NOTE: should we do validation of markdown format?
        news$content[[i]] <- readLines(f)
      }
      news$valid[[i]] <- TRUE
    }, error = function(e) {
      news$valid[[i]] <- FALSE
    })
  }

  # NOTE: should we test whether NEWS file is up-to-date with latest version?

  news
}



#' @rdname score
#' @export
score.pkg_metric_has_news <- function(x, ...) {
  as.numeric(any(x$valid, na.rm = TRUE))
}
