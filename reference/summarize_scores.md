# Summarize a default set of assessments into a single risk score

This function serves as an example for how a risk score might be
derived. Assuming all assessments provided by `riskmetric` are available
in a dataset, this function can be used to calculate a vector of risks.

## Usage

``` r
summarize_scores(data, weights = NULL)
```

## Arguments

- data:

  a [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) of
  scored assessments whose column names match those provided by
  riskmetric's [`pkg_assess`](pkg_assess.md) function.

- weights:

  an optional vector of non-negative weights to be assigned to each
  assessment.

## Value

a numeric vector of risk scores

## Examples

``` r
if (FALSE) { # \dontrun{
library(dplyr)
summarize_scores(pkg_score(pkg_assess(as_tibble(pkg_ref("riskmetric")))))

library(dplyr)
pkg_ref("riskmetric") %>%
  pkg_assess() %>%
  pkg_score() %>%
  summarize_scores()
} # }
```
