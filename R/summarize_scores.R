#' Summarize a default set of assessments into a single risk score
#'
#' This function serves as an example for how a risk score might be derived.
#' Assuming all assessments provided by \code{riskmetric} are available in a
#' dataset, this function can be used to calculate a vector of risks.
#'
#' @param data a \code{\link[tibble]{tibble}} of scored assessments whose column
#'   names match those provided by riskmetric's \code{\link{assess}} function.
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
summarize_scores <- function(data, weights = .risk_weights) {
  UseMethod("summarize_scores")
}

#' @export
summarize_scores.data.frame <- function(data, weights = .risk_weights) {
  weights <- add_default_weights(data, weights)

  # calculate 'quality' and subtract from 1 to get 'risk'
  qual <- colSums(apply(data[names(weights)], 1L, `*`, weights), na.rm = TRUE)
  risk <- 1 - qual

  # name if possible
  if ("package" %in% names(data))
    names(risk) <- data[["package"]]

  risk
}

#' @export
summarize_scores.list <- function(data, weights = .risk_weights) {
  weights <- add_default_weights(data, weights)

  1 - sum(as.numeric(data[names(weights)]) * weights, na.rm = TRUE)
}



#' Default weights to use for summarizing risk
#'
#' @export
.risk_weights <- c(
  news_current = 1,
  has_vignettes = 2,
  has_bug_reports_url = 2,
  bugs_status = 1,
  license = 0,
  export_help = 2,
  has_news = 1,
  covr_coverage = 3)

#' create vector of weights based on the data columms and user-given weights
#'
#' @param data a \code{\link[tibble]{tibble}} or list of scored assessments
#'   whose column names match those provided by riskmetric's \code{\link{assess}}
#'   function.
#' @param weights a set of numeric weights to give to each score column when
#'   calculating risk.
#'
#' @return a named vector with weights for each score column. If a
#' weight is not provided by the user, it will default to 1.
#'
add_default_weights <- function(data, weights) {
  # re-weight for fields that are in the dataset
  weights <- weights[which(names(weights) %in% names(data))]

  # add default weights of 1 to those assessments not in .risk_weights
  assessments <- vapply(data, inherits, logical(1L), "pkg_score")
  assessments <- names(assessments)[assessments]
  all_weights <- rep(1, length(assessments))
  names(all_weights) <- assessments
  all_weights[names(all_weights) %in% names(weights)] <- weights

  all_weights <- all_weights / sum(all_weights, na.rm = TRUE)

  return(all_weights)
}
