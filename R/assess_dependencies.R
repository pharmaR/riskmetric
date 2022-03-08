#' Assessment of dependency footprint for a specific package
#'
#' Only Depends, Imports and LinkingTo dependencies are assessed because
#' they are required
#'
#' @details The more packages a package relies on the more chances for errors exist.
#'
#' @eval roxygen_assess_family(
#'   "dependencies",
#'   "a dataframe of package names and they type of dependency the package being assess has to them")
#'
#'
#' @export
assess_dependencies <- function(x, ...){
  UseMethod("assess_dependencies")
}

attributes(assess_dependencies)$column_name <- "dependencies"
attributes(assess_dependencies)$label <- "Package dependency footprint"

#' @export
assess_dependencies.default <- function(x, ...){
  as_pkg_metric_na(pkg_metric(class = "pkg_metric_dependencies"))
}

#' @export
assess_dependencies.pkg_source <- function(x, ...){
  pkg_metric_eval(class = "pkg_metric_dependencies", {
    parse_dcf_dependencies(x$path)
    })
}

#' @export
assess_dependencies.pkg_install <- function(x, ...){
  pkg_metric_eval(class = "pkg_metric_dependencies", {
    parse_dcf_dependencies(x$path)
  })
}

#' @export
assess_dependencies.pkg_cran_remote <- function(x, ...){
  #Attempt to find CRAN URL by matching all urls returned by getOptions("repos") to memoise_cran_mirrors table
  repos <- getOption("repos")[which(getOption("repos") %in% memoise_cran_mirrors()$URL)]

  if(length(repos)==0){
    repos <- grep("[\\.|//]cran\\.", getOption("repos"), ignore.case = T, value = T)
  }
  if(length(repos)==0){
    repos <- getOption("repos")[["CRAN"]]
  }

  if(length(repos)==0){
    as_pkg_metric_error(error = 'Could not determine which CRAN mirror you are using.')
  } else{
    pkg_metric_eval(class = "pkg_metric_dependencies", {
        get_package_dependencies(x$name, repo = repos[1]) ##Will use the first CRAN mirror found in the users environment
    })
  }
}

#' @importFrom BiocManager repositories
#' @export
assess_dependencies.pkg_bioc_remote <- function(x, ...){
  pkg_metric_eval(class = "pkg_metric_dependencies", {
    get_package_dependencies(x$name, BiocManager::repositories()[1])
  })
}

assess_dependencies.cohort_ref <- function(x, ...){
  dep <- lapply(x$cohort, assess_dependencies)
  nm <- sapply(x$cohort, function(x) x$name)
  dep <- data.frame(ref=rep(nm, sapply(dep, nrow)), bind_rows(dep))
  dep$version <- str_extract(dep$package, "(?<=\\().+(?=\\))")
  dep$version<- str_extract(dep$version, "\\d+\\.\\d+(\\.\\d+)*")
  dep$package <- trimws(gsub("\\(.+\\)", "", dep$package))
  dep2 <- list(minVer = tapply(dep$version, dep$package, function(x) sort(x, decreasing = T)[1]),
               minDep = tapply(dep$type, dep$package, function(x) sort(x)[1]))
  dep2 <- merge(as.data.frame(dep2$minVer), as.data.frame(dep2$minDep), by="row.names")
  return(dep2)
}

#' Score a package for dependencies
#'
#' Calculates a regularized score based on the number of dependencies a package has.
#' Convert the number of dependencies \code{NROW(x)} into a validation
#' score [0,1] \deqn{ 1 - 1 / (1 + exp(-0.5 * (NROW(x) + 4))) }
#'
#' The scoring function is the classic logistic curve \deqn{ / (1 + exp(-k(x-x[0])) }
#' \eqn{x = NROW(x)}, sigmoid midpoint is 5 reverse dependencies, ie. \eqn{x[0] = 4},
#' and logistic growth rate of \eqn{k = 0.5}.
#'
#' \deqn{ 1 - 1 / (1 + exp(NROW(x)-4)) }
#'
#' @eval roxygen_score_family("dependencies")
#' @return numeric value between \code{0} (high number of  dependencies) and
#'   \code{1} (low number of dependencies)
#'
#' @export
metric_score.pkg_metric_dependencies <- function(x, ...) {
  1 - 1/(1 + exp(-0.5 * (NROW(x) - 4)))
}
attributes(metric_score.pkg_metric_dependencies)$label <-
  "The number of package dependencies"

#Helper functions to get extract dependencies

#' Gets available packages from necessary repository and filters for
#' package of interest
#'
#' @param name package name
#' @param repo package repository (e.g. CRAN or Bioconductor)
#'
#' @return Returns a data frame with two columns 1) Package names, 2) type of dependency (LinkingTo, Imports, Depends)
#'
get_package_dependencies <- function(name, repo){
  ap <- available.packages(repos = repo)
  deps <- ap[rownames(ap)==name, c("LinkingTo","Imports","Depends")]
  deps <- deps[!is.na(deps)]
  deps <- sapply(strsplit(deps, ","), trimws)
  deps <- data.frame(package=unlist(deps),
                     type=rep(names(deps), sapply(deps, length)),
                     stringsAsFactors = FALSE,
                     row.names = NULL)
  deps <- remove_base_packages(deps)
  return(deps)
}

#' Parse DCF of description file
#'
#' @param path pkg_ref path
#'
parse_dcf_dependencies <- function(path){
  dcf <- read.dcf(file.path(path, "DESCRIPTION"), all=TRUE)
  dcf <- dcf[colnames(dcf) %in% c("LinkingTo","Imports", "Depends")]
  dcf <- sapply(dcf, strsplit, strsplit, split=",")
  dcf <- lapply(dcf, trimws)
  deps <- data.frame(package=unlist(dcf),
                     type=rep(names(dcf), sapply(dcf, length)),
                     stringsAsFactors = FALSE,
                     row.names = NULL)
  deps <- remove_base_packages(deps)
  return(deps)
}

#' Helper function to remove base and recommended packages
#'
#' @param df Data frame of dependencies of a package.
#'
remove_base_packages <- function(df){
  inst <- memoise_available_packages()
  inst_priority <- inst[,"Priority"]
  inst_is_base_rec <- !is.na(inst_priority) & inst_priority %in% c("base", "recommended")
  base_rec_pkgs <- inst[inst_is_base_rec, "Package"]
  deps <- df[!grepl("^R\\s\\(.+\\)", df$package) | df$package %in% base_rec_pkgs, ] ##Remove "R" dependencies as well as base and recomended
  return(deps)
}

#Helper functions to get extract dependencies

#' Gets available packages from necessary repository and filters for
#' package of interest
#'
#' @param name package name
#' @param repo package repository (e.g. CRAN or Bioconductor)
#'
#' @return Returns a data frame with two columns 1) Package names, 2) type of dependency (LinkingTo, Imports, Depends)
#'
get_package_dependencies <- function(name, repo){
  ap <- available.packages(repo = repo)
  deps <- ap[rownames(ap)==name, c("LinkingTo","Imports","Depends")]
  deps <- deps[!is.na(deps)]
  deps <- lapply(strsplit(deps, ","), trimws)
  deps <- data.frame(package=unlist(deps),
                     type=rep(names(deps), sapply(deps, length)),
                     stringsAsFactors = FALSE,
                     row.names = NULL)
  return(deps)
}

#' Parse DCF of description file
#'
#' @param path pkg_ref path
#'
parse_dcf_dependencies <- function(path){
  dcf <- read.dcf(file.path(path, "DESCRIPTION"), all=TRUE)
  dcf <- dcf[colnames(dcf) %in% c("LinkingTo","Imports", "Depends")]
  dcf <- sapply(dcf, strsplit, strsplit, split=",")
  dcf <- lapply(dcf, trimws)
  deps <- data.frame(package=unlist(dcf),
                     type=rep(names(dcf), sapply(dcf, length)),
                     stringsAsFactors = FALSE,
                     row.names = NULL)
  return(deps)
}

