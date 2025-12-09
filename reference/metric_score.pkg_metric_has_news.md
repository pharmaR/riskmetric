# Score a package for the presence of a NEWS file

Coerce the number of news files to binary indication of valid NEWS files

## Usage

``` r
# S3 method for class 'pkg_metric_has_news'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_has_news` packge metric object

- ...:

  additional arguments unused

## Value

`1` if any NEWS files are found, otherwise `0`

## Examples

``` r
if (FALSE) metric_score(assess_has_news(pkg_ref("riskmetric")))
 # \dontrun{}
```
