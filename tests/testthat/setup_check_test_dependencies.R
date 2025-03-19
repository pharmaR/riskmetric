test_suggests <- c(
  "testthat",
  "webmockr",
  "jsonlite",
  "magrittr",
  "withr"
)

has_dep <- vapply(test_suggests, requireNamespace, logical(1L), quietly = TRUE)
if (!all(has_dep)) {
  install_code <- bquote(install.packages(.(test_suggests[!has_dep])))
  stop(
    "missing Suggests dependencies necessary for testing:\n",
    paste0("  ", test_suggests[!has_dep], collapse = "\n"), "\n\n",
    "resolve with:\n",
    paste0("  ", deparse(install_code), collapse = "\n"), "\n\n"
  )
}
