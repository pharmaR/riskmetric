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



#' @rdname assess_has_news
#' @export
#' @importFrom xml2 xml_find_all xml_attrs
assess_has_news.pkg_cran_remote <- function(x, ...) {
  # scrape CRAN html for NEWS links
  NEWS_links <- xml2::xml_find_all(x$web_html, xpath = '//a[.="NEWS"]')

  # add NEWS link url metadata to package environment
  x$NEWS_urls <- sprintf("%s/%s",
    x$web_url,
    vapply(xml2::xml_attrs(NEWS_links), "[", character(1L), "href"))

  news_result <- rep(list(content = NULL, valid = TRUE), length(x$NEWS_urls))
  structure(
    news_result,
    class = c("pkg_metric_has_news", "pkg_metric", class(news_result)))
}



#' @rdname assess_has_news
#' @export
#' @importFrom xml2 xml_find_all xml_attrs
assess_has_news.pkg_bioc_remote <- function(x, ...) {
  # scrape Bioconductor package webpage for NEWS links
  relative_path <- sprintf("../news/%s/NEWS", x$name)
  news_link_xpath <- sprintf('//a[@href="%s"]', relative_path)
  NEWS_links <- xml2::xml_find_all(x$web_html, xpath = news_link_xpath)

  # add NEWS link url metadata to package environment
  x$NEWS_urls <- xml2::url_absolute(
    vapply(xml2::xml_attrs(NEWS_links), "[", character(1L), "href"),
    x$web_url)

  news_result <- rep(list(content = NULL, valid = TRUE), length(x$NEWS_urls))
  structure(
    news_result,
    class = c("pkg_metric_has_news", "pkg_metric", class(news_result)))
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
  structure(
    news_result,
    class = c("pkg_metric_has_news", "pkg_metric", class(news_result)))
}



#' @rdname assess_has_news
#' @export
assess_has_news.pkg_source <- function(x, ...) {
  news_result <- assess_news_in_dir(x$path, ...)
  structure(
    news_result,
    class = c("pkg_metric_has_news", "pkg_metric", class(news_result)))
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
