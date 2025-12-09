# Assess a package for the presence of a url field where bugs can be reported.

Assess a package for the presence of a url field where bugs can be
reported.

## Usage

``` r
assess_has_bug_reports_url(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing a character value containing the BugReports
field contents

## See also

[`metric_score.pkg_metric_has_bug_reports_url`](metric_score.pkg_metric_has_bug_reports_url.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_has_bug_reports_url(pkg_ref("riskmetric"))
} # }
```
