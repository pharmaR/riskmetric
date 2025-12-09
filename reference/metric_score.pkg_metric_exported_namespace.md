# Score a package for the number of exported objects

Score a package for the number of exported objects it has; regularized
Convert the number of exported objects `length(x)` into a validation
score \[0,1\] \$\$ 1 / (1 + exp(-0.5 \* (sqrt(length(x)) + sqrt(5))))
\$\$

## Usage

``` r
# S3 method for class 'pkg_metric_exported_namespace'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_exported_namespace` packge metric object

- ...:

  additional arguments unused

## Value

numeric value between `0` (high number of exported objects) and `1` (low
number of exported objects)

## Details

The scoring function is the classic logistic curve \$\$ 1 / (1 +
exp(-k(x-x\[0\])) \$\$ with a square root scale for the number of
exported objects \\x = sqrt(length(x))\\, sigmoid midpoint is 25
exported objects, ie. \\x\[0\] = sqrt(5)\\, and logistic growth rate of
\\k = 0.25\\.

\$\$ 1 / (1 + exp(-0.25 \* sqrt(length(x))-sqrt(25))) \$\$

## Examples

``` r
if (FALSE) metric_score(assess_exported_namespace(pkg_ref("riskmetric")))
 # \dontrun{}
```
