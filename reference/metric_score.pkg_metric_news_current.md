# Score a package for NEWS files updated to current version

Coerce a logical vector of discovered up-to-date NEWS to a metric score

## Usage

``` r
# S3 method for class 'pkg_metric_news_current'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_news_current` packge metric object

- ...:

  additional arguments unused

## Value

`1` if any NEWS files are up-to-date, otherwise `0`

## Examples

``` r
if (FALSE) metric_score(assess_news_current(pkg_ref("riskmetric")))
 # \dontrun{}
```
