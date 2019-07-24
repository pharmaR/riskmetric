#' @export
score <- function(x, ...) {
  UseMethod("score")
}



#' @rdname score
#' @export
score.default <- function(x, ...) {
  if (!inherits(x, "pkg_metric")) {
    warning(sprintf(paste0(
        "Don't know how to score object of class %s. score is only intended ",
        "to be used with objects inheriting class 'pkg_metric', ",
        "returning default score of 0."),
      paste0('"', class(x), '"', collapse = ", ")))
  } else {
    warning(sprintf(paste0(
        "no available scoring algorithm for metric of class %s, ",
        "returning default score of 0."),
      paste0('"', class(x)[1], '"')))
  }

  0
}
