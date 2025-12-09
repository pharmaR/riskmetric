# Assess a package for the number of downloads in the past year

Assess a package for the number of downloads in the past year

## Usage

``` r
assess_downloads_1yr(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing a numeric value between \[0,1\] indicating the
volume of downloads

## Details

The more times a package has been downloaded the more extensive the user
testing and the greater chance there is of someone finding a bug and
logging it.

## See also

[`metric_score.pkg_metric_downloads_1yr`](metric_score.pkg_metric_downloads_1yr.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_downloads_1yr(pkg_ref("riskmetric"))
} # }
```
