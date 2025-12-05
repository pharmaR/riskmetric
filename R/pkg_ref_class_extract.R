#' @export
`$.pkg_ref` <- function(x, name) {
  `[[`(x, as.character(name))
}


#' @export
`$<-.pkg_ref` <- function(x, name, value) {
  `[[<-`(x, as.character(name), value = value)
}


#' Lazily instantiated, immutable metadata access
#'
#' If errors are thrown upon instantiation, they are saved and rethrown any time
#' the value is attempted to be accessed. These then propegate through
#' assessment and scoring functions to affect any downstream metrics.
#'
#' @param x pkg_ref object to extract metadata from
#' @param name name of metadata field to extract
#' @param ... additional arguments used to extract from internal environment
#'
#' @return a pkg_ref object
#' @export
#' @keywords internal
`[[.pkg_ref` <- function(x, name, ...) {
  if (!name %in% bare_env(x, names(x))) {
    allow_mutation(x, {
      pkg_ref_cache(x, name)
      ret <- tryCatch(pkg_ref_cache(x, name), error = function(e) e)
      x[[name]] <- ret
      if (inherits(ret, "error")) {
        stop(ret)
      }
      ret
    })
  } else {
    bare_env(x, {
      ret <- x[[name, ...]]
      if (inherits(ret, "error")) {
        stop(ret)
      }
      ret
    })
  }
}


#' @export
`[[<-.pkg_ref` <- function(x, name, value) {
  if (is.null(attr(x, "allowed_mutations"))) {
    stop(pkg_ref_mutability_error(name))
  }
  bare_env(x, x[[name]] <- value)
}


#' @export
`[.pkg_ref` <- function(x, ...) {
  dots <- list(x, ...)
  dots$FUN <- function(i, ...) x[[i, ...]]
  do.call(lapply, dots)
}


#' @export
`[<-.pkg_ref` <- function(x, names, value) {
  invisible(Map(
    function(name, value) {
      `[[<-`(x, name = name, value = value)
    },
    names,
    value
  ))
}


#' evaluate an expression with a  pkg_ref object reclassed as a bare environment
#' object, used to sidestep pkg_ref assignment guardrails
#'
#' @param x a \code{pkg_ref} object
#' @param expr an expression to evaluate, avoiding \code{pkg_ref} extraction
#'   handlers
#' @param envir an environment in which the expression is to be evaluated
#'
#' @return the result of \code{expr}
#' @keywords internal
bare_env <- function(x, expr, envir = parent.frame()) {
  old_class <- class(x)
  class(x) <- setdiff(class(x), "pkg_ref")
  on.exit(class(x) <- old_class)
  eval(expr, envir = envir)
}


#' pretty printing for a pkg_ref mutability error caused by trying to do
#' assignment within the pkg_ref without permission
#'
#' @param name name of field for which mutation was attempted
#' @return a \code{simplError} with subclasses \code{pkg_ref_mutability_error},
#'   \code{pkg_ref_error}
#' @keywords internal
pkg_ref_mutability_error <- function(name) {
  message <- list(paste0(
    "Assignment to a pkg_ref environment can only be done in a ",
    "pkg_ref_cache call."
  ))

  if (!missing(name)) {
    message <- append(
      message,
      list(paste0(
        "Extend the pkg_ref class by implementing function '",
        "pkg_ref_cache.",
        name,
        "'"
      ))
    )
  }

  e <- simpleError(message = paste(message, collapse = " "))
  class(e) <- c("pkg_ref_mutability_error", "pkg_ref_error", class(e))
  e
}


#' a wrapper to assert that a pkg_ref has been permitted to do an additional
#' mutation, used to handle recursive initialization of cached fields
#'
#' @param x a \code{pkg_ref} object
#' @param expr an expression to evaluate, and possible do a mutation within
#' @param envir an environment in which the expression is to be evaluated
#'
#' @return the result of \code{expr}
#' @keywords internal
allow_mutation <- function(x, expr, envir = parent.frame()) {
  inc_mutations_count(x)
  on.exit(dec_mutations_count(x))
  expr <- substitute(expr)
  eval(expr, envir = envir)
}


#' increment the number of allowed mutations
#'
#' @param x pkg_ref object to increment mutation counter for
#' @return a pkg_ref object
#' @keywords internal
inc_mutations_count <- function(x) {
  if (is.null(attr(x, "allowed_mutations"))) {
    attr(x, "allowed_mutations") <- 0
  }
  attr(x, "allowed_mutations") <- attr(x, "allowed_mutations") + 1
}


#' decrement the number of allowed mutations
#'
#' @param x pkg_ref object to decrement mutation counter for
#' @return pkg_ref object
#' @keywords internal
dec_mutations_count <- function(x) {
  attr(x, "allowed_mutations") <- attr(x, "allowed_mutations") - 1
  if (attr(x, "allowed_mutations") <= 0) attr(x, "allowed_mutations") <- NULL
}
