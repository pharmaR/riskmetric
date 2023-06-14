repo <- getOption("repos", "https://cloud.r-project.org")

# no judgement on either package, just using it to stub out something that
# resembles the cran package db. sorry lars!!
db <- available.packages()
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
  sprintf("%s/web/checks/check_results_glmnet.html", repo),
  "./tests/testthat/test_webmocks/data/cran_package_checks.html")

download.file(
  sprintf("%s/web/packages/glmnet/news/news.html", repo),
  "./tests/testthat/test_webmocks/data/cran_news.html")

download.file(
  sprintf("%s/src/contrib/Archive/glmnet", repo),
  "./tests/testthat/test_webmocks/data/cran_package_archive.html")

writeLines(
  httr::content(httr::GET("https://api.github.com/repos/pharmaR/riskmetric/issues?state=all&per_page=3"), as = "text"),
  "./tests/testthat/test_webmocks/good_example/github_repo_issues_api_response.json")


# You can stub this request with the following snippet:
#
#   stub_request('post', uri = 'https://ossindex.sonatype.org/api/v3/component-report') %>%
#   wi_th(
#     headers = list('Accept' = 'application/json, text/xml, application/xml, */*', 'Content-Type' = 'application/json'),
#     body = list({"coordinates":["pkg:cran/pkgsourcegood@0.1.0"]})
#   )

# pkgload::load_all("../oysteR/")
# audit("pkgsourcegood", "0.1.0", "cran")
# writeLines(httr::content(r, "text"), "./tests/testthat/test_webmocks/data/sonatype_response.json")
