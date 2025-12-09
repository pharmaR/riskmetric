# Score a package based on R CMD check results run by BioC or CRAN

The scoring function is the number of OS flavors that passed with OK or
NOTES + 0.5\*the number of OS's that produced WARNINGS divided by the
number of OS's checked

## Usage

``` r
# S3 method for class 'pkg_metric_remote_checks'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_remote_checks` packge metric object

- ...:

  additional arguments unused

## Value

a fractional value indicating percentage OS flavors that did not produce
an error or warning from R CMD check

## Examples

``` r
if (FALSE) metric_score(assess_remote_checks(pkg_ref("riskmetric")))
 # \dontrun{}
```
