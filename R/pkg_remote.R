pkg_remote <- function(x, repos, source){
  pkg_ref_list <- Map(as_remote_pkg, x, repos, source)
  return(vctrs::new_list_of(pkg_ref_list, ptype = pkg_ref(), 
                            class = "list_of_pkg_ref"))
}

pkg_cran_remote <- function(x, repos = "https://cran.rstudio.com/"){
  p <- pkg_remote(x, repos = repos, source = "pkg_cran_remote")
  if(all(class(p)!="pkg_missing")){
    class(p) <- c("pkg_cran_remote", class(p))
  }
  return(p)
}

pkg_bioc_remote <- function(x, repos = "https://bioconductor.org/packages/release/bioc/"){
  p <- pkg_remote(x, repos = repos, source = "pkg_bioc_remote")
  if(all(class(p)!="pkg_missing")){
    class(p) <- c("pkg_bioc_remote", class(p))
  }
  return(p)
}

pkg_rspm_remote <- function(x, repos=options("repos")){
  p <- pkg_remote(x, source = "pkg_rspm_remote")
  if(all(class(p)!="pkg_missing")){
    class(p) <- c("pkg_rspm_remote", class(p))
  }
  return(p)
}

as_remote_pkg <- function(x, repos, source){
  if (missing(x)) return(structure(logical(0L), class = "pkg_ref"))
  if(repos=="") stop("Must specify a repository URL")
  if(!missing(source)){
    source <- c(source, "pkg_remote")
  } else{
    source="pkg_remote"
  }
  
  ap <- memoise_available_packages(repos = repos)
  info <- ap[ap[,"Package"] == x,,drop = FALSE]
  if(nrow(info)>0){
    p <- new_pkg_ref(x,
                     version = info[,"Version"],
                     repo = info[,"Repository"],
                     source = source)
    return(p)
  } else {
    return(new_pkg_ref(x, source = "pkg_missing"))
  }
}
