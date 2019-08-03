#' @export
summarize_risk <- function(data) {
  data[is.na(data)] <- 0
  with(data, round(1 - has_news * 0.8 - news_current * 0.2, 3))
}
