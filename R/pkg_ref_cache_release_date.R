#' @describeIn riskmetric_metadata_caching
#' Cache a List of Package Release Date from a Package Reference
#'
#' @family package reference cache
#' @keywords internal
#'
#' @usage NULL
#' @export
pkg_ref_cache.release_date <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.release_date")
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.release_date pkg_remote
pkg_ref_cache.release_date.pkg_remote <- function(x, name, ...) {
  release_xpath <- "//td[.='Published:']/following::td[1]"
  date <- xml2::xml_text(xml2::xml_find_all(x$web_html, release_xpath))
  date
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.release_date pkg_install
pkg_ref_cache.release_date.pkg_install <- function(x, name, ...) {
  if (!"Date" %in% colnames(x$description)) return(NA)
  x$description[, "Date"]
}

#' @keywords internal
#' @export
#' @method pkg_ref_cache.release_date pkg_source
pkg_ref_cache.release_date.pkg_source <- pkg_ref_cache.release_date.pkg_install
