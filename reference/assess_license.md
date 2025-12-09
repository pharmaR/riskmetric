# Assess a package for an acceptable license

Assess a package for an acceptable license

## Usage

``` r
assess_license(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing a string indicating the license under which
the package is released

## See also

[`metric_score.pkg_metric_license`](metric_score.pkg_metric_license.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_license(pkg_ref("riskmetric"))
} # }
```
