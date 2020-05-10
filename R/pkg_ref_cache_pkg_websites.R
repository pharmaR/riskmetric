#' Cache package's Website URL
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.pkg_websites <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.pkg_websites")
}



pkg_ref_cache.pkg_websites.pkg_remote <- function(x, name, ...) {
  db  <- rvest::html_table(x$web_html)[[1]]
  url <- db[grep("URL",db[,1], ignore.case = TRUE) ,2]
  if(length(url) == 0) return(character(0L))
  url
}



pkg_ref_cache.pkg_websites.default <- function(x, name, ...) {
  if (!"URL" %in% colnames(x$description)) return(character(0L))
  trimws(strsplit(x$description[,"URL"], ",")[[1]])
}
