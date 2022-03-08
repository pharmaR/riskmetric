#' Cohort ref class
#'
#' This is a class to hold a list of pkg_refs along with extra
#' information about the environment the packages are to be used/installed in.
#'
#' @export
#' @family cohort_ref
#'
cohort_ref <- function(x, library, ...){
  if (missing(x)) return(structure(list(pkg_ref_list = list(logical(0L)),
                              library = logical(0L)), class = "cohort_ref"))
  new_cohort_ref(x, library, ...)
}

new_cohort_ref <- function(x, library, ...){
  dots <- list(...)
  if (length(dots) && is.null(names(dots)) || any(names(dots) == ""))
    stop("cohort_ref ellipses arguments must be named")

  if(is.character(x) | all(sapply(x, class) != "pkg_ref")){
    x <- lapply(x, pkg_cran, repos = "https://cran.rstudio.com")
  }

  if(!missing(library) &&
     (is.character(library) | all(sapply(library, class) != "pkg_ref"))){
    library <- pkg_ref(library)
    cohort_data <- list(cohort = x, library=library, dots)
  }
  cohort_data <- list(cohort = x, library=logical(0L), dots)
  structure(cohort_data, class = "cohort_ref")
}

make_library <- function(x){
  if(x=="install"){
    return(install.packages())
  } else if(grepl("/.+/.+/", x)){

  } else if(length(x) > 1 & is.character(x)){

  } else{
    return(available.packages())
  }

}


