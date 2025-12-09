# Error handler for assessments to throw error immediately

Error handler for assessments to throw error immediately

## Usage

``` r
assessment_error_throw(e, name, assessment)
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

the error encountered during assessment

## See also

Other assessment error handlers:
[`assessment_error_as_warning()`](assessment_error_as_warning.md),
[`assessment_error_empty()`](assessment_error_empty.md)
