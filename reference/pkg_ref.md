# Create a package reference

Create a package reference from package name or filepath, producing an
object in which package metadata will be collected as risk assessments
are performed. Depending on where the package was found - whether it is
found as source code, in a local library or from a remote host - an S3
subclass is given to allow for source-specific collection of metadata.
See 'Details' for a breakdown of subclasses. Different sources can be
specified by passing a subclass as an arguemnt named 'source', see
details.

## Usage

``` r
pkg_ref(x, ...)

pkg_install(x, lib.loc = NULL)

pkg_source(x)

pkg_cran(x, repos = getOption("repos", "https://cran.rstudio.com"))

pkg_bioc(x)

pkg_missing(x)

pkg_library(lib.loc)

as_pkg_ref(x, ...)
```

## Arguments

- x:

  A singular `character` value, `character vector` or `list` of
  `character` values of package names or source code directory paths.

- ...:

  Additional arguments passed to methods.

- lib.loc:

  The path to the R library directory of the installed package.

- repos:

  URL of CRAN repository to pull package metadata.

## Value

When a single value is provided, a single `pkg_ref` object is returned,
possibly with a subclass based on where the package was found. If a
`vector` or `list` is provided, a `list_of_pkg_ref` object constructed
with [`list_of`](https://vctrs.r-lib.org/reference/list_of.html) is
returned, which can be considered analogous to a `list`. See 'Details'
for further information about `pkg_ref` subclasses.

## Details

Package reference objects are used to collect metadata pertaining to a
given package. As data is needed for assessing a package's risk, this
metadata populates fields within the package reference object.

The `pkg_ref` S3 subclasses are used extensively for divergent metadata
collection behaviors dependent on where the package was discovered.
Because of this, there is a rich hierarchy of subclasses to articulate
the different ways package information can be found.

A source argument can be passed using the \`source\` argument. This will
override the logic that riskmetric does when determining a package
source. This can be useful when you are scoring the most recent version
present on a repository, or testing a specific library.

- **`pkg_ref`** A default class for general metadata collection.

  - **`pkg_source`** A reference to a source code directory.

  - **`pkg_install`** A reference to a package installation location in
    a package library. A specific library can be passed by passing the
    path to the library as the parameter \`lib.loc\`

  - **`pkg_remote`** A reference to package metadata on a remote server.

    - **`pkg_cran_remote`** A reference to package information pulled
      from the CRAN repository.

    - **`pkg_bioc_remote`** A reference to package information pulled
      from the Bioconductor repository.

    - **`pkg_git_remote`** A reference to a package source code git
      repository. (not yet implemented)

## Package Cohorts

\*Experimental!\* Package cohorts are structures to determine the risk
of a set of packages. \`pkg_library()\` can be called to create a object
containing the pkg_ref objects of all packages in a system library.

## Examples

``` r
if (FALSE) { # \dontrun{
# riskmetric will check for installed packages by default
ref_1 <- pkg_ref("utils")
ref_1$source # returns 'pkg_install'

# lib.loc can be used to specify a library for pkg_install
ref_3 <- pkg_ref("utils", source = "pkg_install", lib.loc = .libPaths()[1])

# You can also override this behavior with a source argument
ref_2 <- pkg_ref("utils", source = "pkg_cran_remote")
ref_2$source  # returns 'pkg_cran_remote'
} # }
```
