# Apply assess\_\* family of functions to a package reference

By default, use all `assess_*` funtions in the `riskmetric` namespace
and produce a
[`tibble`](https://tibble.tidyverse.org/reference/tibble.html) with one
column per assessment applied.

## Usage

``` r
pkg_assess(
  x,
  assessments = all_assessments(),
  ...,
  error_handler = assessment_error_empty
)
```

## Arguments

- x:

  A single [`pkg_ref`](pkg_ref.md) object or
  [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) of
  package references to assess

- assessments:

  A list of assessment functions to apply to each package reference. By
  default, a list of all exported assess\_\* functions from the
  riskmetric package.

- ...:

  additional arguments unused

- error_handler:

  A function, which accepts a single parameter expecting the raised
  error, which will be called if any errors occur when attempting to
  apply an assessment function.

## Value

Either a `list_of_pkg_metric` object when a single `pkg_ref` object is
passed as `x`, or a
[`tibble`](https://tibble.tidyverse.org/reference/tibble.html) of
metrics when a `list_of_pkg_ref` or `tibble` is passed as `x`. When a
[`tibble`](https://tibble.tidyverse.org/reference/tibble.html) is
returned, it has one row per package reference and a new column per
assessment function, with cells of that column as package metric objects
returned when the assessment was called with the associated pacakge
reference.

## Assessment function catalog

- [`assess_covr_coverage`](assess_covr_coverage.md):

  Package unit test coverage

- [`assess_has_news`](assess_has_news.md):

  number of discovered NEWS files

- [`assess_remote_checks`](assess_remote_checks.md):

  Number of OS flavors that passed/warned/errored on R CMD check

- [`assess_news_current`](assess_news_current.md):

  NEWS file contains entry for current version number

- [`assess_r_cmd_check`](assess_r_cmd_check.md):

  Package check results

- [`assess_exported_namespace`](assess_exported_namespace.md):

  Objects exported by package

- [`assess_has_vignettes`](assess_has_vignettes.md):

  number of discovered vignettes files

- [`assess_export_help`](assess_export_help.md):

  exported objects have documentation

- [`assess_has_website`](assess_has_website.md):

  a vector of associated website urls

- [`assess_has_maintainer`](assess_has_maintainer.md):

  a vector of associated maintainers

- [`assess_last_30_bugs_status`](assess_last_30_bugs_status.md):

  vector indicating whether BugReports status is closed

- [`assess_size_codebase`](assess_size_codebase.md):

  number of lines of code base

- [`assess_has_source_control`](assess_has_source_control.md):

  a vector of associated source control urls

- [`assess_has_bug_reports_url`](assess_has_bug_reports_url.md):

  presence of a bug reports url in repository

- [`assess_downloads_1yr`](assess_downloads_1yr.md):

  number of downloads in the past year

- [`assess_reverse_dependencies`](assess_reverse_dependencies.md):

  List of reverse dependencies a package has

- [`assess_has_examples`](assess_has_examples.md):

  proportion of discovered function files with examples

- [`assess_dependencies`](assess_dependencies.md):

  Package dependency footprint

- [`assess_license`](assess_license.md):

  software is released with an acceptable license
