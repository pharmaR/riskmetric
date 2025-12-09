# Score a package for inclusion of an associated source control url

Coerce a list of source control urls into a numeric value indicating
whether the number of listed urls is greater than 0.

## Usage

``` r
# S3 method for class 'pkg_metric_has_source_control'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_has_source_control` packge metric object

- ...:

  additional arguments unused

## Value

`1` if any source control url is provided, otherwise `0`

## Examples

``` r
if (FALSE) metric_score(assess_has_source_control(pkg_ref("riskmetric")))
 # \dontrun{}
```
