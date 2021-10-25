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
  pkg_metric_eval(class = "pkg_metric_dependencies", {
      get_package_dependencies(x$name, repo = getOption("repos")[["CRAN"]])
  })
}

#' @importFrom BiocManager repositories
#' @export
assess_dependencies.pkg_bioc_remote <- function(x, ...){
  pkg_metric_eval(class = "pkg_metric_dependencies", {
    get_package_dependencies(x$name, BiocManager::repositories()[1])
  })
}

#' Score a package for dependencies
#'
#' Returns the total number dependencies
#'
#' @eval roxygen_score_family("dependencies")
#' @return A \code{numeric}
#'
#' @export
metric_score.pkg_metric_dependencies <- function(x, ...) {
  NROW(x)
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

