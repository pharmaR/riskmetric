library(webmockr)
library(httr)

options(riskmetric.tests = test_path())
httr_mock()

# helper function for generating cran-log style API results
build_downloads <- function(downloads = NULL, pkg_name = "temp") {
  day = Sys.Date() - seq_along(downloads)
  downloads_obj <- list(list(
    downloads = rev(mapply(
      function(day, dls) list(list(day = day, downloads = dls)),
      day,
      downloads)),
    start = Sys.Date(),
    end = Sys.Date() - ifelse(is.null(downloads), 0L, length(downloads)),
    package = pkg_name
  ))
  as.character(jsonlite::toJSON(downloads_obj, auto_unbox = TRUE))
}

## CRAN (or mirror) package page
  # TODO: separate out good and bad examples
  stub_request("get", uri_regex = ".+/web/packages/[^/]*") %>%
    to_return(
      body = paste(collapse = "\n", readLines(file.path(test_path(), "test_webmocks", "data", "cran_package.html"))),
      headers = list(
        "Content-Type" = "text/html; charset=utf-8",
        "Content-Encoding" = "UTF-8"))

## CRAN (or mirror) package checks page
  # TODO: separate out good and bad examples
  stub_request("get", uri_regex = ".+/web/checks/[^/]*") %>%
    to_return(
      body = paste(collapse = "\n", readLines(file.path(test_path(), "test_webmocks", "data", "cran_package_checks.html"))),
      headers = list(
        "Content-Type" = "text/html; charset=utf-8",
        "Content-Encoding" = "UTF-8"))

## CRAN (or mirror) NEWS page
  # TODO: separate out good and bad examples
  stub_request("get", uri_regex = ".+/web/packages/[^/]*/news/news.html") %>%
    to_return(
      body = paste(collapse = "\n", readLines(file.path(test_path(), "test_webmocks", "data", "cran_news.html"))),
      headers = list(
        "Content-Type" = "text/html; charset=utf-8",
        "Content-Encoding" = "UTF-8"))

## CRAN (or mirror) package archive listing page
  # TODO: serpate out good and bad examples
  stub_request("get", uri_regex = ".+/src/contrib/Archive/[^/]*") %>%
    to_return(
      body = paste(collapse = "\n", readLines(file.path(test_path(), "test_webmocks", "data", "cran_package_archive.html"))),
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
  # other
  stub_request("get", uri_regex = ".+/downloads/daily/.*") %>%
    to_return(
      body = mock_file(path = tempfile(), payload = build_downloads()),
      headers = list(
        "Content-Type" = "application/json; charset=utf-8",
        "Content-Encoding" = "UTF-8"))

# github bugreports via github's repo issues api
stub_request("get", uri_regex = "api\\.github\\.com/repos/[^/]+/[^/]+/issues") %>%
  wi_th(query = list(state = "all", per_page = "30")) %>%
  to_return(
    body = paste(collapse = "\n", readLines(file.path(test_path(), "test_webmocks", "data", "github_repo_issues_api_response.json"))),
    headers = list("Content-Type" = "application/json"))

# good pkgsource security API call from oysteR
# You can stub this request with the following snippet:
#
# stub_request('post', uri = 'https://ossindex.sonatype.org/api/v3/component-report') %>%
# wi_th(
#   headers = list('Accept' = 'application/json, text/xml, application/xml, */*', 'Content-Type' = 'application/json'),
#   body = list({"coordinates":["pkg:cran/pkgsourcegood@0.1.0"]})
# )

stub_request('post', uri = 'https://ossindex.sonatype.org/api/v3/component-report') %>%
  wi_th(
    headers = list('Accept' = 'application/json, text/xml, application/xml, */*', 'Content-Type' = 'application/json'),
    body = list("coordinates" = "pkg:cran/pkgsourcegood@0.1.0")
  ) %>%
  to_return(
    body = paste(collapse = "\n", readLines(file.path(test_path(), "test_webmocks", "data", "sonatype_response.json"))),
    headers = list("Content-Type" = "application/json"))


# bad
# https://ossindex.sonatype.org/component/pkg:cran/haven@0.1.1
# oysteR::audit(pkg = "haven", version = "0.1.1", type = "cran")
stub_request('post', uri = 'https://ossindex.sonatype.org/api/v3/component-report') %>%
  wi_th(
    headers = list('Accept' = 'application/json, text/xml, application/xml, */*', 'Content-Type' = 'application/json'),
    body = list("coordinates" = "pkg:cran/pkgsourcebad@0.0.0.9000")
  ) %>%
  to_return(
    body = paste(collapse = "\n", readLines(file.path(test_path(), "test_webmocks", "data", "bad_sonatype_response.json"))),
    headers = list("Content-Type" = "application/json"))




