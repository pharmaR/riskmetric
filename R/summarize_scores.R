#' Summarize a default set of assessments into a single risk score
#'
#' This function serves as an example for how a risk score might be derived.
#' Assuming all assessments provided by \code{riskmetric} are available in a
#' dataset, this function can be used to calculate a vector of risks.
#'
#' @param data a \code{\link[tibble]{tibble}} of scored assessments whose column
#'   names match those provided by riskmetric's \code{\link{pkg_assess}} function.
#' @param weights an optional vector of non-negative weights to be assigned to
#'   each assessment.
#'
#' @return a numeric vector of risk scores
#'
#' @examples
#' \dontrun{
#' library(dplyr)
#' summarize_scores(pkg_score(pkg_assess(as_tibble(pkg_ref("riskmetric")))))
#' }
#'
#' # or, using the cleaner dplyr syntax
#' \dontrun{
#' library(dplyr)
#' pkg_ref("riskmetric") %>%
#'   pkg_assess() %>%
#'   pkg_score() %>%
#'   summarize_scores()
#' }
#'
#' @export
summarize_scores <- function(data, weights = NULL) {
  UseMethod("summarize_scores")
}

#' @export
summarize_scores.data.frame <- function(data, weights = NULL) {
  if (missing(weights))
    weights <- add_default_weights(data)

  # perform checks and standardize weights
  weights <- standardize_weights(data, weights)

  # calculate 'quality' and subtract from 1 to get 'risk'
  qual <- colSums(apply(data[names(weights)], 1L, `*`, weights), na.rm = TRUE)
  risk <- 1 - qual

  risk
}

#' @export
summarize_scores.list <- function(data, weights = NULL) {
  if (missing(weights))
    weights <- add_default_weights(data)

  # perform checks and standardize weights
  weights <- standardize_weights(data, weights)
  1 - sum(as.numeric(data[names(weights)]) * weights, na.rm = TRUE)
}

# Set the default weight of each metric to 1.
add_default_weights <- function(data) {

  # ignore columns that are not of class 'pkg_score'
  ignore_cols <- c("package", "version", "pkg_ref", "pkg_score")
  metrics <- names(data)[!(names(data) %in% ignore_cols)]

  # assign a weight of 1 to each metric
  weights <- rep(1, length(metrics))
  names(weights) <- metrics

  weights
}

# Check that the provided weights are numeric and non-negative.
check_weights <- function(weights) {
  if (!is.numeric(weights))
    stop("The weights must be a numeric vector.")

  if (!all(weights >= 0))
    stop("The weights must contain non-negative values only.")
}

# Check weights values and standardize them.
standardize_weights <- function(data, weights) {

  # check that the weights vector is numeric and non-negative
  check_weights(weights)

  # re-weight for fields that are in the dataset
  weights <- weights[which(names(weights) %in% names(data))]

  # standardize weights from 0 to 1
  weights <- weights / sum(weights, na.rm = TRUE)
}
