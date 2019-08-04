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
summarize_risk <- function(data, weights = NULL) {
  # allow overwriting with custom weights if desired
  if (is.null(weights))
    weights <- c(
      has_news = 0.4,
      export_help = 0.4,
      news_current = 0.2)

  # ensure we're
  weights <- weights[which(names(weights) %in% names(data))]
  weights <- weights / sum(weights, na.rm = TRUE)

  # calculate risks
  1 - rowSums(as.matrix(data[names(weights)]) %*% weights, na.rm = TRUE)
}
