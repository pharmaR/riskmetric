# Score a package for dependencies

Calculates a regularized score based on the number of dependencies a
package has. Convert the number of dependencies `NROW(x)` into a
validation score \[0,1\] \$\$ 1 - 1 / (1 + exp(-0.5 \* (NROW(x) + 4)))
\$\$

## Usage

``` r
# S3 method for class 'pkg_metric_dependencies'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_dependencies` packge metric object

- ...:

  additional arguments unused

## Value

numeric value between `0` (high number of dependencies) and `1` (low
number of dependencies)

## Details

The scoring function is the classic logistic curve \$\$ / (1 +
exp(-k(x-x\[0\])) \$\$ \\x = NROW(x)\\, sigmoid midpoint is 5 reverse
dependencies, ie. \\x\[0\] = 4\\, and logistic growth rate of \\k =
0.5\\.

\$\$ 1 - 1 / (1 + exp(NROW(x)-4)) \$\$

## Examples

``` r
if (FALSE) metric_score(assess_dependencies(pkg_ref("riskmetric")))
 # \dontrun{}
```
