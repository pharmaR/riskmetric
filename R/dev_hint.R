#' dev_hint <- function(title, text, format_args = list()) {
#'   if (is.character(text)) text <- list(dev_hint_section(text))
#'   data <- list(
#'     title = title,
#'     text = text,
#'     format_args = format_args)
#'   structure(data, class = c("dev_hint", class(data)))
#' }
#'
#'
#'
#' dev_hint_section <- function(text, format_args = list(wrap = TRUE)) {
#'   structure(text,
#'     format_args = format_args,
#'     class = c("dev_hint_section", class(text)))
#' }
#'
#'
#'
#' dev_hint_crayon_title_style <- crayon::make_style(rgb(0.1, 0.2, 0.6))
#' dev_hint_crayon_title <- function(...)
#'   crayon::bold(dev_hint_crayon_title_style(...))
#'
#' dev_hint_crayon_link <- crayon::make_style(rgb(0.1, 0.6, 0.4))
#' dev_hint_crayon_success <- crayon::make_style(rgb(0.15, 0.7, 0.15))
#' dev_hint_crayon_failure <- crayon::make_style(rgb(0.8, 0.2, 0.2))
#'
#'
#'
#' #' @importFrom utils modifyList
#' #' @export
#' print.dev_hint <- function(x, ...) {
#'   dots <- utils::modifyList(x$format_args, list(...))
#'   cat(do.call(format, c(list(x), dots)))
#' }
#'
#'
#'
#' #' @export
#' format.dev_hint <- function(x, use_crayon = TRUE, wrap = FALSE, ...) {
#'   text_refs <- lapply(x$text, strip_dev_hint_section_links)
#'   text <- lapply(text_refs, "[[", "text")
#'   refs <- unlist(lapply(text_refs, "[[", "refs"))
#'
#'   refs <- paste0(
#'     dev_hint_crayon_link("[", seq_along(refs), "] ", refs, sep = ""),
#'     collapse = "\n")
#'
#'   text <- append(text, list(dev_hint_section(refs, list(wrap = FALSE))))
#'   text <- lapply(text, function(i) {
#'     do.call(format, append(list(i), attr(i, "format_args")))
#'   })
#'
#'   paste0(dev_hint_crayon_title(x$title), "\n", paste(text, collapse = "\n\n"))
#' }
#'
#'
#' strip_dev_hint_section_links <- function(x, use_crayon = TRUE, ref_index_start = 1) {
#'   # find markdown links in text
#'   md_link_re <- "(?<link>\\[(?<text>[^]]+)\\]\\((?<url>[^)]+)\\))"
#'   md_link <- gregexpr(md_link_re, x, perl = TRUE)[[1]]
#'   md_link_start <- attr(md_link, "capture.start")
#'   md_link_end <- md_link_start + attr(md_link, "capture.length") - 1
#'
#'   # match named regex groups
#'   if (all(md_link == -1)) {
#'     refs <- matrix(ncol = ncol(attr(md_link, "capture.start")))[c(),]
#'   } else {
#'     refs <- matrix(substring(x,
#'         first = md_link_start,
#'         last  = md_link_end),
#'       ncol = ncol(attr(md_link, "capture.start")))
#'   }
#'   colnames(refs) <- attr(md_link, "capture.names")
#'
#'   # break text on md links
#'   text <- substring(x,
#'     first = c(0, md_link_start[,"link"]),
#'     last = c(md_link_start[,"link"] - 1, 1e6L))
#'
#'   # remove md links
#'   text[-1] <- substring(text[-1],
#'     first = attr(md_link, "capture.length")[,"link"] + 1,
#'     last = 1e6L)
#'
#'   # add back in link text
#'   text[-1] <- paste0(refs[,"text"],
#'     if (nrow(refs))
#'       dev_hint_crayon_link("[", ref_index_start + seq_along(refs[,"text"]) - 1, "]", sep = ""),
#'     text[-1])
#'   text <- paste(text, collapse = "")
#'
#'   # rejoin with original attributes
#'   attributes(text) <- attributes(x)
#'
#'   # return both modified text, as well as scraped references
#'   list(
#'     text = text,
#'     refs = refs[,"url"])
#' }
#'
#'
#' format.dev_hint_section <- function(x, use_crayon = TRUE, wrap = TRUE) {
#'   if (wrap)
#'     paste0(fansi::strwrap_ctl(x, indent = 2, exdent = 2), collapse = "\n")
#'   else
#'     paste0("  ", strsplit(x, "\n")[[1]], collapse = "\n")
#' }
