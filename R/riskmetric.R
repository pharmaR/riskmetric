#' Get Risk Metric
#'
#' Temporary Function, under development
#'
#' @import dplyr
#' @importFrom tools CRAN_package_db package_dependencies
#' @importFrom BiocPkgTools biocPkgList
#' @importFrom BiocManager repositories
#'
get_riskmetric <- function(){
  cran_db <- tools::CRAN_package_db()
  cran_db1 <- cran_db[, c("Package", "Version", "License", "Copyright",
    "Author", "BugReports", "Maintainer", "Published", "Title", "URL")]

  bioc_db <- BiocPkgTools::biocPkgList()
  bioc_db1 <- bioc_db[, c("Package", "Version", "License", # Copyright not available
    "Author", "BugReports", "Maintainer", "Date/Publication", "Title", "URL")]
  bioc_db1$Author <- sapply(bioc_db1$Author, paste, collapse = ", ")
  bioc_db1$Maintainer <- sapply(bioc_db1$Maintainer, paste, collapse = ", ")
  bioc_db1 <- bioc_db1 %>% rename(Published = `Date/Publication`)

  riskmetric <- tibble(Package = c("dplyr", "emmeans", "haven", "gsDesign","limma"),
                       Source  = c(rep("CRAN",4), "Bioconductor"),
                       # It will be Y for base and recommended R package in R-FDA.pdf
                       `21CFR` = rep("N", 5),
                       # Code coverage. This is an estimation for proof of concept only.
                       Codecov = c(83, 8,  88, 25, NA),
                       # Wheather the R pacakge had at least one Vignettes
                       Vignettes = rep("Y", 5),
                       # Wheather the R package had News to track changes of version
                       News = rep("Y", 5),
                       # Average of Downloads per month for the last two year
                       Downloads = rep(100, 5),
                       # Whether Version Control was used in development
                       SourceControl = rep("Y", 5),
                       Release_rate = NA,
                       # Size of the R package (the limitation of CRAN is 4MB, not sure how this can
                       # be informative)
                       Size = NA,
                       # Wheather the R pacakge require other language, e.g. Java, C++, Fortune
                       External_language = NA)

  depends <- tools::package_dependencies(
    riskmetric$Package,
    recursive = TRUE,
    db = utils::available.packages(repos = BiocManager::repositories()))

  riskmetric <- riskmetric %>%
    left_join(bind_rows(cran_db1, bioc_db1), by = "Package") %>%
    mutate(dependency = depends) %>%
    mutate(Author = lapply(
      # split on any commas not between square brackets
      strsplit(Author, "(,)(?![^[]*\\])", perl = TRUE),
      # trim surrounding whitespace and replace enclosed newlines with spaces
      . %>% trimws %>% gsub(pattern = "\n", replacement = " ")
    ))

  saveRDS(riskmetric, "data/riskmetric.Rd")
  invisible(riskmetric)
}
