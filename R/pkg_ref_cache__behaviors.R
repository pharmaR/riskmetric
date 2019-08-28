#' List of available caching behaviors with metadata, including default and
#' annotations for building documentation
cache_behaviors <- list(
  "per_package_request" = list(
    default = function() interactive(),
    annotation = paste0(
      "requires a web request for each package individually, which can be time ",
      "intensive and an irresponsible use of generously hosted public R ",
      "package repositories. It is recommended that this behavior is disabled ",
      "for metric assessments of large numbers of packages or assessments ",
      "triggered via automated scripts. Automatically disabled by default for ",
      "non-interactive use."))
)



#' Helper for documenting both declare_cache_behavior parameters and options
#' list
roxygen_cache_behaviors <- function(fmt = "%s: %s", name_fmt = "%s",
    annotation_fmt = "%s", wrap_fmt = "%s", collapse = "\n") {

  cache_behavior_names <- sprintf(name_fmt, names(cache_behaviors))
  cache_behavior_annotations <- sprintf(annotation_fmt,
    vapply(cache_behaviors, "[[", character(1L), "annotation"))

  sprintf(wrap_fmt, paste(
    sprintf(fmt, cache_behavior_names, cache_behavior_annotations),
    collapse = collapse))
}



#' Stop if a function requires disabled behaviors
#'
#' @eval roxygen_cache_behaviors(
#'   fmt = "@param %s %s",
#'   annotation_fmt = "declared when caching a value %s")
#'
require_cache_behaviors <- function(behaviors) {
  stopifnot(all(behaviors %in% names(cache_behaviors)))

  opt_names <- paste0(packageName(), ".", behaviors)
  names(opt_names) <- opt_names
  behaviors_disabled <- Filter(isFALSE, lapply(opt_names, getOption))

  if (length(behaviors_disabled)) {
    e <- simpleError(message = paste(
      "package metadata caching requires behaviors disabled by option(s)",
      paste0('"', names(behaviors_disabled), '"', collapse = ", ")))
    class(e) <- c("riskmetric_disabled_behavior_error", class(e))
    stop(e)
  }
}
