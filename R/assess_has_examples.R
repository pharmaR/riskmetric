#' Assess a package for the presence of example or usage fields in function documentation
#'
#' @eval roxygen_assess_family(
#'   "has_examples",
#'   "an integer value indicating the proportion of discovered files with examples")
#'
#' @export
assess_has_examples <- function(x, ...) {
  UseMethod("assess_has_examples")
}

# assign a friendly name for examples column
attributes(assess_has_examples)$column_name <- "has_examples"
attributes(assess_has_examples)$label <- "proportion of discovered function files with examples"

#' @export
assess_has_examples.pkg_ref <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_has_examples",{
    x$examples
  })
}

#' Score a package for the presence of a example or usage fields
#'
#' Coerce a logical vector indicating availability of example or usage documentation
#'
#' @eval roxygen_score_family("has_examples")
#' @return \code{1} if any example or usage fields are found, otherwise \code{0}
#'
#' @export
metric_score.pkg_metric_has_examples <- function(x, ...) {
  if (length(x) > 0) {
    sum(x, na.rm = TRUE) / length(x)
  } else {
    NA
  }
}

attributes(metric_score.pkg_metric_has_examples)$label <-
  "A proportion of R documentation files with example or usage fields"
