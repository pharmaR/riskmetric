library(webmockr)
library(httr)

options(riskmetric.tests = getwd())
httr_mock()

# helper function for generating cran-log style API results
build_downloads <- function(downloads, pkg_name = "temp") {
  day = Sys.Date() - seq_along(downloads)
  downloads_obj <- list(list(
    downloads = rev(mapply(
      function(day, dls) list(list(day = day, downloads = dls)),
      day,
      downloads)),
    start = day[length(day)],
    end = day[1],
    package = pkg_name
  ))
  as.character(jsonlite::toJSON(downloads_obj, auto_unbox = TRUE))
}

## CRAN (or mirror) package page
  # TODO: separate out good and bad examples
  stub_request("get", uri_regex = ".+/web/packages/[^/]*") %>%
    to_return(
      body = file("./test_webmocks/data/cran_package.html"),
      headers = list(
        "Content-Type" = "text/html; charset=utf-8",
        "Content-Encoding" = "UTF-8"))

## CRAN (or mirror) NEWS page
  # TODO: separate out good and bad examples
  stub_request("get", uri_regex = ".+/web/packages/[^/]*/news/news.html") %>%
    to_return(
      body = file("./test_webmocks/data/cran_news.html"),
      headers = list(
        "Content-Type" = "text/html; charset=utf-8",
        "Content-Encoding" = "UTF-8"))

## CRAN (or mirror) package archive listing page
  # TODO: serpate out good and bad examples
  stub_request("get", uri_regex = ".+/src/contrib/Archive/[^/]*") %>%
    to_return(
      body = file("./test_webmocks/data/cran_package_archive.html"),
      headers = list(
        "Content-Type" = "text/html; charset=utf-8",
        "Content-Encoding" = "UTF-8"))

## CRAN logs downloads
  # good
  stub_request("get", uri_regex = ".+/downloads/daily/[^/]*/pkgcranremotegood[^/]*") %>%
    to_return(
      # build a json return payload of ~2k daily downloads over past year
      body = mock_file(
        path = tempfile(),
        payload = build_downloads(pmax(round(rnorm(356, 2e3, 200)), 0))),
      headers = list(
        "Content-Type" = "application/json; charset=utf-8",
        "Content-Encoding" = "UTF-8"))
  # bad
  stub_request("get", uri_regex = ".+/downloads/daily/[^/]*/pkgcranremotebad[^/]*") %>%
    to_return(
      # build a json return payload of ~10 daily downloads over < 1 month
      body = mock_file(
        path = tempfile(),
        payload = build_downloads(pmax(round(rnorm(20, 10, 3)), 0))),
      headers = list(
        "Content-Type" = "application/json; charset=utf-8",
        "Content-Encoding" = "UTF-8"))

# github bugreports via github's repo issues api
stub_request("get", uri_regex = "api\\.github\\.com/repos/.+/.+/issues\\?.+") %>%
  to_return(
    body = file("./test_webmocks/data/github_repo_issues_api_response.json"),
    headers = list("Content-Type" = "application/json"))
