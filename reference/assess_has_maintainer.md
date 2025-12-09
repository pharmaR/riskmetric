# Assess a package for an associated maintainer

Assess a package for an associated maintainer

## Usage

``` r
assess_has_maintainer(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing a character vector of maintainers associated
with the package

## See also

[`metric_score.pkg_metric_has_maintainer`](metric_score.pkg_metric_has_maintainer.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_has_maintainer(pkg_ref("riskmetric"))
} # }
```
