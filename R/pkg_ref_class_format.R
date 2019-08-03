#' @importFrom utils head capture.output
#' @export
print.pkg_ref <- function(x, ...) {
  xx <- as.list(x)
  ns <- names(xx)
  ns_unused <- setdiff(available_pkg_ref_fields(x), ns)

  indent <- 2
  width <- 0.95 * getOption("width")

  xs <- vapply(xx, function(xi) {
    truncated <- FALSE
    if (length(xi) > 5) truncated <- TRUE

    x_str <- utils::capture.output(head(xi))
    x_str <- gsub("\\s+$", "", x_str)
    x_str <- gsub(sprintf("(.{%0.f})", width - indent), "\\1\n", x_str)
    x_str <- unlist(strsplit(x_str, "\n"))
    if (length(x_str) > 5) truncated <- TRUE

    if (truncated) x_str <- c(head(x_str), "<continued>")
    paste0(strrep(" ", indent), x_str, collapse = "\n")
  }, character(1L))

  cat(
    "<", paste(class(x)[1:which("pkg_ref" == class(x))], collapse = ", "), "> ",
    x$name, " v", as.character(x$version), "\n",
    if (length(ns)) paste0("$", ns, "\n", xs, collapse = "\n"),
    if (length(ns)) "\n",
    if (length(ns_unused)) paste0("$", ns_unused, "...", collapse = "\n"),
    if (length(ns_unused)) "\n",
    sep = "")

  invisible(x)
}



#' @export
vec_ptype_abbr.pkg_ref <- function(x, ...) {
  "pkg_ref"
}



#' @export
vec_cast.character.list_of_pkg_ref <- function(x, to) {
  vapply(x, "[[", character(1L), "name")
}



#' @export
format.pkg_ref <- function(x, ...) {
  class_str <- gsub("^pkg_", "", class(x)[[1]])
  paste0(x$name, pillar::style_subtle(paste0("<", class_str, ">")))
}



#' @export
format.pkg_missing <- function(x, ...) {
  class_str <- gsub("^pkg_", "", class(x)[[1]])
  pillar::style_na(paste0(x$name, "<", class_str, ">"))
}
