#' Summarize a default set of assessments into a single risk score
#'
#' This function serves as an example for how a risk score might be derived.
#' Assuming all assessments provided by \code{riskmetric} are available in a
#' dataset, this function can be used to calculate a vector of risks.
#'
#' @param data a \code{\link[tibble]{tibble}} of scored assessments whose column
#'   names match those provided by riskmetric's \code{\link{assess}} function.
#' @param weights a set of numeric weights to give to each score column when
#'   calculating risk
#'
#' @return a numeric vector of risk scores
#'
#' @examples
#' \dontrun{
#' library(dplyr)
#' summarize_risk(score(assess(as_tibble(pkg_ref("riskmetric")))))
#' }
#'
#' # or, using the cleaner dplyr syntax
#' \dontrun{
#' library(dplyr)
#' pkg_ref("riskmetric") %>%
#'   as_tibble() %>%
#'   assess() %>%
#'   score() %>%
#'   mutate(risk = summarize_risk(.))
#' }
#'
#' @export
summarize_risk <- function(data, weights = .risk_weights) {
  # re-weight for fields that are in the dataset
  weights <- weights[which(names(weights) %in% names(data))]
  weights <- weights / sum(weights, na.rm = TRUE)

  # calculate 'quality' and subtract from 1 to get 'risk'
  qual <- colSums(apply(data[names(weights)], 1L, `*`, weights), na.rm = TRUE)
  risk <- 1 - qual

  # name if possible
  if ("package" %in% names(data))
    names(risk) <- data[["package"]]

  risk
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
