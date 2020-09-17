#' If not NULL else
#'
#' @param lhs Left-hand side
#' @param rhs Right-hand side
#'
#' A shorthand for a common comparison
#'
#' @name if_not_null_else
`%||%` <- function(lhs, rhs) if (is.null(lhs)) rhs else lhs



#' Accessor for tools namespace
#'
#' used internally for
#'   - tools:::.news_reader_default
.tools <- memoise::memoise(function() {
  getNamespace("tools")
})



#' check if a url originates from a list of repo urls
#'
#' @param url a url which may stem from one of the provided base urls
#' @param urls vector of base urls
#'
#' @return logical vector indicating which base urls have a sub url of
#'   \code{url}
#'
is_url_subpath_of <- function(url, urls) {
  grepl(paste0("(", paste0(gsub("/$", "", urls), collapse = "|"), ")"), url)
}



#' Return a vector of random uninstalled packages
#'
#' @return a character vector of random package names
#'
#' @importFrom tools CRAN_package_db
#' @importFrom utils installed.packages
not_installed_packages <- function() {
  installeddb <- utils::installed.packages()
  crandb <- memoise_cran_db()

  installed_packages <- installeddb[,"Package"]
  cran_packages <- crandb[["package"]]

  unname(setdiff(cran_packages, installed_packages))
}



#' Return a vector of random installed packages
#'
#' @param ... additional arguments unused
#' @return a character vector of random package names
#'
#' @importFrom tools CRAN_package_db
#' @importFrom utils installed.packages
installed_packages <- function(...) {
  installeddb <- utils::installed.packages()
  unname(installeddb[,"Package"])
}



#' Evaluate an expression after first removing a range of S3 classes
#'
#' @param x a structured S3-classed object
#' @param .class the class to unclass the object to
#' @param expr an expression to evaluate, avoiding parent classs dispatch
#' @param envir an environment in which the expression is to be evaluated
#'
#' @return the result of \code{expr}
#'
with_unclassed_to <- function(x, .class = 1:length(class(x)), expr,
    envir = parent.frame()) {

  x_expr <- substitute(x)
  orig_class <- class(x)
  if (is.character(.class)) .class = 1:which(class(x) == .class)

  eval(bquote(class(.(x_expr)) <- class(.(x_expr))[-.(.class)]), envir = envir)
  out <- eval(expr, envir = envir)
  eval(bquote(class(.(x_expr)) <- .(orig_class)), envir = envir)
  out
}



#' Capture side effects issued by an evaluated expression
#'
#' All messaging condition side effects are captured in the order that they
#' are issued.
#'
#' @param expr an expression to evaluate, capturing output events as they
#'   are issued
#'
capture_expr_output <- function(expr) {
  env <- environment()

  log_file <- tempfile("riskmetric_console_sink_", fileext = ".txt")
  log_file_con <- file(log_file, "w")
  on.exit(try(close(log_file_con), silent = TRUE))

  error <- NULL
  cnds_seek <- numeric()
  cnds <- list() # messages + warnings + misc conditions

  append_cnd <- function(cnd, envir) {
    cnd_seek <- seek(log_file_con)
    assign("cnds_seek", append(cnds_seek, cnd_seek), envir = env)
    assign("cnds", append(cnds, list(cnd)), envir = env)
  }

  capture.output(
    file = log_file_con,
    withCallingHandlers(
      tryCatch(expr, error = function(e) {
        append_cnd(e, env)
      }),
      condition = function(cnd) {
        append_cnd(cnd, env)
        if      (inherits(cnd, "warning")) invokeRestart('muffleWarning')
        else if (inherits(cnd, "message")) invokeRestart('muffleMessage')
      })
  )

  # close log file and read in lines
  close(log_file_con)
  log_text <- readLines(log_file, warn = FALSE)

  if (length(cnds)) {
    # NOTE: Windows might use two newline characters "\r\n"?
    log_newlines <- cumsum(nchar(log_text) + 1L)

    # rejoin into singular string to split at newlines, as well as any condition
    # emission points
    log_text <- paste0(log_text, collapse = "\n")
    log_cuts <- sort(unique(c(log_newlines, cnds_seek)))
    log_cuts <- log_cuts[log_cuts < nchar(log_text)]
    log_text <- substring(log_text, c(1, log_cuts + 1L), c(log_cuts, nchar(log_text)))
    log_chars <- cumsum(nchar(log_text))

    # find where to insert emitted conditions among output
    cnd_i <- match(cnds_seek, log_chars)
    cnds_new_index <- cnd_i + seq_along(cnd_i)

    # inject conditions throughout console output as they were emitted
    outputs <- rep(list(NULL), length(log_text) + length(cnds_new_index))
    outputs[cnds_new_index] <- cnds
    outputs[-cnds_new_index] <- log_text
  } else {
    outputs <- log_text
  }

  structure(
    substitute(expr),
    traceback = .traceback(3L),
    output = outputs,
    class = c("expr_output", "expression"))
}


#' Handle pretty printing of expression output
#'
#' @param x expr_output to print
#' @param ... additional arguments unused
#'
#' @export
#'
print.expr_output <- function(x, ...) {
  crayon_gray <- crayon::make_style(rgb(.5, .5, .5))

  x_call <- as.call(as.list(x))

  if (x_call[[1]] == "{") {
    x_call_str <- vapply(
      x_call[-1],
      function(xi) paste0(capture.output(xi), collapse = "\n"),
      character(1L))
  } else {
    x_call_str <- capture.output(x_call)
  }

  x_call_str[1] <- paste(">", x_call_str[1])
  x_call_str[-1] <- paste("+", x_call_str[-1])
  str_call <- crayon::blue(paste(x_call_str, collapse = "\n"))

  str_output <- sprintf(
    "%s %s",
    crayon_gray("#"),
    unlist(
      crayon::col_strsplit(
        vapply(attr(x, "output"), function(xi) {
          if (inherits(xi, "message"))
            crayon::red(.makeMessage(gsub("\n$", "", xi$message)))
          else if (inherits(xi, "warning"))
            crayon::red(sprintf("Warning message:\n%s", xi$message))
          else if (inherits(xi, "error"))
            crayon::red("Error:", xi$message)
          else if (inherits(xi, "condition"))
            crayon::red(.makeMessage(xi))
          else xi
        }, character(1L)),
        "\n")))

  x_has_error <- any(vapply(attr(x, "output"), inherits, logical(1L), "error"))
  str_traceback <- paste(
    sprintf(
      "%s   %s",
      crayon_gray("#"),
      capture.output(traceback(attr(x, "traceback")))),
    collapse = "\n")

  strs <- c(
    str_call,
    str_output,
    if (x_has_error) crayon_gray(str_traceback)
  )

  cat(paste(strs, collapse = "\n"))
}
