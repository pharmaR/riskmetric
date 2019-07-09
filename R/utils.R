#' Accessor for tools namespace
#'
#' used internally for
#'   - tools:::.news_reader_default
.tools <- memoise::memoise(function() {
  getNamespace("tools")
})
