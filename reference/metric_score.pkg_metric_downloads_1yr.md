# Defining an Assessment Scoring Function

Score a package for the number of downloads in the past year regularized
Convert the number of downloads `x` in the past year into a validation
score \[0,1\] \$\$ 1 - 150,000 / (x + 150,000) \$\$

## Usage

``` r
# S3 method for class 'pkg_metric_downloads_1yr'
metric_score(x, ...)
```

## Arguments

- x:

  a `pkg_metric_downloads_1yr` packge metric object

- ...:

  additional arguments unused

## Value

numeric value between `0` (low) and `1` (high download volume)
converting the number of downloads.

## Details

The scoring function is a simplification of the classic logistic curve
\$\$ 1 / (1 + exp(-k(x-x\[0\])) \$\$ with a log scale for the number of
downloads \\x = log(x)\\, sigmoid midpoint is 1000 downloads, ie.
\\x\[0\] = log(1,000)\\, and logistic growth rate of \\k = 0.5\\.

\$\$ 1 - 1 / (1 + exp(log(x)-log(1.5e5))) = 1 - 150,000 / (x + 150,000)
\$\$

## Examples

``` r
if (FALSE) metric_score(assess_downloads_1yr(pkg_ref("riskmetric")))
 # \dontrun{}
```
