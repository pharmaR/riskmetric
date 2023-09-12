#' Calculate a set of package risk scores
#'
#' @param x A singular \code{character} value, \code{character vector} or
#'   \code{list} of \code{character} values of package names or source code
#'   directory paths.
#' @param ... Additional arguments passed to methods.
#'
#' @return A numeric value if a single \code{pkg_metric} is provided, or a
#'   \code{\link[tibble]{tibble}} with \code{pkg_metric} objects scored and
#'   returned as numeric values when a \code{\link[tibble]{tibble}} is provided.
#' @examples
#' \dontrun{
#'
#' # scoring a single package
#' pkg_risk(riskmetric")
#'
#' # scoring many package as a tibble
#' pkg_risk(c("riskmetric", "riskmetric"))
#'
#' }
#'
#' @export
pkg_risk <- function(
  x,
  source = "pkg_install",
  lib.loc = .libPaths(),
  assessments = all_assessments(),
  repos = getOption("repos", "https://cran.rstudio.com")
  ) {
  if(!is.character(x)){
    stop("Input should be a character vector of package names.")
  }
  if(source == "pkg_install"){
    message("Defaulting to pkg_install source.")
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
