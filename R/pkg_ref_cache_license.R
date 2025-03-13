#' Get the package license
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
#' @noRd
#' @export
pkg_ref_cache.license <- function(x, ...) {
  UseMethod("pkg_ref_cache.license")
}

#' @export
#' @method pkg_ref_cache.license default
pkg_ref_cache.license.default <- function(x, ...) {
  if ("License" %in% colnames(x$description)) unname(x$description[,"License"])
  else NA_character_
}



#' @importFrom xml2 xml_find_all xml_text
#' @keywords internal
#' @export
#' @method pkg_ref_cache.license pkg_cran_remote
pkg_ref_cache.license.pkg_cran_remote <- function(x, ...) {
  license_xpath <- "//td[.='License:']/following::td[1]"
  license_nodes <- xml_find_all(x$web_html, xpath = license_xpath)
  xml_text(license_nodes)
}



#' @importFrom xml2 xml_find_all xml_text
#' @keywords internal
#' @export
#' @method pkg_ref_cache.license pkg_bioc_remote
pkg_ref_cache.license.pkg_bioc_remote <- function(x, ...) {
  license_xpath <- "//td[.='License']/following::td[1]"
  license_nodes <- xml_find_all(x$web_html, xpath = license_xpath)
  xml_text(license_nodes)
}
