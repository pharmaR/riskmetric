#' Cohort ref class
#'
#' This is a class to hold a list of pkg_refs along with extra
#' information about the environment the packages are to be used/installed in.
#'
#' @export
#' @family cohort_ref
#'
cohort_ref <- function(x, library, includeDependencies = TRUE, ...){
  if (missing(x)) return(structure(list(pkg_ref_list = list(logical(0L)),
                              library = logical(0L)), class = "cohort_ref"))
  new_cohort_ref(x, library, ...)
}

new_cohort_ref <- function(x, library, includeDependencies = includeDependencies...){
  dots <- list(...)

  if (length(dots) && is.null(names(dots)) || any(names(dots) == ""))
    stop("cohort_ref ellipses arguments must be named")

  is_a_path <- all(is_path(library))
  if((is.character(x) & length(x)>1) | all(sapply(x, function(y) !"pkg_ref" %in% class(y)))){
    x <- lapply(x, pkg_cran, repos = "https://cran.rstudio.com")
  } else if (class(x) == "list_of_pkg_ref" || all(sapply(x, function(y) "pkg_ref" %in% class(y))) )

  if(!missing(library) &&
     (is.character(library) | all(sapply(library, class) != "pkg_ref"))){
    library <-
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

is_path <- function(x){
  if(is.character(x)){
    return(dir.exists(x))
  }
}
