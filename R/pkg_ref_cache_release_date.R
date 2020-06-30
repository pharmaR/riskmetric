#' Cache a List of Package Release Date from a Package Reference
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
pkg_ref_cache.release_date <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.release_date")
}


pkg_ref_cache.release_date.pkg_remote <- function(x, name, ...) {
  release_xpath <- "//td[.='Published:']/following::td[1]"
  date <- xml2::xml_text(xml2::xml_find_all(x$web_html, release_xpath))
  date
}


pkg_ref_cache.release_date.pkg_install <- function(x, name, ...) {

  if (!"Date" %in% colnames(x$description)) return(NA)
  x$description[, "Date"]
}



pkg_ref_cache.release_date.pkg_source <- pkg_ref_cache.release_date.pkg_install
