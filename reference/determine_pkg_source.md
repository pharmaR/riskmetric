# Determine the intended source of a new package

Determine the intended source of a new package

## Usage

``` r
determine_pkg_source(x, source, repos)
```

## Arguments

- x:

  Package name or path to package

- source:

  type of source passed in \`pkg_ref\`

## Value

one of c('pkg_source', 'pkg_install', 'pkg_cran_remote',
'pkg_bioc_remote', 'pkg_missing')
