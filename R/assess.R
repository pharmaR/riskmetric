#' A default list of assessments to perform for each package
#'
#' @importFrom utils packageName
#' @export
#'
all_assessments <- function() {
  fs <- grep("^assess_", getNamespaceExports(utils::packageName()), value = TRUE)
  Map(getExportedValue, fs, ns = list(utils::packageName()))
}



#' Helper for retrieving a list of columns which contain pkg_metric objects
get_assessment_columns <- function(tbl) {
  vapply(tbl, inherits, logical(1L), "list_of_pkg_metric")
}



#' reassign assignment list names with column_name attribute if available
use_assessments_column_names <- function(x) {
  column_names <- lapply(x, attr, "column_name")
  names(x)[!sapply(column_names, is.null)] <- column_names
  x
}



#' Function for applying assess_* family of functions to packages
#'
#' @importFrom vctrs new_list_of
#' @export
#'
assess <- function(x, assessments = all_assessments(), ...,
    error = assessment_error_empty) {

  assessments <- use_assessments_column_names(assessments)
  for (i in seq_along(assessments)) {
    assessment_f <- assessments[[i]]
    assessment_name <- names(assessments)[[i]]

    x[[assessment_name]] <- lapply(x$pkg_ref, function(pkg_ref) {
      tryCatch(assessment_f(pkg_ref), error = error)
    })

    x[[assessment_name]] <- vctrs::new_list_of(x[[assessment_name]],
      structure(logical(), class = "pkg_metric"),
      class = "list_of_pkg_metric")
  }

  x
}
