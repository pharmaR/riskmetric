#' Assess a package for the presence of example or usage fields in function documentation
#'
#' @eval roxygen_assess_family(
#'   "has_examples",
#'   "an integer value indicating the number of discovered files with examples")
#'
#' @export
assess_has_examples <- function(x, ...) {
  UseMethod("assess_has_examples")
}

# assign a friendly name for examples column
attributes(assess_has_examples)$column_name <- "has_examples"
attributes(assess_has_examples)$label <- "number of discovered function files with examples"

#' @export
assess_has_examples.pkg_ref <- function(x, ...) {
  pkg_metric(class = "pkg_metric_has_examples", {
    length(x$examples)
  })
}

#' Score a package for the presence of a example or usage fields
#'
#' Coerce the number of example or usage fields to binary indication of examples
#'
#' @eval roxygen_score_family("has_examples")
#' @return \code{1} if any example or usage fields are found, otherwise \code{0}
#'
#' @export
metric_score.pkg_metric_has_examples <- function(x, ...) {
  as.numeric(x > 0)
}

attributes(metric_score.pkg_metric_has_examples)$label <-
  "A binary indicator of whether a package has associated example or usage fields"
