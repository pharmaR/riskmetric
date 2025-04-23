#' Assess a package for availability of documentation for exported values
#'
#' @eval roxygen_assess_family(
#'   "export_help",
#'   "a logical vector indicating existence of documentation for each namespace export")
#'
#' @export
assess_export_help <- function(x, ...) {
  UseMethod("assess_export_help")
}

attributes(assess_export_help)$column_name <- "export_help"
attributes(assess_export_help)$label <- "exported objects have documentation"



#' @export
assess_export_help.pkg_remote <- function(x, ...) {
  as_pkg_metric_na(
    pkg_metric(class = "pkg_metric_export_help"),
    message = "Cannot scrape exported documentation from a remote package webpage")
}


#' @importFrom pkgload parse_ns_file
#' @export
assess_export_help.pkg_source <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_export_help", {
    # ignore S3-dispatched methods
    lines <- readLines(paste0(x$path, "/NAMESPACE"), warn = FALSE)
    export_lines <- grep("^export\\(|^exportMethods\\(", lines, value = TRUE)
    exports <- gsub(".*\\(([^)]+)\\).*", "\\1", export_lines)
    exports <- unlist(strsplit(exports, ",\\s*"))

    out <- exports %in% names(x$help_aliases)
    names(out) <- exports
    out
  })
}



#' @export
assess_export_help.pkg_install <- function(x, ...) {
  pkg_metric_eval(class = "pkg_metric_export_help", {
    # ignore S3-dispatched methods
    exports <- getNamespaceExports(x$name)
    out <- exports %in% names(x$help_aliases)
    names(out) <- exports
    out
  })
}

#' Score a package for availability of documentation for exported values
#'
#' Coerce a logical vector indicating availability of export documentation
#'
#' @eval roxygen_score_family("export_help")
#' @return \code{1} if any NEWS files are found, otherwise \code{0}
#'
#' @export
metric_score.pkg_metric_export_help <- function(x, ...) {
  sum(x, na.rm = TRUE) / length(x)
}

attributes(metric_score.pkg_metric_export_help)$label <-
  "The fraction of exported objects that are documented."



#' #' Provide development hints for improving exported value documentation
#' #' @inheritParams dev_tips
#' dev_tips.pkg_metric_export_help <- function(x, ...) {
#'   x_sorted <- x[order(names(x))]
#'   x_sorted <- sort(x_sorted, decreasing = TRUE)
#'
#'   max_nchar <- max(nchar(names(x_sorted)))
#'   row_n <- (getOption("width") / (max_nchar + 2)) %/% 1
#'   max_nchar <- (getOption("width") / row_n) %/% 1
#'
#'   text <- paste0(
#'     ifelse(x_sorted,
#'       dev_hint_crayon_success("\u2713"),  # check mark
#'       dev_hint_crayon_failure("\u2718")), # x mark
#'     names(x_sorted),
#'     strrep(" ", max_nchar - nchar(names(x_sorted))))
#'
#'   dev_hint(
#'     title = "Documenting Exported Objects",
#'     text = list(
#'       dev_hint_section("Not all exported objects have help documentation."),
#'       dev_hint_section(paste0(
#'         "Consider adding [.Rd help files](https://cran.r-project.org/doc/manuals/R-exts.html#Writing-R-documentation-files) ",
#'         "or use [roxygen2](https://cran.r-project.org/web/packages/roxygen2/vignettes/roxygen2.html) ",
#'         "to document your functions alongside the source code.")),
#'       dev_hint_section(paste0(text,
#'         ifelse(seq_along(text) %% row_n == 0, "\n", ""),
#'         collapse = ""),
#'         list(wrap = FALSE))))
#' }
