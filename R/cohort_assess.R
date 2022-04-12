#' Apply assess_* family of functions to a cohort reference
#'
#' By default, use all \code{assess_*} functions in the \code{riskmetric}
#' namespace and produce a \code{\link[tibble]{tibble}} with one column per
#' assessment applied.
#'
#' @param x A single \code{\link{cohort_ref}} object or
#'   \code{\link[tibble]{tibble}} of cohort references to assess
#' @param assessments A list of assessment functions to apply to each cohort
#'   reference. By default, a list of all exported assess_* functions from the
#'   riskmetric package.
#' @param ... additional arguments unused
#' @param error_handler A function, which accepts a single parameter expecting
#'   the raised error, which will be called if any errors occur when attempting
#'   to apply an assessment function.
#'
#' @return A \code{list_of_cohort_metric} object
#'
#'
#'
#' @importFrom tibble as_tibble
#' @importFrom vctrs new_list_of
#' @export
cohort_assess <- function(x, assessments = cohort_assessments(), ...,
                       error_handler = assessment_error_empty) {
  UseMethod("cohort_assess")
}

#' @export
cohort_assess.cohort_ref <- function(x, assessments = all_cohort_assessments(), ...,
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
                     structure(logical(), class = "cohort_metric"),
                     class = "list_of_cohort_metric")
}

#' A default list of assessments to perform for each package
#'
#' @return a list of assess_* functions exported from riskmetric
#'
#' @importFrom utils packageName
#' @export
all_cohort_assessments <- function() {
  fs <- grep("^assess_.+cohort_ref$",
             getNamespaceExports(utils::packageName()),
             value = TRUE)
  fs <- unique(gsub("\\..+", "", fs))
  Map(getExportedValue, fs, ns = list(utils::packageName()))
}
