#' Get current CRAN version
#'
#' @param pkgname character, package name
#'
#'
#' @export
get_cran_version <- function(pkgname) {

  riskmetric:::memoise_cran_db() %>%
    filter(package == pkgname) %>%
    pull(version)

}
