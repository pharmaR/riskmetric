PackageReference <- function(pkg_dir, type) {

  type <- match.arg(
    type,
    c("Error", "Directory"),
    several.ok = FALSE
  )

  res <- as.environment(list(
    pkg_dir = pkg_dir
  ))

  class(res) <- c(sprintf("Package%s", type), "PackageReference", class(res))

  return(res)

}


#' @importFrom stringr str_extract
#' @importFrom httr GET content
#' @importFrom remotes install_github
#' @export
package_reference <- function(package, remote = getOption("repos")[1],
                              release = "latest", tmplib = ".rpackages") {

  package <- as.character(substitute(package))

  # if no remote is specified, return local package location
  # TODO: better copy - just in case
  if (is.null(remote))
    return(tryCatch({
        PackageReference(find.package(package), "Directory")
      }, error = function(e) {
        PackageReference(NULL, "Error") # TODO: should probably throw/store that error somewhere
      }))

  dir.create(tmplib, recursive = TRUE, showWarnings = FALSE)

  # download from github and install in temporary library
  if (grepl("^.+/.+$", package)) {
    # check name
    tryCatch({
      usr_name     <- stringr::str_extract(package, "^.+(?=/)")
      pkg_name     <- stringr::str_extract(package, "(?<=/).+$")
      request_char <- sprintf(
        "https://api.github.com/repos/%s/%s/releases/%s",
        usr_name,
        pkg_name,
        release
      )
      response <- httr::content(
        httr::GET(request_char), as = "parsed", type = "application/json"
      )
      remotes::install_github(package, ref = response$tag_name, lib = tmplib,
                              dependencies = TRUE, upgrade = TRUE,
                              destdir = tmplib,
                              INSTALL_opts = c("--install-tests"))
      return(PackageReference(normalizePath(sprintf("%s/%s", tmplib, pkg_name)), type = "Directory"))
    }, error = function(e) {
      return(PackageReference(NULL, "Error")) # TODO: should probably throw/store that error somewhere
    })
  }

  # try other repos
  return(tryCatch({
      install.packages(package, lib = tmplib, dependencies = TRUE,
                       destdir = tmplib, INSTALL_opts = c("--install-tests"))
      PackageReference(normalizePath(sprintf("%s/%s", tmplib, package)), type = "Directory")
    }, error = function(e) {
      PackageReference(NULL, type = "Error") # TODO: should probably throw/store that error somewhere
    }))

}
