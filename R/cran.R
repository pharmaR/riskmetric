#' Get current CRAN version
#'
#' @param pkgname a character vector of names of packages
#' @return a character vector of version numbers of respective packages
#'
#' @examples
#' get_cran_version(c("dplyr", "tidyverse"))
#'
#' @export
#'
get_cran_version <- function(pkgname) {
  with(memoise_cran_db(), Version[match(pkgname, Package)])
}
