#' @importFrom backports import
#' @keywords internal
.onLoad <- function(libname, pkgname) {
  backports::import(pkgname, "isFALSE")

  # set default cache behaviors
  opts <- Filter(Negate(is.null), Map(function(i) i$default(), cache_behaviors))
  names(opts) <- sprintf("riskmetric.%s", names(opts))
  opts <- opts[!names(opts) %in% names(options())]
  do.call(options, as.list(opts))

  # set default options
  opts <- riskmetric.options
  names(opts) <- sprintf("riskmetric.%s", names(opts))
  opts <- opts[!names(opts) %in% names(options())]
  do.call(options, as.list(opts))

  # if non-interactive, cache package sources on load
  if (!interactive()) {
    memoise_available_packages()
    memoise_installed_packages()
  }
}
