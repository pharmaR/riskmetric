# Proof of Concept for Risk Metrics

## Goal

* Overall Goal: An automatically pipline to create metrics for R packages on CRAN/Bioconductor

## Scope 

* Create a database that contain the risk metrics for every R package of each version.
* Define risk metrics
* Derive code coverage 

### Out-of-Scope

* Define the risk score based on risk metrics (pending confirmation)

## Achievement as of 03/31/2019


* Create a [function to collected risk metrics](https://github.com/pharmaR/riskmetric/blob/master/R/riskmetric.R) for five R packages as pilot

* Reviewed the R in Pharma validation page and proposed additonal [suggested metrics](https://github.com/pharmaR/riskmetric/issues/1#issuecomment-475676110) 

## Ongoing Items

* [Code coverage derivation](https://github.com/pharmaR/riskmetric/issues/6)
* [Define number of downloads](https://github.com/pharmaR/riskmetric/issues/4) 


## Reference 

* [R in Pharma Validation](https://preview--condescending-lewin-a2fc51.netlify.com/packages/) (link may broke as the page is under development)
* [R studio Package Selection](https://environments.rstudio.com/picking.html)
* [Quantifying R Package Dependency Risk](http://www.win-vector.com/blog/2019/03/quantifying-r-package-dependency-risk/)

