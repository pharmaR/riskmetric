pkg_ref_cache.cran_checks <- function (x, name, ...)
{
   UseMethod("pkg_ref_cache.cran_checks")
}

pkg_ref_cache.cran_checks.pkg_cran_remote <- function(x, name, ...) {
  URLbase <- "https://cran.r-project.org/web/checks/check_results_"
  webURL <- paste0(URLbase, x$name, ".html")

  page <- read_html(webURL)
  tables <- xml2::xml_find_all(page, ".//table")
  table_cran <- xml2::xml_find_all(tables[[1]], "//tr")
  fields <- lapply(table_cran, xml2::xml_find_all, ".//td|.//th")
  fields <- lapply(fields, xml2::xml_text, trim=T)
  #sapply(fields, "[[", 6)[-1]
  rst <- as.data.frame(do.call(rbind, fields[-1]))
  colnames(rst) <- fields[[1]]
  return(rst)
}

pkg_ref_cache.cran_checks.pkg_bioc_remote <- function(x, name, ...) {
  URLbase <- "http://bioconductor.org/checkResults/release/bioc-LATEST/"
  webURL <- paste0(URLbase, x$name)

  page <- read_html(webURL)
  tables <- xml2::xml_find_all(page, ".//table")
  rows <- xml_find_all(tables[[3]], "//tr")
  rows <- rows[grepl("odd", xml_attr(rows, "class"))]
  fields <- lapply(rows, xml_find_all, ".//td|.//th")
  fields <- lapply(fields, function(x) x[grepl("node|status", xml_attr(x, "class"))])
  text <- lapply(fields, xml_text, trim=T)
  #sapply(fields, "[[", 6)[-1]
  rst <- as.data.frame(do.call(rbind, text))
  colnames(rst) <- sapply(xml_find_all(rows[[1]], ".//td"), xml_text, trim=TRUE)[-1]
  return(rst)
}

pkg_ref_cache.cran_checks.pkg_bioc_remote <- function(x, name, ...) {
  URLbase <- "http://bioconductor.org/checkResults/release/bioc-LATEST/"
  webURL <- paste0(URLbase, x$name)

  page <- read_html(webURL)
  tables <- xml2::xml_find_all(page, ".//table")
  rows <- xml_find_all(tables[[3]], "//tr")
  rows <- rows[grepl("odd", xml_attr(rows, "class"))]
  fields <- lapply(rows, xml_find_all, ".//td|.//th")
  fields <- lapply(fields, function(x) x[grepl("node|status", xml_attr(x, "class"))])
  text <- lapply(fields, xml_text, trim=T)
  #sapply(fields, "[[", 6)[-1]
  rst <- as.data.frame(do.call(rbind, text))
  colnames(rst) <- sapply(xml_find_all(rows[[1]], ".//td"), xml_text, trim=TRUE)[-1]
  return(rst)
}

pkg_ref_cache.pkg_source <- function(x, name, ...){
  check_results <- devtools::check(x$path)
  return(check_results)
}
