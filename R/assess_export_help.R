#' Assess a package for availability of documentation for exported values
#'
#' @eval assess_family_roxygen(
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
assess_export_help.pkg_install <- function(x) {
  # ignore S3-dispatched methods
  exports <- getNamespaceExports(x$name)
  out <- exports %in% names(x$help_aliases)
  names(out) <- exports
  pkg_metric(out, class = "pkg_metric_export_help")
}



#' Score a package for availability of documentation for exported values
#'
#' Coerce a logical vector indicating availability of export documentation
#'
#' @eval score_family_roxygen("export_help")
#' @return \code{1} if any NEWS files are found, otherwise \code{0}
#'
#' @export
score.pkg_metric_export_help <- function(x) {
  sum(x, na.rm = TRUE) / length(x)
}
