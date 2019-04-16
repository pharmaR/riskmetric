# riskmetric

[![Travis build status](https://travis-ci.org/pharmaR/riskmetric.svg?branch=master)](https://travis-ci.org/pharmaR/riskmetric)
[![Coverage status](https://codecov.io/gh/pharmaR/riskmetric/branch/master/graph/badge.svg)](https://codecov.io/github/pharmaR/riskmetric?branch=master)
 
`riskmetric` is a collection of risk metrics to evaluate the quality of R packages.  

This page represents our current thinking. The R package are currently being reviewed and under development.

## Background

The value of R lies not within the official distribution but within the many R packages that support it. R packages provide the means to extend the language, implementing new statistical methods, graphics and code structures. However, this is also where the majority of risk lies for an organisation.

R packages can be written by anyone. The author/maintainer could be an organisation but they are perhaps more likely to be an individual and no qualification is required in order to develop an R package and submit it to CRAN (or any other package repository). Unlike the base distribution, R packages may or may not follow any software development best practices.

Packages on CRAN must pass a series of technical checks, including an “R CMD check”. These checks are designed to ensure that examples run successfully, tests pass and that packages on CRAN are compatible with each other. However, there is no requirement for package authors to write tests or implement a formal unit-testing framework. In fact, less than 26% of the >13,500 packages on CRAN are known to implement a formal test framework. In addition, there is no obligation to maintain bug reports and unless a bug in a package affects another package on CRAN, the bugs may never be identified nor fixed. Unlike the base distribution, the amount of user testing can also vary widely. Popular packages such as dplyr may have been downloaded and used by tens of thousands of individuals, whilst others might never have been used by anyone except the package author.

In order to apportion an appropriate level of validation effort across different R packages, it is important to establish a risk assessment framework that can be applied to any R package in order to determine a base level of risk.

## Risk Assessment

The following tables highlight metrics that could be used in order to assess the risk of an R package. The risk assessment has been grouped into two areas:

1. Unit testing metrics
2. Documentation metrics
3. Community engagement metrics
4. Maintainability and reuse metrics

### Unit Testing Metrics

* Code Coverage: a percentage range between 0-100 to measure the degree to which the source code of an R package is executed when unit test runs.  
* Code Coverage of all dependent packages (%) a continvalue range between 0-100 to measure the degree to which the source code of an R package and all its dependencies are executed when unit test runs.  

### Documentation Metrics

* Vignette
* Website
* Source control 
* Formal bug tracking
* News
* Release rate
* Size of codebase 
* License

### Community Engagement Metrics

* Author reputation
* Package maturity
* Average number of downloads per month over past 6 monthes 
* Number of active contributors
* Number of authors / maintainers







