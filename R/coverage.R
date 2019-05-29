#' @importFrom covr package_coverage
#' @export
tbl_coverage <- function(pkg_ref, ...) {
  UseMethod("tbl_coverage")
}

#' [WIP] not working - coverage is always empty
#' @export
tbl_coverage.PackageDirectory <- function(pkg_ref, ...) {
  tmplib <- stringr::str_extract(pkg_ref$pkg_dir, "^.*(?=(/[:alnum:]+$))")

  withr::with_envvar(c(R_LIBS = tmplib, R_LIBS_USER = tmplib, R_LIBS_SITE = tmplib), {
    res <- covr::package_coverage(pkg_ref$pkg_dir, quiet = FALSE)
  }) # end with_envvar

  return(res)

}

