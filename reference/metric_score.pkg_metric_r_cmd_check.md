# Score a package based on R CMD check results run locally

The scoring function is the weighted sum of notes (0.1), errors (1) and
warnings (0.25), with a maximum score of 1 (no errors, notes or
warnings) and a minimum score of 0. Essentially, the metric will allow
up to 10 notes, 1 error or 4 warnings before returning the lowest score
of 0

## Usage

``` r
# S3 method for class 'pkg_metric_r_cmd_check'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_r_cmd_check` packge metric object

- ...:

  additional arguments unused

## Value

A weighted sum of errors and warnings of all tests preformed

## Examples

``` r
if (FALSE) metric_score(assess_r_cmd_check(pkg_ref("riskmetric")))
 # \dontrun{}
```
