#' Get current CRAN version
#'
#' @param pkgname a character vector of names of packages
#' @return a character vector of version numbers of respective packages
#'
#' @usage
#' get_cran_version(c("dplyr", "tidyverse"))
#'
#' @export
#'
get_cran_version <- function(pkgname) {
  with(memoise_cran_db(), version[match(pkgname, package)])
}
