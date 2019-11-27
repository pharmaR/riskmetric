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
#' @param error_handler specify a function to be called if the class can't be
#'   identified. Most commonly this occurs for \code{pkg_metric} objects of
#'   subclass \code{pkg_metric_error}, which is produced when an error is
#'   encountered when calculating an associated assessment.
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
#' \dontrun{
#' library(dplyr)
#' score(assess(as_tibble(pkg_ref(c("riskmetric", "riskmetric")))))
#' }
#'
#' @family \code{score.*} functions
#' @seealso score_error_default score_error_zero score_error_NA
#'
#' @export
score <- function(x, ..., error_handler = score_error_default) {
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
score.pkg_metric_error <- function(x, ..., error_handler = score.default) {
  error_handler(x, ...)
}



#' Default score error handling, emitting a warning and returning 0
#'
#' @inheritParams score
#'
#' @export
#' @family \code{score_error_*} functions
score_error_default <- score.default



#' Score error handler to silently return 0
#'
#' @inheritParams score
#'
#' @export
#' @family \code{score_error_*} functions
score_error_zero <- function(...) 0



#' Score error handler to silently return NA
#'
#' @inheritParams score
#'
#' @export
#' @family \code{score_error_*} functions
score_error_NA <- function(...) NA_real_



#' @export
score.tbl_df <- function(x, ..., error_handler = score.default) {
  assessment_columns <- get_assessment_columns(x)
  for (coln in which(assessment_columns)) {
    x[[coln]] <- vapply(x[[coln]], score, numeric(1L), error_handler = error_handler)
    class(x[[coln]]) <- c("pkg_score", class(x[[coln]]))
  }
  x
}



#' Helper for creating a roxygen header from template for score.* functions
#'
#' @param name the name of the scoring function, assuming naming conventions are
#'   followed
#'
#' @return roxygen section template for score family functions
#'
#' @examples
#' \dontrun{
#'   #' @eval score_family_functions("has_news")
#' }
#'
score_family_roxygen <- function(name) {

  assess_func <- sprintf("assess_%s", name)
  score_func <- sprintf("score.pkg_metric_%s", name)

  if (!assess_func %in% getNamespaceExports(utils::packageName()))
    warning(sprintf(paste0("Error when generating documentation for %s. ",
      "Associated assessment function `%s` was not found in the `riskmetric` ",
      "package. Please provide one to complete documentation."),
      name, assess_func))

  if (!score_func %in% getNamespaceExports(utils::packageName()))
    warning(sprintf(paste0("Error when generating documentation for %s. ",
      "Associated scoring function `%s` was not found in the `riskmetric` ",
      "package. Please provide one to complete documentation."),
      name, score_func))

  c(sprintf("@param x a \\code{pkg_metric_%s} packge metric object", name),
    "@param ... additional arguments unused",
    "@family \\code{score.*} functions",
    sprintf("@examples score(%s(pkg_ref(\"%s\")))", assess_func, packageName()))
}
