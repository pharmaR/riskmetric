# Score a package for the presence of a Vignettes file

Coerce the number of vignettes files to binary indication of valid
Vignettes

## Usage

``` r
# S3 method for class 'pkg_metric_has_vignettes'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_has_vignettes` packge metric object

- ...:

  additional arguments unused

## Value

`1` if any Vignettes files are found, otherwise `0`

## Examples

``` r
if (FALSE) metric_score(assess_has_vignettes(pkg_ref("riskmetric")))
 # \dontrun{}
```
