# Score a package for the presence of a example or usage fields

Coerce a logical vector indicating availability of example or usage
documentation

## Usage

``` r
# S3 method for class 'pkg_metric_has_examples'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_has_examples` packge metric object

- ...:

  additional arguments unused

## Value

`1` if any example or usage fields are found, otherwise `0`

## Examples

``` r
if (FALSE) metric_score(assess_has_examples(pkg_ref("riskmetric")))
 # \dontrun{}
```
