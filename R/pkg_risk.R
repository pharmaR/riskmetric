#' Calculate a set of package risk scores
#'
#' @param x A singular \code{character} value, \code{character vector} or
#'   \code{list} of \code{character} values of package names or source code
#'   directory paths.
#' @param source Optional argument that will overright what riskmetric does when
#'  determining a package source. By default it will find sources for package
#'  info based on the riskmetric subclass hierarchy and availability on your
#'  system.
#' @param lib.loc The path to the R library directory of the installed package.
#' @param assessments A list of assessment functions to apply to each package
#'  reference. By default, a list of all exported assess_* functions from the
#'  riskmetric package.
#' @param repos URL of CRAN repository to pull package metadata. Defaults to
#'  global option set on your system or the RStudio CRAN URL if not set.
#'
#' @return A numeric value if a single \code{pkg_metric} is provided, or a
#'   \code{\link[tibble]{tibble}} with \code{pkg_metric} objects scored and
#'   returned as numeric values when a \code{\link[tibble]{tibble}} is provided.
#' @examples
#' \dontrun{
#'
#' # scoring a single package
#' pkg_risk("riskmetric")
#'
#' # scoring many package as a tibble
#' pkg_risk(c("riskmetric", "dplyr", "abc"))
#'
#' # score packages from a specific package source
#' pkg_risk(c("riskmetric", "dplyr", "abc"), source = "pkg_cran_remote")
#'
#' }
#'
#' @export
pkg_risk <- function(
  x,
  source = c(NA, "pkg_install", "pkg_source", "pkg_missing", "pkg_cran_remote", "pkg_bioc_remote", "pkg_git_remote"),
  lib.loc = .libPaths(),
  assessments = all_assessments(),
  repos = getOption("repos", "https://cran.rstudio.com")
  ) {

  source <- match.arg(source)
  source <- switch(source, "NA" = NULL, source[[1]])

  if (!is.character(x)) {
    stop("Input should be a character vector of package names.")
  }
  if (identical(source,"pkg_install")){
    message("Defaulting to ", source, " source...")
  }
  if (is.null(source)) {
    message("Finding source(s) for package info based on riskmetric subclass hierarchy and availability...")
  }

  pkg_ref_obj <- pkg_ref(
    x,
    source = source,
    lib.loc = lib.loc,
    repos = repos
  )

  pkg_ref_tbl <- tibble::as_tibble(pkg_ref_obj)

  pkg_assess_obj <- pkg_assess(
    x = pkg_ref_tbl,
    assessments = assessments
  )

  pkg_score(pkg_assess_obj)
}

#' Calculate a set of package risk scores on CRAN
#' @param x A singular \code{character} value, \code{character vector} or
#'   \code{list} of \code{character} values of package names or source code
#'   directory paths.
#' @param source Optional argument that will overright what riskmetric does when
#'  determining a package source. By default it will find sources for package
#'  info based on the riskmetric subclass hierarchy and availability on your
#'  system.
#' @param ... Additional arguments passed to `pkg_risk()`
pkg_risk_cran <- pkg_risk(x, source = "pkg_cran_remote", ...){
  pkg_risk(x, source = source, ...)
}
