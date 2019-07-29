#' Score a package assement, collapsing results into a single numeric
#'
#' @export
score <- function(x, ..., envir = parent.frame()) {
  UseMethod("score")
}



#' @rdname score
#' @export
score.default <- function(x, ..., envir = parent.frame()) {
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



#' @rdname score
#' @export
score.tbl_df <- function(x, ..., envir = parent.frame()) {
  assessment_columns <- get_assessment_columns(x)

  for (coln in which(assessment_columns)) {
    x[[coln]] <- vapply(x[[coln]], score, numeric(1L))
    class(x[[coln]]) <- c("pkg_score", class(x[[coln]]))
  }
  x
}
