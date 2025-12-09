# Assess a package for an associated source control url

Assess a package for an associated source control url

## Usage

``` r
assess_has_source_control(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing a character vector of source control urls
associated with the package

## See also

[`metric_score.pkg_metric_has_source_control`](metric_score.pkg_metric_has_source_control.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_has_source_control(pkg_ref("riskmetric"))
} # }
```
