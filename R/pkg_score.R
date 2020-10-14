#' Score a package assessment, collapsing results into a single numeric
#'
#' pkg_score() calculates the risk involved with using a package. Risk ranges
#' from 0 (low-risk) to 1 (high-risk).
#'
#' @param x A \code{pkg_metric} object, whose subclass is used to choose the
#'   appropriate scoring method for the atomic metric metadata. Optionally, a
#'   \code{\link[tibble]{tibble}} can be provided, in which cases all
#'   \code{pkg_metric} values will be scored.
#' @param ... Additional arguments passed to \code{summarize_scores} when an
#'   object of class \code{tbl_df} is provided, unused otherwise.
#' @param error_handler Specify a function to be called if the class can't be
#'   identified. Most commonly this occurs for \code{pkg_metric} objects of
#'   subclass \code{pkg_metric_error}, which is produced when an error is
#'   encountered when calculating an associated assessment.
#'
#' @return A numeric value if a single \code{pkg_metric} is provided, or a
#'   \code{\link[tibble]{tibble}} with \code{pkg_metric} objects scored and
#'   returned as numeric values when a \code{\link[tibble]{tibble}} is provided.
#'
#' @examples
#' # scoring a single assessment
#' metric_score(assess_has_news(pkg_ref("riskmetric")))
#'
#' # scoring many assessments as a tibble
#' \dontrun{
#' library(dplyr)
#' pkg_score(pkg_assess(as_tibble(pkg_ref(c("riskmetric", "riskmetric")))))
#' }
#'
#' @family \code{score.*} functions
#' @seealso score_error_default score_error_zero score_error_NA
#'
#' @export
pkg_score <- function(x, ..., error_handler = score_error_default) {
  UseMethod("pkg_score")
}



#' @export
pkg_score.tbl_df <- function(x, ..., error_handler = score_error_default) {
  assessment_columns <- get_assessment_columns(x)
  for (coln in which(assessment_columns)) {
    metric_score_s3_fun <- firstS3method("metric_score", class(x[[coln]][[1]]))

    x[[coln]] <- vapply(x[[coln]],
      metric_score,
      numeric(1L),
      error_handler = error_handler)

    attr(x[[coln]], "label") <- attr(metric_score_s3_fun, "label")
    class(x[[coln]]) <- c("pkg_score", class(x[[coln]]))
  }

  ignore_cols <- c("package", "version", "pkg_ref")
  x[["pkg_score"]] <- summarize_scores(x[, !names(x) %in% ignore_cols], ...)

  # reorder columns so that metadata columns come first
  pkg_cols <- intersect(names(x), c("package", "version", "pkg_ref", "pkg_score"))
  x <- x[, c(pkg_cols, setdiff(names(x), pkg_cols))]

  x
}



#' @export
pkg_score.list_of_pkg_metric <- function(x, ...,
    error_handler = score_error_default) {

  lapply(x, function(xi) {
    s <- metric_score(xi, error_handler = error_handler)
    metric_score_s3_fun <- firstS3method("metric_score", class(xi))
    attr(s, "label") <- attr(metric_score_s3_fun, "label")
    class(s) <- c("pkg_score", class(s))
    s
  })
}



#' Helper for creating a roxygen header from template for score.* functions
#'
#' @param name the name of the scoring function, assuming naming conventions are
#'   followed
#' @param dontrun logical indicating whether examples should be wrapped in
#'   a dontrun block. This is particularly useful for assessments which may
#'   require an internet connection.
#'
#' @return roxygen section template for score family functions
#'
#' @examples
#' \dontrun{
#' #' @eval roxygen_score_family("has_news")
#' }
#'
roxygen_score_family <- function(name, dontrun = FALSE) {

  assess_func <- sprintf("assess_%s", name)
  score_func <- sprintf("metric_score.pkg_metric_%s", name)
  example_template <- if (dontrun) {
    "@examples \n\\dontrun{metric_score(%s(pkg_ref(\"%s\")))\n}"
  } else {
    "@examples metric_score(%s(pkg_ref(\"%s\")))"
  }

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
    "@family \\code{metric_score.*} functions",
    sprintf(example_template, assess_func, packageName()))
}
