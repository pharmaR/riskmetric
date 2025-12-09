# Fetch CRAN Mirrors Info

Fetch CRAN Mirrors Info

## Usage

``` r
memoise_cran_mirrors(all = TRUE, ..., .local = getOption("riskmetric.tests"))
```

## Arguments

- all:

  default `TRUE`, passed to
  [`utils`](https://rdrr.io/r/utils/utils-package.html)`[getCRANmirrors]`

- ...:

  additional arguments passed to
  [`utils`](https://rdrr.io/r/utils/utils-package.html)`[getCRANmirrors]`

- .local:

  an optional local directory to source the CRAN package index from,
  defaulting to `getOption("riskmetric.tests")`, used for isolating
  repository requests during testing.

## Value

a data frame with mirror information
