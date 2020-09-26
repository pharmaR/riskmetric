repo <- getOption("repos", "https://cloud.r-project.org")

# no judgement on either package, just using it to stub out something that
# resembles the cran package db. sorry lars!!
db <- riskmetric:::memoise_cran_db()
db <- db[db[, "Package"] %in% c("glmnet", "lars"),]
db[,"Package"] <- c("pkgcranremotegood", "pkgcranremotebad")
write.csv(db, "./tests/testthat/test_webmocks/data/cran_packages.csv")

db <- getCRANmirrors()
db <- db[grepl("cloud\\.r-project\\.org", db$URL),]
write.csv(db, "./tests/testthat/test_webmocks/data/cran_mirrors.csv")

download.file(
  sprintf("%s/web/packages/glmnet", repo),
  "./tests/testthat/test_webmocks/data/cran_package.html")

download.file(
  sprintf("%s/web/packages/glmnet/news/news.html", repo),
  "./tests/testthat/test_webmocks/data/cran_news.html")

download.file(
  sprintf("%s/src/contrib/Archive/glmnet", repo),
  "./tests/testthat/test_webmocks/data/cran_package_archive.html")

writeLines(
  httr::content(httr::GET("https://api.github.com/repos/pharmaR/riskmetric/issues?state=all&per_page=3"), as = "text"),
  "./tests/testthat/test_webmocks/good_example/github_repo_issues_api_response.json")
