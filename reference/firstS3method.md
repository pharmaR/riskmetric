# Find the S3 method that will be evaluated when an S3 generic is called by an object of class `classes`

Find the S3 method that will be evaluated when an S3 generic is called
by an object of class `classes`

## Usage

``` r
firstS3method(f, classes, envir = parent.frame())
```

## Arguments

- f:

  a character string giving the name of the generic.

- classes:

  a character vector of classes used to search for the appropriate S3
  method

- envir:

  the [`environment`](https://rdrr.io/r/base/environment.html) in which
  the method and its generic are searched first.

## Value

a S3 method
