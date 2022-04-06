#' Cache package dependencies
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#' @return a \code{pkg_ref} object
#' @keywords internal
pkg_ref_cache.dependencies <- function(x, name, ...) {
  UseMethod("pkg_ref_cache.dependencies")
}


pkg_ref_cache.dependencies.pkg_install <- function(x, name, ...) {
  parse_dcf_dependencies(x$path)
}

pkg_ref_cache.dependencies.pkg_source <- function (x, name, ...) {
  parse_dcf_dependencies(x$path)
}

pkg_ref_cache.dependencies.pkg_cran_remote <- function(x, name, ...){
  #Attempt to find CRAN URL by matching all urls returned by getOptions("repos") to memoise_cran_mirrors table
  repos <- getOption("repos")[which(getOption("repos") %in% memoise_cran_mirrors()$URL)]

  if(length(repos)==0){
    repos <- grep("[\\.|//]cran\\.", getOption("repos"), ignore.case = T, value = T)
  }
  if(length(repos)==0){
    repos <- getOption("repos")[["CRAN"]]
  }

  if(length(repos)==0){
    return(NA)
  } else{
    get_package_dependencies(x$name, repo = repos[1]) ##Will use the first CRAN mirror found in the users environment
    }
}

pkg_ref_cache.dependencies.pkg_bioc_remote <- function(x, name, ...){
  get_package_dependencies(x$name, BiocManager::repositories()[1])
}
