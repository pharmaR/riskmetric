## Submission 2

Per comments from Gregor Seyer, the use of installed.packages was replaced with find.package. Examples for unexported functions were also removed.

## Test environments
* local R installation, R 3.6.2
* local R installation, R 3.6.2
* R hub: Windows Server 2022, R-devel, 64 bit
* R hub: Ubuntu Linux 20.04.1 LTS, R-release, GCC
* R hub: Fedora Linux, R-devel, clang, gfortran
* GH Action: MacOS-latest
* GH Action: Windows-latest
* GH Action: Windows-latest(3.6)

## 0.1.2 Release

Please note the change in maintainer is documented [here](https://github.com/pharmaR/riskmetric/pull/228#issuecomment-1007753581) and [here](https://github.com/pharmaR/riskmetric/issues/227#issuecomment-1016703961).

The note  about issues in the tmp directory appear only on the RHub windows machine and seems to be specific to that workflow.

Previous archival was due to examples pulling from an API unexpectedly, theses have been fixed.


## R CMD check results

0 errors | 0 warnings | 2 notes

NOTES:
* checking CRAN incoming feasibility ... NOTE
Maintainer: 'Doug Kelkhoff <doug.kelkhoff@gmail.com>'


New submission
Package was archived on CRAN

CRAN repository db overrides:
  X-CRAN-Comment: Archived on 2021-08-17 as repeated check problems
    were not corrected in time.
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'

