#' @export
summarize_risk <- function(data) {
  data[is.na(data)] <- 0
  with(data, 1 - has_news)
}
