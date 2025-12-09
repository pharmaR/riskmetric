# Score a package assessment, collapsing results into a single numeric

pkg_score() calculates the risk involved with using a package. Risk
ranges from 0 (low-risk) to 1 (high-risk).

## Usage

``` r
pkg_score(x, ..., error_handler = score_error_default)
```

## Arguments

- x:

  A `pkg_metric` object, whose subclass is used to choose the
  appropriate scoring method for the atomic metric metadata. Optionally,
  a [`tibble`](https://tibble.tidyverse.org/reference/tibble.html) can
  be provided, in which cases all `pkg_metric` values will be scored.

- ...:

  Additional arguments passed to `summarize_scores` when an object of
  class `tbl_df` is provided, unused otherwise.

- error_handler:

  Specify a function to be called if the class can't be identified. Most
  commonly this occurs for `pkg_metric` objects of subclass
  `pkg_metric_error`, which is produced when an error is encountered
  when calculating an associated assessment.

## Value

A numeric value if a single `pkg_metric` is provided, or a
[`tibble`](https://tibble.tidyverse.org/reference/tibble.html) with
`pkg_metric` objects scored and returned as numeric values when a
[`tibble`](https://tibble.tidyverse.org/reference/tibble.html) is
provided.

## See also

score_error_default score_error_zero score_error_NA

## Examples

``` r
if (FALSE) { # \dontrun{

# scoring a single assessment
metric_score(assess_has_news(pkg_ref("riskmetric")))

# scoring many assessments as a tibble
library(dplyr)
pkg_score(pkg_assess(as_tibble(pkg_ref(c("riskmetric", "riskmetric")))))

} # }
```
