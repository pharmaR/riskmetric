#' Retrieve a CRAN or Bioc checks or run R CMD check
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
#' @noRd
pkg_ref_cache.remote_checks <- function (x, ...) {
   UseMethod("pkg_ref_cache.remote_checks")
}

pkg_ref_cache.remote_checks.default <- function (x, ...) {
  return(NA)
}

#' @importFrom httr content GET
#' @importFrom xml2 xml_find_all xml_text
pkg_ref_cache.remote_checks.pkg_cran_remote <- function(x, ...) {
  webURL <- sprintf("%s/web/checks/check_results_%s.html", x$repo_base_url, x$name)
  page <- httr::content(httr::GET(webURL))
  tables <- xml2::xml_find_all(page, ".//table")
  table_cran <- xml2::xml_find_all(tables[[1]], "//tr")
  fields <- lapply(table_cran, xml2::xml_find_all, ".//td|.//th")
  fields <- lapply(fields, xml2::xml_text, trim = TRUE)
  rst <- as.data.frame(do.call(rbind, fields[-1]))
  colnames(rst) <- fields[[1]]
  return(rst)
}

#' @importFrom httr content GET
#' @importFrom xml2 xml_find_all xml_text
pkg_ref_cache.remote_checks.pkg_bioc_remote <- function(x, ...) {
  webURL <- sprintf("%s/%s", x$repo_base_url, x$name)

  # TODO:
  # refine x$repo_base_url for BioConductor packages so that we don't need to do
  # nasty substitutions like this
  webURL <- sub("packages/release/bioc[^/]*", "checkResults/release/bioc-LATEST", webURL)

  page <- httr::content(httr::GET(webURL))
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
