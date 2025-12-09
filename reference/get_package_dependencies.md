# Gets available packages from necessary repository and filters for package of interest

Gets available packages from necessary repository and filters for
package of interest

## Usage

``` r
get_package_dependencies(name, repo)
```

## Arguments

- name:

  package name

- repo:

  package repository (e.g. CRAN or Bioconductor)

## Value

Returns a data frame with two columns 1) Package names, 2) type of
dependency (LinkingTo, Imports, Depends)
