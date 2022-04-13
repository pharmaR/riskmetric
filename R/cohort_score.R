#' Score a cohort assessment, collapsing results into a single numeric
#' cohort_score() calculates the risk involved with using a cohort of packages. Risk ranges
#' from 0 (low-risk) to 1 (high-risk).
#'
#' @export
cohort_score <- function(x, ..., error_handler = score_error_default) {
  UseMethod("cohort_score")
}

#' @export
cohort_score.list_of_cohort_metric <- function(x, ...,
                                         error_handler = score_error_default) {

  metrics <- lapply(x, function(xi) {
    s <- metric_score(xi, error_handler = error_handler)
    metric_score_s3_fun <- firstS3method("metric_score", class(xi))
    attr(s, "label") <- attr(metric_score_s3_fun, "label")
    class(s) <- c("cohort_score", class(s))
    s
  })
  metrics[["cohort_score"]] <- summarize_scores(metrics, ...)
  return(metrics)
}
