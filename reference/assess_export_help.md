# Assess a package for availability of documentation for exported values

Assess a package for availability of documentation for exported values

## Usage

``` r
assess_export_help(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing a logical vector indicating existence of
documentation for each namespace export

## See also

[`metric_score.pkg_metric_export_help`](metric_score.pkg_metric_export_help.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_export_help(pkg_ref("riskmetric"))
} # }
```
