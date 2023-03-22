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
