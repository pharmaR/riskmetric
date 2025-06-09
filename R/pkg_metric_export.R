# Converts snake_case to PascalCase
to_pascal_case <- function(x) {
  words <- strsplit(x, "_")[[1]]
  paste0(toupper(substring(words, 1, 1)), substring(words, 2), collapse = "")
}

#' Flatten scored metrics to DCF-style key-value pairs
#'
#' `pkg_metric_export()` converts scored package metrics into a flat list of
#' character strings in DCF (Debian Control File) style. Each metric is
#' written as a line in the form `Metric<Name>: <value>`, where `<Name>` is the
#' PascalCase transformation of the metric name.
#'
#' This is useful for exporting results from `pkg_score()` into formats that
#' require simple key-value structures.
#'
#' @param x A `tbl_df` or `list` returned by `pkg_score()`, containing scored
#'   `pkg_metric` values. The input may come from `pkg_score.tbl_df()` (for
#'   many packages) or `pkg_score.list_of_pkg_metric()` (for a single package).
#' @param ... additional arguments unused
#'
#' @return A character vector, where each element is a DCF-style line
#'   representing one scored metric (e.g., `"MetricHasNews: 1"`).
#'
#' @examples
#' \dontrun{
#' # For a single package
#' metrics <- pkg_score(pkg_assess(pkg_ref("riskmetric")))[[1]]
#' pkg_metric_export(metrics)
#'
#' # For a data frame of packages
#' library(dplyr)
#' scores <- pkg_score(pkg_assess(as_tibble(pkg_ref("riskmetric"))))
#' pkg_metric_export(scores[1, ])  # flatten first package's results
#' }
#'
#' @export
pkg_metric_export <- function(x, ...) {
  UseMethod("pkg_metric_export")
}

#' @export
pkg_metric_export.list <- function(x, file = "PACKAGES", ...) {
  record <- list()
  for (name in names(x)) {
    pascal_name <- paste0("Metric", to_pascal_case(name))
    value <- as.character(x[[name]][1])

    # Replace NA values with "NA" string
    record[[pascal_name]] <- ifelse(is.na(value), "NA", value)
  }

  # Convert to one-row data frame
  df <- as.data.frame(record, stringsAsFactors = FALSE)
  write.dcf(df, file = file)
  df
}

#' @export
pkg_metric_export.tbl_df <- function(x, file = "PACKAGES", ...) {
  x <- x[, setdiff(names(x), "pkg_ref")]

  records <- lapply(seq_len(nrow(x)), function(i) {
    row <- x[i, , drop = FALSE]
    record <- list()

    for (name in names(row)) {
      value <- as.character(row[[name]])

      # Replace NA values with "NA" string
      value <- ifelse(is.na(row[[name]]), "NA", value)

      # Leave Package and Version untouched
      if (name %in% c("package", "version")) {
        pascal_name <- paste0(toupper(substring(name, 1, 1)), substring(name, 2))
        record[[pascal_name]] <- value
      } else {
        pascal_name <- paste0("Metric", to_pascal_case(name))
        record[[pascal_name]] <- value
      }
    }

    record
  })

  df <- do.call(rbind.data.frame, lapply(records, as.data.frame, stringsAsFactors = FALSE))
  write.dcf(df, file = file)
  df
}
