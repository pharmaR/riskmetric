#' Score a package assement, collapsing results into a single numeric
#'
#' Scores reflect the adherence to best practices. Scores always range from 0
#' (worst-) to 1 (best- practice), and can then be used to consistently evaluate
#' the risk involved with using a package.
#'
#' @param x a \code{pkg_metric} object, whose subclass is used to choose the
#'   appropriate scoring method for the atomic metric metadata. Optionally, a
#'   \code{\link[tibble]{tibble}} can be provided, in which cases all
#'   \code{pkg_metric} values will be scored.
#' @param ... additional arguments unused
#'
#' @return a numeric value if a single \code{pkg_metric} is provided, or a
#'   \code{\link[tibble]{tibble}} with \code{pkg_metric} objects scored and
#'   returned as numeric values when a \code{\link[tibble]{tibble}} is provided.
#'
#' @examples
#' # scoring a single assessment
#' score(assess_has_news(pkg_ref("riskmetric")))
#'
#' # scoring many assessments as a tibble
#' score(assess(as_tibble(pkg_ref(c("riskmetric", "riskmetric")))))
#'
#' @family \code{score.*} functions
#'
#' @export
score <- function(x, ...) {
  UseMethod("score")
}



#' @export
score.default <- function(x, ...) {
  if (!inherits(x, "pkg_metric")) {
    warning(sprintf(paste0(
        "Don't know how to score object of class %s. score is only intended ",
        "to be used with objects inheriting class 'pkg_metric', ",
        "returning default score of 0."),
      paste0('"', class(x), '"', collapse = ", ")))
  } else {
    warning(sprintf(paste0(
        "no available scoring algorithm for metric of class %s, ",
        "returning default score of 0."),
      paste0('"', class(x)[1], '"')))
  }

  0
}



#' @export
score.tbl_df <- function(x, ...) {
  assessment_columns <- get_assessment_columns(x)

  for (coln in which(assessment_columns)) {
    x[[coln]] <- vapply(x[[coln]], score, numeric(1L))
    class(x[[coln]]) <- c("pkg_score", class(x[[coln]]))
  }
  x
}



#' Helper for creating a roxygen header from template for score.* functions
#'
#' @examples
#' \dontrun{
#'   #' @eval score_family_functions("has_news")
#' }
#'
score_family_roxygen <- function(name) {

  assess_func <- sprintf("assess_%s", name)
  score_func <- sprintf("score.pkg_metric_%s", name)

  stopifnot(assess_func %in% getNamespaceExports(utils::packageName()))
  stopifnot(score_func %in% getNamespaceExports(utils::packageName()))

  c(sprintf("@param x a \\code{pkg_metric_%s} packge metric object", name),
    "@param ... additional arguments unused",
    "@family \\code{score.*} functions",
    sprintf("@examples score(%s(pkg_ref(\"%s\")))", assess_func, packageName()))
}
