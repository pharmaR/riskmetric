# Assess a package code coverage using the \`covr\` package

Assess a package code coverage using the \`covr\` package

## Usage

``` r
assess_covr_coverage(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing a list containing fields 'filecoverage' and
'totalcoverage' containing a named numeric vector of file unit test
coverage and a singular numeric value representing overall test coverage
respectively.

## See also

[`metric_score.pkg_metric_covr_coverage`](metric_score.pkg_metric_covr_coverage.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_covr_coverage(pkg_ref("riskmetric"))
} # }
```
