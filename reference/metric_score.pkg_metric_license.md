# Score a package for acceptable license

Maps a license string to a score

## Usage

``` r
# S3 method for class 'pkg_metric_license'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_license` packge metric object

- ...:

  additional arguments unused

## Value

score of metric license

## Examples

``` r
if (FALSE) metric_score(assess_license(pkg_ref("riskmetric")))
 # \dontrun{}
```
