#' Retrieve a list of reverse dependencies
#'
#' @inheritParams pkg_ref_cache
#' @family package reference cache
#'
#' @importFrom devtools revdep
pkg_ref_cache.rev_dependencies <- function(x, ...) {
  UseMethod("pkg_ref_cache.rev_dependencies")
}


pkg_ref_cache.rev_dependencies.default <- function(x, ...) {

}

pkg_ref_cache.revdeps <- function(x, ...){
  UseMethod("pkg_ref_cache.revdeps")
}

pkg_ref_cache.revdeps.default <- function(x, ...){
  return(NA)
}

pkg_ref_cache.revdeps.pkg_remote <- function(x, ...){
  dependencies <-  c("Depends", "Imports",
                     "LinkingTo", "Suggests")
  revdeps <- sapply(dependencies,
                    function(d) tools::dependsOnPkgs(pkgs = x$name, dependencies = d,
                                                     recursive = FALSE,
                                                     installed = pdb, ...)
  )

  return(data.frame(dependency = unlist(revdeps),
                    type=rep(dependencies, sapply(revdeps, length)),
                    stringsAsFactors = FALSE, row.names = NULL))
}

pkg_ref_cache.revdeps.pkg_bioc_remote <- function(x, ...){
  pkg_ref_cache.revdeps.pkg_remote(x, bioconductor=TRUE)
}
