
pkg_ref_cache.revdeps <- function(x, ...){
  revdeps <- lapply(rownames(pkgs), function(x) {
    lapply(c("Depends","Imports","LinkingTo"), function(d) { devtools::revdep(x,dependencies = d)
    })
  })
}


pkg_ref_cache.deps <- function(x, ...){

}