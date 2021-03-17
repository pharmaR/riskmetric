#' Retrieve a CRAN or Bioc checks or run R CMD check
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @keywords internal
pkg_ref_cache.remote_checks <- function (x, ...)
{
   UseMethod("pkg_ref_cache.remote_checks")
}

pkg_ref_cache.remote_checks.default <- function (x, ...) {
  return(NA)
}

#' @importFrom xml2 read_html xml_find_all xml_text
pkg_ref_cache.remote_checks.pkg_cran_remote <- function(x, ...) {
  URLbase <- "https://cran.r-project.org/web/checks/check_results_"
  webURL <- paste0(URLbase, x$name, ".html")

  page <- read_html(webURL)
  tables <- xml2::xml_find_all(page, ".//table")
  table_cran <- xml2::xml_find_all(tables[[1]], "//tr")
  fields <- lapply(table_cran, xml2::xml_find_all, ".//td|.//th")
  fields <- lapply(fields, xml2::xml_text, trim = TRUE)
  rst <- as.data.frame(do.call(rbind, fields[-1]))
  colnames(rst) <- fields[[1]]
  return(rst)
}

#' @importFrom xml2 read_html xml_find_all xml_text
pkg_ref_cache.remote_checks.pkg_bioc_remote <- function(x, ...) {
  URLbase <- "http://bioconductor.org/checkResults/release/bioc-LATEST/"
  webURL <- paste0(URLbase, x$name)

  page <- read_html(webURL)
  tables <- xml2::xml_find_all(page, ".//table")
  rows <- xml2::xml_find_all(tables[[3]], "//tr")
  rows <- rows[grepl("odd", xml2::xml_attr(rows, "class"))]
  fields <- lapply(rows, xml2::xml_find_all, ".//td|.//th")
  fields <- lapply(fields, function(x) x[grepl("node|status", xml2::xml_attr(x, "class"))])
  text <- lapply(fields, xml2::xml_text, trim = TRUE)
  rst <- as.data.frame(do.call(rbind, text))
  colnames(rst) <- sapply(xml2::xml_find_all(rows[[1]], ".//td"), xml2::xml_text, trim = TRUE)[-1]
  return(rst)
}
