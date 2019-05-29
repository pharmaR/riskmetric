
get_metrics <- function(pkgs) {
  if (!exists(pkgs))
    pkgs <- c(
      get_cran_packages()
      #get_bioconductor_packages()
    )

}


get_cran_packages <- function(pkgs, repo = "https://cran.r-project.com") {
  Map(function(pkg, version) {
    structure(pkg,
      repo = "cran.r-project.org",
      source = sprintf(
        "%s/src/contrib/%s_%s.tar.gz",
        repo,
        pkg,
        version),
      class = c("cran_package_ref", "package_ref", "character"))
  }, memoise_cran_db()$packages, memoise_cran_db()$version)
}
