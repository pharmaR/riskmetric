# Assess a package for an associated website url

Assess a package for an associated website url

## Usage

``` r
assess_has_website(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing a character vector of website urls associated
with the package

## See also

[`metric_score.pkg_metric_has_website`](metric_score.pkg_metric_has_website.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_has_website(pkg_ref("riskmetric"))
} # }
```
