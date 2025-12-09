# Assess how many recent BugReports have been closed

Assess how many recent BugReports have been closed

## Usage

``` r
assess_last_30_bugs_status(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing a logical vector indicating whether a recent
BugReport was closed

## See also

[`metric_score.pkg_metric_last_30_bugs_status`](metric_score.pkg_metric_last_30_bugs_status.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_last_30_bugs_status(pkg_ref("riskmetric"))
} # }
```
