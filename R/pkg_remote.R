pkg_remote <- function(x, repos, ...){
  pkg_ref_list <- Map(as_remote_pkg, x, repos)
  return(vctrs::new_list_of(pkg_ref_list, ptype = pkg_ref(), 
                            class = "list_of_pkg_ref"))
}

pkg_cran <- function(x, repos = "https://cran.rstudio.com/", ...){
  p <- pkg_remote(x, repos = repos, ...)
  if(all(class(p)!="pkg_missing")){
    class(p) <- c("pkg_cran_remote", class(p))
  }
  return(p)
}

pkg_bioc <- function(x, repos = "https://bioconductor.org/packages/release/bioc/", ...){
  p <- pkg_remote(x, repos = repos, ...)
  if(all(class(p)!="pkg_missing")){
    class(p) <- c("pkg_bioc_remote", class(p))
  }
  return(p)
}

pkg_rspm <- function(x, repos=options("repos"), ...){
  p <- pkg_remote(x, ...)
  if(all(class(p)!="pkg_missing")){
    class(p) <- c("pkg_rspm_remote", class(p))
  }
  return(p)
}

as_remote_pkg <- function(x, repos, ...){
  if (missing(x)) return(structure(logical(0L), class = "pkg_ref"))
  if(repos=="") stop("Must specify a repository URL")
  
  ap <- memoise_available_packages(repos = repos)
  info <- ap[ap[,"Package"] == x,,drop = FALSE]
  if(nrow(info)>0){
    p <- new_pkg_ref(x,
                     version = info[,"Version"],
                     repo = info[,"Repository"],
                     source = c("pkg_remote"))
    return(p)
  } else {
    return(new_pkg_ref(x, source = "pkg_missing"))
  }
}
