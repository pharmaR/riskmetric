# Score a package for inclusion of an associated website url

Coerce a list of website urls into a numeric value indicating whether
the number of listed urls is greater than 0.

## Usage

``` r
# S3 method for class 'pkg_metric_has_website'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_has_website` packge metric object

- ...:

  additional arguments unused

## Value

`1` if any website url is provided, otherwise `0`

## Examples

``` r
if (FALSE) metric_score(assess_has_website(pkg_ref("riskmetric")))
 # \dontrun{}
```
