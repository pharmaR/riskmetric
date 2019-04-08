#' Get current CRAN version
#'
#' @param pkgname character, package name
#'
#' @usage
#' get_cran_version("dplyr")
#'
#' @export
get_cran_version <- function(pkgname) {

  package <- NULL # avoid CRAN check note on NSE
  memoise_cran_db() %>%
    filter(package == pkgname) %>%
    pull(version)

}
