# Assessment console printing formatter

make the errors and warnings consistent with meaningful indication of
what triggered the error, including the name of the package whose
reference triggered the error while running which asesessment.

## Usage

``` r
format_assessment_message(e, name, assessment)
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

a character string of formatted text to communicate the error
