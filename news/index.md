# Changelog

## riskmetric (development version)

- Fix bug with assessing source packages that have non-R files in the R
  directory ([\#362](https://github.com/pharmaR/riskmetric/issues/362))

## riskmetric 0.2.4

CRAN release: 2024-01-09

- Fix CRAN errors.

## riskmetric 0.2.3

CRAN release: 2023-08-31

- Fix issue with CRAN package documentation flags.
  ([\#311](https://github.com/pharmaR/riskmetric/issues/311))

## riskmetric 0.2.2

CRAN release: 2023-06-29

- Fix bug with reporting number of downloads.

## riskmetric 0.2.1

CRAN release: 2023-03-10

- Updates for S3 Method consistancy for `vec_cast` and `pillar_shift`
  per CRAN comments.

## riskmetric 0.2.0

CRAN release: 2023-02-22

- We now have a Hex Logo!
  [\#233](https://github.com/pharmaR/riskmetric/issues/233). Thanks to
  [@AARON-CLARK](https://github.com/AARON-CLARK).
- Number of download assessment can now take a specified number of days.
  [\#258](https://github.com/pharmaR/riskmetric/issues/258). Thanks to
  [@parmsam-pfizer](https://github.com/parmsam-pfizer).
- A new assessment was added for determining the size of the codebase.
  [\#66](https://github.com/pharmaR/riskmetric/issues/66). Thanks to
  [@shengwei66](https://github.com/shengwei66).
- Fixed an issue of some scores returning negative numbers instead of
  values between \[0,1\]. Thanks to
  [@emilliman5](https://github.com/emilliman5).
- A new assessment was added for the presens of a bug report URL for the
  package. Thanks to [@kimjj93](https://github.com/kimjj93).
- A new assessment was added to score the dependency footprint of a
  package. Thanks to [@emilliman5](https://github.com/emilliman5).

## riskmetric 0.1.2

CRAN release: 2022-01-28

- Hotfix release to correct testing suite such that tests are less
  continent on assumptions of locally installed packages, addressing
  build issues on CRAN builders.
  ([\#223](https://github.com/pharmaR/riskmetric/issues/223),
  [@elimillera](https://github.com/elimillera))

## riskmetric 0.1.1

CRAN release: 2021-07-29

- Fixing a bug with subclassing of `pkg_ref` objects using the new
  concrete constructors.
  ([\#208](https://github.com/pharmaR/riskmetric/issues/208),
  [@dgkf](https://github.com/dgkf))

## riskmetric 0.1.0

CRAN release: 2021-05-13

- Initial version.
- Added a `NEWS.md` file to track changes to the package.
