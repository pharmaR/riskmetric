#' Helper for creating a roxygen header from template for assess_* functions
#'
#' @param name the name of the assessment, assuming naming conventions are
#'   followed
#' @param return_type an optional added commentary about the return type of the
#'   assessment function
#' @param dontrun logical indicating whether examples should be wrapped in
#'   a dontrun block. This is particularly useful for assessments which may
#'   require an internet connection.
#'
#' @return roxygen section template for assess family functions
#'
#' @examples
#' \dontrun{
#' #' @eval roxygen_assess_family(
#' #'   "has_news",
#' #'   "an integer value indicating the number of discovered NEWS files")
#' }
#'
roxygen_assess_family <- function(name,
    return_type = "an atomic assessment result",
    dontrun = FALSE) {

  assess_func <- sprintf("assess_%s", name)
  score_func <- sprintf("metric_score.pkg_metric_%s", name)
  example_template <- if (dontrun) {
    "@examples \n\\dontrun{\nassess_%s(pkg_ref(\"%s\"))\n}"
  } else {
    "@examples assess_%s(pkg_ref(\"%s\"))"
  }


  if (!assess_func %in% getNamespaceExports(utils::packageName()) ||
      !score_func %in% getNamespaceExports(utils::packageName())) {
    stop(sprintf(
      paste0(
        "All assess_* functions must have a corresponding score.* method ",
        "implemented.\n\n",
        "To remove build errors, ensure that the following functions are ",
        "implemented:\n\n",
        "  %s()\n",
        "  %s()\n"),
      assess_func,
      score_func))
  }

  c("@param x a \\code{pkg_ref} package reference object",
    "@param ... additional arguments passed on to S3 methods, rarely used",
    sprintf("@return a \\code{pkg_metric} containing %s", return_type),
    "@family \\code{assess_*} functions",
    sprintf("@seealso \\code{\\link{%s}}", score_func),
    sprintf(example_template, name, packageName()))
}



#' Helper for creating a roxygen itemized list for assess_* functions
#'
#' @return roxygen section template for assess family function catalog
#'
#' @examples
#' \dontrun{
#'   #' @eval assess_family_catalog_roxygen()
#' }
#'
roxygen_assess_family_catalog <- function() {
  assessments <- all_assessments()
  info <- lapply(assessments, attr, "label")
  missing_label <- vapply(info, is.null, logical(1L))
  info[missing_label] <- names(info)[missing_label]

  c("@section Assessment function catalog:",
    "\\describe{",
    sprintf('\\item{\\code{\\link{%s}}}{%s}', names(info), info),
    "}")
}



#' A default list of assessments to perform for each package
#'
#' @return a list of assess_* functions exported from riskmetric
#'
#' @importFrom utils packageName
#' @export
all_assessments <- function() {
  fs <- grep("^assess_[^.]*$",
    getNamespaceExports(utils::packageName()),
    value = TRUE)
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
  colname_null <- vapply(column_names, is.null, logical(1L))
  names(x)[!colname_null] <- column_names[!colname_null]
  names(x)[!nchar(names(x))] <- paste0("unnamed", seq_along(x[!nchar(names(x))]))
  x
}



#' Apply assess_* family of functions to a package reference
#'
#' By default, use all \code{assess_*} funtions in the \code{riskmetric}
#' namespace and produce a \code{\link[tibble]{tibble}} with one column per
#' assessment applied.
#'
#' @param x A single \code{\link{pkg_ref}} object or
#'   \code{\link[tibble]{tibble}} of package references to assess
#' @param assessments A list of assessment functions to apply to each package
#'   reference. By default, a list of all exported assess_* functions from the
#'   riskmetric package.
#' @param ... additional arguments unused
#' @param error_handler A function, which accepts a single parameter expecting
#'   the raised error, which will be called if any errors occur when attempting
#'   to apply an assessment function.
#'
#' @return A \code{\link[tibble]{tibble}} with one row per package reference and
#'   a new column per assessment function, with cells of that column as package
#'   metric objects returned when the assessment was called with the associated
#'   pacakge reference.
#'
#' @eval roxygen_assess_family_catalog()
#'
#' @family \code{assess_*} functions
#'
#' @importFrom tibble as_tibble
#' @importFrom vctrs new_list_of
#' @export
pkg_assess <- function(x, assessments = all_assessments(), ...,
    error_handler = assessment_error_empty) {
  UseMethod("pkg_assess")
}



#' @export
pkg_assess.pkg_ref <- function(x, assessments = all_assessments(), ...,
    error_handler = assessment_error_empty) {

  assessments <- use_assessments_column_names(assessments)
  xout <- list()

  for (i in seq_along(assessments)) {
    assessment_f <- assessments[[i]]
    assessment_name <- names(assessments)[[i]]

    xout[[assessment_name]] <- tryCatch({
      assessment_f(x)
    }, error = function(e) {
      error_handler(e, x$name, assessment_name)
    })

    attributes(xout[[assessment_name]])$label <- attributes(assessment_f)$label
  }

  vctrs::new_list_of(xout,
    structure(logical(), class = "pkg_metric"),
    class = "list_of_pkg_metric")
}



#' @export
pkg_assess.list_of_pkg_ref <- function(x, assessments = all_assessments(), ...,
    error_handler = assessment_error_empty) {

  pkg_assess(tibble::as_tibble(x),
    assessments = assessments,
    error_handler = error_handler)
}



#' @export
pkg_assess.tbl_df <- function(x, assessments = all_assessments(), ...,
    error_handler = assessment_error_empty) {

  assessments <- use_assessments_column_names(assessments)
  for (i in seq_along(assessments)) {
    assessment_f <- assessments[[i]]
    assessment_name <- names(assessments)[[i]]

    x[[assessment_name]] <- lapply(x$pkg_ref, function(pkg_ref) {
      tryCatch({
        assessment_f(pkg_ref)
      }, error = function(e) {
        error_handler(e, pkg_ref$name, assessment_name)
      })
    })

    x[[assessment_name]] <- vctrs::new_list_of(x[[assessment_name]],
      structure(logical(), class = "pkg_metric"),
      class = "list_of_pkg_metric")

    attributes(x[[assessment_name]])$label <- attributes(assessment_f)$label
  }

  x
}
