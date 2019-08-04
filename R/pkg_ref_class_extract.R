#' @export
`$.pkg_ref` <- function(x, name) {
  `[[`(x, as.character(name))
}



#' @export
`$<-.pkg_ref` <- function(x, name, value) {
  `[[<-`(x, name, value = value)
}



#' @export
`[[.pkg_ref` <- function(x, name, ...) {
  if (!name %in% names(x))
    allow_mutation(x, x[[name]] <- pkg_ref_cache(x, name))
  else
    bare_env(x, x[[name, ...]])
}



#' @export
`[[<-.pkg_ref` <- function(x, name, value) {
  if (is.null(attr(x, "allowed_mutations")))
    stop(pkg_ref_mutability_error(name))
  bare_env(x, x[[name]] <- value)
}



#' @export
`[.pkg_ref` <- function(x, names, ...) {
  lapply(names, function(n, ...) x[[n, ...]], ...)
}



#' @export
`[<-.pkg_ref` <- function(x, names, value) {
  invisible(Map(function(name, value) {
    `[[<-`(x, name = name, value = value)
  }, names, value))
}



#' evaluate an expression with a  pkg_ref object reclassed as a bare environment
#' object, used to sidestep pkg_ref assignment guardrails
bare_env <- function(x, expr, envir = parent.frame()) {
  old_class <- class(x)
  class(x) <- "environment"
  on.exit(class(x) <- old_class)
  eval(expr, envir = envir)
}



#' pretty printing for a pkg_ref mutability error caused by trying to do
#' assignment within the pkg_ref without permission
pkg_ref_mutability_error <- function(name) {
  message <- list(paste0(
    "Assignment to a pkg_ref environment can only be done in a ",
    "pkg_ref_cache call."))

  if (!missing(name)) message <- append(message, list(paste0(
    "Extend the pkg_ref class by implementing function '",
    "pkg_ref_cache.", name, "'")))

  e <- simpleError(message = paste(message, collapse = " "))
  class(e) <- c("pkg_ref_mutability_error", "pkg_ref_error", class(e))
  e
}



#' a wrapper to assert that a pkg_ref has been permitted to do an additional
#' mutation, used to handle recursive initialization of cached fields
allow_mutation <- function(x, expr, envir = parent.frame()) {
  expr <- substitute(expr)

  if (is.null(attr(x, "allowed_mutations"))) attr(x, "allowed_mutations") <- 0
  attr(x, "allowed_mutations") <- attr(x, "allowed_mutations") + 1

  on.exit({
    attr(x, "allowed_mutations") <- attr(x, "allowed_mutations") - 1
    if (attr(x, "allowed_mutations") <= 0) attr(x, "allowed_mutations") <- NULL
  })

  eval(expr, envir = envir)
}
