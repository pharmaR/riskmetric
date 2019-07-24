#' @export
print.pkg_ref <- function(x, ...) {
  xx <- as.list(x)
  ns <- names(xx)
  xs <- vapply(xx, function(xi) paste0(capture.output(xi), collapse = "\n"), character(1L))

  indent <- 2
  width <- (getOption("width") - indent) * 0.9

  cat(
    paste0(
      "$", ns, "\n",
      lapply(
        strwrap(xs, indent = indent, exdent = indent, width = width),
        paste,
        collapse = "\n"),
      collapse = "\n"),
    "\n\n",
    "<", paste(class(x)[which("pkg_ref" == class(x)):1], collapse = " - "), ">",
    sep = "")

  invisible(x)
}



#' Convert into a package object
#'
#' @param x character value representing a package name, path to a package
#'   source directory or a git remote url or a package object
#' @param ... additional arguments passed to class-specific handlers
#'
#' @return a package object
#'
#' @export
as.pkg_ref <- function(x, ...) {
  # called this class "package_meta" as to not conflict with devtools "package"
  UseMethod("as.pkg_ref")
}



#' @export
as.pkg_ref.default <- function(x, ...) {
  stop(sprintf(
    "Don't know how to convert object class '%s' to class 'pkg_ref'",
    paste(class(x), collapse = ", ")))
}



#' @export
as.pkg_ref.pkg_ref <- function(x, ...) {
  x
}



#' @importFrom utils installed.packages available.packages
#' @importFrom xml2 read_html
#' @export
as.pkg_ref.character <- function(x, repos = getOption("repos"), ...) {
  ip <- utils::installed.packages()
  ap <- utils::available.packages(repos = repos)
  cran_mirrors <- memoise_cran_mirros()
  bioc_mirrors <- memoise_bioc_mirrors()

  # case when only a package name is provided
  #   e.g. 'dplyr'
  # regex from available:::valid_package_name_regexp
  if (grepl("^[[:alpha:]][[:alnum:].]*[[:alnum:]]$", x)) {

    # if locally installed
    if (x %in% ip[,"Package"]) {
      return(pkg_ref(x,
        path = find.package(x),
        "pkg_install"))

    # if available at a provided repo
    } else if (x %in% ap[,"Package"]) {
      info <- ap[ap[,"Package"] == x,,drop = FALSE]
      repo <- info[,"Repository"]
      repo_base_url <- gsub("/src/contrib$", "", repo)
      tarball_url <- sprintf("%s/%s_%s.tar.gz", repo, x, info[,"Version"])
      pkg_ref <- pkg_ref(x, repo = repo, tarball_url = tarball_url, "pkg_remote")

      if (is_url_subpath_of(repo_base_url, c(cran_mirrors$URL, "https://cran.rstudio.com/"))) {
        pkg_ref$web_url <- sprintf("%s/web/packages/%s", repo_base_url, x)
        pkg_ref$web_html <- xml2::read_html(pkg_ref$web_url)
        class(pkg_ref) <- c("pkg_cran_remote", class(pkg_ref))

      } else if (is_url_subpath_of(repo_base_url, bioc_mirrors$URL)) {
        pkg_ref$web_url <- sprintf("%s/html/%s.html", repo_base_url, x)
        pkg_ref$web_html <- xml2::read_html(pkg_ref$web_url)
        class(pkg_ref) <- c("pkg_bioc_remote", class(pkg_ref))

      }

      return(pkg_ref)

    # if unable to locate a local or remote version of the package
    } else {
      return(pkg_ref(x, "pkg_missing"))
    }

  # case when a directory path to source code is provided
  #   e.g. '../dplyr'
  } else if (dir.exists(x) & file.exists(file.path(x, "DESCRIPTION"))) {
    desc <- read.dcf(file.path(x, "DESCRIPTION"))
    name <- unname(desc[,"Package"])

    return(pkg_ref(name, path = normalizePath(x), source = "pkg_source"))

  } else {
    stop(sprintf("can't interpret character '%s' as a package reference", x))
  }
}



pkg_ref <- function(name, source, ...) {
  dots <- list(...)
  if (length(dots) && is.null(names(dots)) || any(names(dots) == ""))
    stop("pkg_ref ellipses arguments must be named")

  source <- match.arg(
    source,
    c("pkg_remote", "pkg_install", "pkg_source", "pkg_missing"),
    several.ok = FALSE)

  pkg_data <- as.environment(append(list(
    name = name,
    source = source
  ), dots))

  structure(pkg_data, class = c(source, "pkg_ref", class(pkg_data)))
}
