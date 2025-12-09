# Helper for creating a roxygen header from template for score.\* functions

Helper for creating a roxygen header from template for score.\*
functions

## Usage

``` r
roxygen_score_family(name, dontrun = TRUE)
```

## Arguments

- name:

  the name of the scoring function, assuming naming conventions are
  followed

- dontrun:

  logical indicating whether examples should be wrapped in a dontrun
  block. This is particularly useful for assessments which may require
  an internet connection.

## Value

roxygen section template for score family functions

## Examples

``` r
if (FALSE) { # \dontrun{
#' @eval roxygen_score_family("has_news")
} # }
```
