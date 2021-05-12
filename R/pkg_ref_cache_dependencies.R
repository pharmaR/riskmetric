#' Cache package dependencies
#'
#' A package's dependencies is an important indicator or the package's complexiety.
#'
#' @export

pkg_ref_cache.deps <- function(x, ...){
  UseMethod("pkg_ref_cache.deps")
}

pkg_ref_cache.deps.pkg_remote <- function(x, ...){
  ap <- available.packages(contriburl = x$repo)
  deps <- ap[rownames(ap)==x$name, c("LinkingTo","Imports","Depends")]
  deps <- deps[!is.na(deps)]
  deps <- sapply(strsplit(deps, ","), trimws)
  deps <- data.frame(package=unlist(deps),
                     type=rep(names(deps), sapply(deps, length)),
                     stringsAsFactors = FALSE,
                     row.names = NULL)
  return(deps)
}
