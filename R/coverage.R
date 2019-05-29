#' @importFrom covr package_coverage
#' @export
coverage <- function(pkg_ref, ...) {
  UseMethod("coverage")
}

#' @export
coverage.RemoteReference <- function(pkg_ref, ...) {

  if (!exists("tmplib", envir = pkg_ref))
    stop("package not downloaded yet") # TODO: more graceful plz

  source_folder <- sprintf("%s/%s", pkg_ref$tmplib, pkg_ref$name)
  if (!dir.exists(source_folder)) {
    stop("todo: need generic unpacking method")
  }

  return(covr::package_coverage(source_folder, quiet = TRUE))

}

