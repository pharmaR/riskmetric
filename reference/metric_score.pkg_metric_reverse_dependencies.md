# Scoring method for number of reverse dependencies a package has

Score a package for the number of reverse dependencies it has;
regularized Convert the number of reverse dependencies `length(x)` into
a validation score \[0,1\] \$\$ 1 / (1 + exp(-0.5 \* (sqrt(length(x)) +
sqrt(5)))) \$\$

## Usage

``` r
# S3 method for class 'pkg_metric_reverse_dependencies'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_reverse_dependencies` packge metric object

- ...:

  additional arguments unused

## Value

numeric value between `1` (high number of reverse dependencies) and `0`
(low number of reverse dependencies)

## Details

The scoring function is the classic logistic curve \$\$ 1 / (1 +
exp(-k(x-x\[0\])) \$\$ with a square root scale for the number of
reverse dependencies \\x = sqrt(length(x))\\, sigmoid midpoint is 5
reverse dependencies, ie. \\x\[0\] = sqrt(5)\\, and logistic growth rate
of \\k = 0.5\\.

\$\$ 1 / (1 + -0.5 \* exp(sqrt(length(x)) - sqrt(5))) \$\$

## Examples

``` r
if (FALSE) metric_score(assess_reverse_dependencies(pkg_ref("riskmetric")))
 # \dontrun{}
```
