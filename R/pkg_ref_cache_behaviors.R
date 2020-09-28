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



#' Document both declare_cache_behavior parameters and options list
#'
#' @param fmt format of cache behavior entries
#' @param name_fmt special formating for name (first) component
#' @param annotation_fmt special formating for annotation (second) component
#' @param wrap_fmt a wrapper for the entirety of the roxygen entries
#' @param collapse passed to paste
#'
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
#' @param behaviors a character vector of behavior flags to assert as
#'   requirements for metadata caching. values must have an entry found in
#'   riskmetric:::cache_behaviors list
#'
require_cache_behaviors <- function(behaviors) {
  stopifnot(all(behaviors %in% names(cache_behaviors)))

  opt_names <- paste0(packageName(), ".", behaviors)
  names(opt_names) <- opt_names
  behaviors_disabled <- Filter(Negate(isTRUE), lapply(opt_names, getOption))

  if (length(behaviors_disabled)) {
    e <- simpleError(message = paste(
      "package metadata caching requires behaviors disabled by option(s)",
      paste0('"', names(behaviors_disabled), '"', collapse = ", ")))
    class(e) <- c("riskmetric_disabled_behavior_error", class(e))
    stop(e)
  }
}
