# Assess a package's results from running R CMD check

Assess a package's results from running R CMD check

## Usage

``` r
assess_r_cmd_check(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing Tally of errors, warnings and notes from
running R CMD check locally

## See also

[`metric_score.pkg_metric_r_cmd_check`](metric_score.pkg_metric_r_cmd_check.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_r_cmd_check(pkg_ref("riskmetric"))
} # }
```
