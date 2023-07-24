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
pkg_risk <- function(x = NA, ...) {
  if (is.null(x)) x <- list()
  pkg_ref(x) %>%
    tibble::as_tibble() %>%
    pkg_assess() %>%
    pkg_score()
}
