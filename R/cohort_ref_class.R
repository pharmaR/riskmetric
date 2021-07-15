#' Cohort ref class
#'
#' This is a class to hold a list of pkg_refs along with extra
#' information regarding the environment a set of pkg_refs is to be installed into.
#'
#' @export
#' @family cohort_ref
#'
cohort_ref <- function(x, library, ...){
  if (missing(x)) return(structure(list(pkg_ref_list = list(logical(0L)),
                              library = logical(0L)), class = "cohort_ref"))
  as_cohort_ref(x, library, ...)
}

new_cohort_ref <- function(x, library, ...){
  dots <- list(...)
  if (length(dots) && is.null(names(dots)) || any(names(dots) == ""))
    stop("cohort_ref ellipses arguments must be named")
  if(is.character(x) | all(sapply(x, class) != "pkg_ref")){
    x <- pkg_ref(x)
  }
  cohort_data <- list(x, library=library, dots)
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


