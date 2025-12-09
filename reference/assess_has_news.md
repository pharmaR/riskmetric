# Assess a package for the presence of a NEWS file

Assess a package for the presence of a NEWS file

## Usage

``` r
assess_has_news(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing an integer value indicating the number of
discovered NEWS files

## See also

[`metric_score.pkg_metric_has_news`](metric_score.pkg_metric_has_news.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_has_news(pkg_ref("riskmetric"))
} # }
```
