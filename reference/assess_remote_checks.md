# Assess package checks from CRAN/Bioc or R CMD check

Assess package checks from CRAN/Bioc or R CMD check

## Usage

``` r
assess_remote_checks(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing Tally of R CMD check results run on differnt
OS flavors by BioC or CRAN

## See also

[`metric_score.pkg_metric_remote_checks`](metric_score.pkg_metric_remote_checks.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_remote_checks(pkg_ref("riskmetric"))
} # }
```
