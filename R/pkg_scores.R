#' @export
pkg_scores <- function(x, ...) {
  as_pkg_scores(x)
}



#' @export
as_pkg_scores <- function(x, na.impute = NA_real_, ...) {
  structure(as.list(x),
    na.impute = na.impute,
    ...,
    class = c("pkg_scores", "list"))
}



#' @export
`$.pkg_scores` <- function(x, name) {
  x[[as.character(name)]]
}



#' @export
`[[.pkg_scores` <- function(x, name) {
  class(x) <- class(x)[which(class(x) != "pkg_scores")]
  if (as.character(name) %in% names(x)) x[[name]]
  else attr(x, "na.impute")
}



#' @export
`[.pkg_scores` <- function(x, i, ...) {
  orig_class <- class(x)
  class(x) <- class(x)[class(x) != "pkg_score"]
  out <- x[i, ...]
  out[is.null(out)] <- attr(x, "na.impute")
  if (is.character(i)) names(out) <- i
  out
}
