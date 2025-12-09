# Helper for creating a roxygen header from template for assess\_\* functions

Helper for creating a roxygen header from template for assess\_\*
functions

## Usage

``` r
roxygen_assess_family(
  name,
  return_type = "an atomic assessment result",
  dontrun = TRUE
)
```

## Arguments

- name:

  the name of the assessment, assuming naming conventions are followed

- return_type:

  an optional added commentary about the return type of the assessment
  function

- dontrun:

  logical indicating whether examples should be wrapped in a dontrun
  block. This is particularly useful for assessments which may require
  an internet connection.

## Value

roxygen section template for assess family functions

## Examples

``` r
if (FALSE) { # \dontrun{
#' @eval roxygen_assess_family(
#'   "has_news",
#'   "an integer value indicating the number of discovered NEWS files")
} # }
```
