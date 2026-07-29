# riskmetric (development version)

- `memoise_bioc_available()` now queries every Bioconductor repository
  advertised by `BiocManager::repositories()` (BioCsoft, BioCann, BioCexp,
  BioCworkflows, BioCbooks) instead of only the software repository, so
  packages hosted in the annotation, experiment, workflow and books
  repositories (~1,400 additional packages in Bioc 3.22) are now recognised
  by `pkg_bioc()` / `pkg_ref()`. `pkg_bioc()` also now records the actual
  repository the package resolves from rather than hard-coding the
  software repository URL.
- `assess_dependencies.pkg_bioc_remote()` now queries all Bioconductor
  repositories (previously only the first entry of
  `BiocManager::repositories()`), so dependency lookups succeed for
  annotation, experiment, workflow and books packages.


# riskmetric 0.2.6

- Update to address new failing tests responding to `devtools` v2.4.7 changes.

# riskmetric 0.2.5

- Update use of `vctrs` to accommdate changes to acceptable `ptype` parameters
  in `vctrs` v0.7.1 (#394)
- Fix bug with assessing source packages that have non-R files in the R directory ([#362](https://github.com/pharmaR/riskmetric/issues/362))

# riskmetric 0.2.4

- Fix CRAN errors.

# riskmetric 0.2.3

- Fix issue with CRAN package documentation flags. (#311)

# riskmetric 0.2.2

- Fix bug with reporting number of downloads.

# riskmetric 0.2.1

- Updates for S3 Method consistancy for `vec_cast` and `pillar_shift` per CRAN 
comments.

# riskmetric 0.2.0

- We now have a Hex Logo! #233. Thanks to @AARON-CLARK.
- Number of download assessment can now take a specified number of days. #258. Thanks to @parmsam-pfizer.
- A new assessment was added for determining the size of the codebase. #66. Thanks to @shengwei66.
- Fixed an issue of some scores returning negative numbers instead of values between [0,1]. Thanks to @emilliman5.
- A new assessment was added for the presens of a bug report URL for the package. Thanks to @kimjj93.
- A new assessment was added to score the dependency footprint of a package. Thanks to @emilliman5.

# riskmetric 0.1.2

- Hotfix release to correct testing suite such that tests are less continent on
  assumptions of locally installed packages, addressing build issues on CRAN
  builders. (#223, @elimillera)

# riskmetric 0.1.1

- Fixing a bug with subclassing of `pkg_ref` objects using the new concrete
  constructors. (#208, @dgkf)

# riskmetric 0.1.0

- Initial version.
- Added a `NEWS.md` file to track changes to the package.
