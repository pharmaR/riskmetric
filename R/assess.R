#' A default list of assessments to perform for each package
#'
#' @return a list of assess_* functions exported from riskmetric
#'
#' @importFrom utils packageName
#' @export
all_assessments <- function() {
  fs <- grep("^assess_", getNamespaceExports(utils::packageName()), value = TRUE)
  Map(getExportedValue, fs, ns = list(utils::packageName()))
}



#' Helper for retrieving a list of columns which contain pkg_metric objects
#'
#' @param tbl a \code{\link[tibble]{tibble}} to select columns among
#'
#' @return a logical vector of \code{pkg_metric} column indices
#'
get_assessment_columns <- function(tbl) {
  vapply(tbl, inherits, logical(1L), "list_of_pkg_metric")
}



#' reassign assignment list names with column_name attribute if available
#'
#' @param x list of columns for which to consider friendly column name
#'   attributes
#'
#' @return a vector of friendly column names if available
#'
use_assessments_column_names <- function(x) {
  column_names <- lapply(x, attr, "column_name")
  names(x)[!sapply(column_names, is.null)] <- column_names
  x
}



#' Function for applying assess_* family of functions to packages
#'
#' @param x A single package reference object or \code{\link[tibble]{tibble}} of
#'   package references to assess
#' @param assessments A list of assessment functions to apply to each package
#'   reference. By default, a list of all exported assess_* functions from the
#'   riskmetric package.
#' @param ... additional arguments unused
#' @param error A function, which accepts a single parameter expecting the
#'   raised error, which will be called if any errors occur when attempting to
#'   apply an assessment function.
#'
#' @return A \code{\link[tibble]{tibble}} with one row per package reference and
#'   a new column per assessment function, with cells of that column as package
#'   metric objects returned when the assessment was called with the associated
#'   pacakge reference.
#'
#' @seealso as_tibble.pkg_ref
#'
#' @importFrom tibble as_tibble
#' @importFrom vctrs new_list_of
#' @export
assess <- function(x, assessments = all_assessments(), ...,
    error = assessment_error_as_warning) {

  x <- tibble::as_tibble(x)
  assessments <- use_assessments_column_names(assessments)

  for (i in seq_along(assessments)) {
    assessment_f <- assessments[[i]]
    assessment_name <- names(assessments)[[i]]

    x[[assessment_name]] <- lapply(x$pkg_ref, function(pkg_ref) {
      tryCatch(assessment_f(pkg_ref), error = function(e) {
        error(e, pkg_ref$name, assessment_name)
      })
    })

    x[[assessment_name]] <- vctrs::new_list_of(x[[assessment_name]],
      structure(logical(), class = "pkg_metric"),
      class = "list_of_pkg_metric")

    attributes(x[[assessment_name]])$label <- attributes(assessment_f)$label
  }

  x
}



#' Helper for creating a roxygen header from template for assess_* functions
#'
#' @param name the name of the assessment, assuming naming conventions are
#'   followed
#' @param return_type an optional added commentary about the return type of the
#'   assessment function
#'
#' @return roxygen section template for assess family functions
#'
#' @examples
#' \dontrun{
#'   #' @eval assess_family_roxygen(
#'       "has_news",
#'       "an integer value indicating the number of discovered NEWS files")
#' }
#'
assess_family_roxygen <- function(name,
    return_type = "an atomic assessment result") {

  assess_func <- sprintf("assess_%s", name)
  score_func <- sprintf("score.pkg_metric_%s", name)

  stopifnot(assess_func %in% getNamespaceExports(utils::packageName()))
  stopifnot(score_func %in% getNamespaceExports(utils::packageName()))

  c("@param x a \\code{pkg_ref} package reference object",
    "@param ... additional arguments passed on to S3 methods, rarely used",
    sprintf("@return a \\code{pkg_metric} containing %s", return_type),
    "@family \\code{assess_*} functions",
    sprintf("@seealso \\code{\\link{%s}}", score_func),
    sprintf("@examples assess_%s(pkg_ref(\"%s\"))", name, packageName()))
}
