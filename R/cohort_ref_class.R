#' Cohort ref class
#'
#' This is a class to hold a list of pkg_refs along with extra
#' information about the environment the packages are to be used/installed in.
#'
#' @export
#' @family cohort_ref
#'
cohort_ref <- function(x, library = c("base", "recommended","installed"), lib.loc="", includeDependencies = TRUE, ...){
  if (missing(x) & missing(library) & missing(lib.loc)) {
    # return(vctrs::new_list_of(cohort=list_of_pkg_ref(),
    #                           library=list_of_pkg_ref(),
    #                           ptype = list_of_pkg_ref(),
    #                           class = "cohort_ref"))
    stop("No packages defined for cohort ref")
  }

  new_cohort_ref(x, ...)
}

new_cohort_ref <- function(x, library="recommended", lib.loc, ...){
  dots <- list(...)

  if (length(dots) && is.null(names(dots)) || any(names(dots) == "")){
    stop("cohort_ref ellipses arguments must be named")
    }

  if(is.atomic(x) & length(x)>1){
    x <- as_list_of_pkg_ref(lapply(x, pkg_cran, repos = getOption("repos")))
  } else if (class(x) != "list_of_pkg_ref" &&
             all(sapply(x, function(y) "pkg_ref" %in% class(y)))){
    x <- as_list_of_pkg_ref(x)
  }

  ip <- as.data.frame(installed.packages())
  if(library=="base"){
    libref <- as_list_of_pkg_ref(lapply(ip$Package[ip$Priority=="base"], pkg_install))
  } else if(library=="recommended"){
    libref <- as_list_of_pkg_ref(lapply(ip$Package[ip$Priority %in% c("base", "recommended")], pkg_install))
  } else if(library=="installed"){
    if(!missing(lib.loc)){
      libref <- as_list_of_pkg_ref(lapply(ip$Package, pkg_install))
    } else{
      ip <- as.data.frame(installed.packages(lib.loc))
      libref <- as_list_of_pkg_ref(lapply(ip$Package, pkg_install))
    }

  }
  return(structure(list(cohort=x,
                        library=libref,
                        dots), class = "cohort_ref"))
}

is_path <- function(x){
  if(is.character(x)){
    return(dir.exists(x))
  }
}


#' @importFrom tibble tibble
#' @importFrom dplyr bind_rows
#' @method as_tibble cohort_ref
#' @export
as_tibble.cohort_ref <- function(x, ...) {
  dplyr::bind_rows(as_tibble(x$cohort),
            as_tibble(x$library))
}

#' @importFrom tibble tibble
#' @method print cohort_ref
#' @export
print.cohort_ref <- function(x, ...){
  list(as_tibble(x$cohort),
       as_tibble(x$library))
}
