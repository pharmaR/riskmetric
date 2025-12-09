# Assess a package for an up-to-date NEWS file

Assess a package for an up-to-date NEWS file

## Usage

``` r
assess_news_current(x, ...)
```

## Arguments

- x:

  a `pkg_ref` package reference object

- ...:

  additional arguments passed on to S3 methods, rarely used

## Value

a `pkg_metric` containing a logical vector indicating whether each
discovered NEWS file is up-to-date

## See also

[`metric_score.pkg_metric_news_current`](metric_score.pkg_metric_news_current.md)

## Examples

``` r
if (FALSE) { # \dontrun{
assess_news_current(pkg_ref("riskmetric"))
} # }
```
