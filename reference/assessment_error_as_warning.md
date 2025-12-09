# Error handler for assessments to deescalate errors to warnings

Error handler for assessments to deescalate errors to warnings

## Usage

``` r
assessment_error_as_warning(e, name, assessment)
```

## Arguments

- e:

  an error raised during a package reference assessment

- name:

  the name of the package whose package reference assessment raised the
  error

- assessment:

  the name of the assessment function which raised the error

## Value

a pkg_metric object of pkg_metric_error subclass

## See also

Other assessment error handlers:
[`assessment_error_empty()`](assessment_error_empty.md),
[`assessment_error_throw()`](assessment_error_throw.md)
