# Score a package for availability of documentation for exported values

Coerce a logical vector indicating availability of export documentation

## Usage

``` r
# S3 method for class 'pkg_metric_export_help'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_export_help` packge metric object

- ...:

  additional arguments unused

## Value

`1` if any NEWS files are found, otherwise `0`

## Examples

``` r
if (FALSE) metric_score(assess_export_help(pkg_ref("riskmetric")))
 # \dontrun{}
```
