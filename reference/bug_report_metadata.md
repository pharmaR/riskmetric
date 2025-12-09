# Helper for structuring bug reports

Helper for structuring bug reports

## Usage

``` r
bug_report_metadata(bug_reports_data, x)
```

## Arguments

- bug_reports_data:

  data to represent a bug report history - generally a return object
  from making a request to a repository's issues API

- x:

  a `pkg_ref` object where a `bug_reports_host` field can be found

## Value

a `bug_reports_host` field
