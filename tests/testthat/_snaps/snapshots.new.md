# Test source packages

    <pkg_source, pkg_ref> testPackage1 v0.1.0
    $bug_reports
      [[1]]
      [[1]]$url
      [1] "https://api.github.com/repos/elimillera/test_package_1/issues/3"
      [[1]]$repository_url
      [1] "https://api.github.com/repos/elimillera/test_package_1"
      [[1]]$labels_url
      <continued>
    $bug_reports_host
      [1] "github"
    $vignettes
                                                                       vignette1
      "/home/emiller/riskmetric/tests/testthat/testPackage1/vignettes/vignette1"
                                                                       vignette2
      "/home/emiller/riskmetric/tests/testthat/testPackage1/vignettes/vignette2"
    $maintainer
      [1] "Eli Miller <first.last@example.com> [aut, cre]"
    $covr_coverage
      
    $downloads
              date count      package
      1 2019-09-03     0 testPackage1
      2 2019-09-04     0 testPackage1
      3 2019-09-05     0 testPackage1
      4 2019-09-06     0 testPackage1
      5 2019-09-07     0 testPackage1
      <continued>
    $source_control_url
      character(0)
    $website_urls
      character(0)
    $description
           Package        Type      Title
      [1,] "testPackage1" "Package" "A Test Package Used to Test Source Assessme
      nts"
           Version Authors@R
      [1,] "0.1.0" "\"Eli Miller <first.last@example.com> [aut, cre]\""
           Description
      <continued>
    $bug_reports_url
      [1] "https://github.com/elimillera/test_package_1/issues"
    $news
      $`/home/emiller/riskmetric/tests/testthat/testPackage1/NEWS.md`
      [1] "# 0.1.0"
      [2] "There is no news. This is a test file to determine if the assessments
       are working."
    $path
      [1] "/home/emiller/riskmetric/tests/testthat/testPackage1"
    $source
      [1] "pkg_source"
    $version
      [1] '0.1.0'
    $name
      [1] "testPackage1"
    $expression_coverage...
    $function_coverage...
    $help...
    $help_aliases...
    $release_date...

---

    <pkg_source, pkg_ref> testPackage2 v0.0.0.9000
    $bug_reports_host
      NULL
    $vignettes
      data frame with 0 columns and 0 rows
    $maintainer
      [1] "Eli Miller <first.last@example.com> [aut, cre]"
    $covr_coverage
      
    $downloads
              date count      package
      1 2019-09-03     0 testPackage2
      2 2019-09-04     0 testPackage2
      3 2019-09-05     0 testPackage2
      4 2019-09-06     0 testPackage2
      5 2019-09-07     0 testPackage2
      <continued>
    $source_control_url
      character(0)
    $website_urls
      character(0)
    $description
           Package        Title
      [1,] "testPackage2" "A Test Package Used to Test Source Assessments"
           Version      Authors@R
      [1,] "0.0.0.9000" "\"Eli Miller <first.last@example.com> [aut, cre]\""
           Description                             Depends        License
      [1,] "What the package does (one paragraph)" "R (>= 3.1.2)" "CC BY 2.0"
      <continued>
    $bug_reports_url
      NULL
    $news
      list()
    $path
      [1] "/home/emiller/riskmetric/tests/testthat/testPackage2"
    $source
      [1] "pkg_source"
    $version
      [1] '0.0.0.9000'
    $name
      [1] "testPackage2"
    $bug_reports...
    $expression_coverage...
    $function_coverage...
    $help...
    $help_aliases...
    $release_date...

---

    <list_of<pkg_metric>[12]>
    $news_current
    [1] TRUE
    attr(,"class")
    [1] "pkg_metric_news_current" "pkg_metric"             
    [3] "logical"                
    attr(,"label")
    [1] "NEWS file contains entry for current version number"
    
    $has_bug_reports_url
    [1] "https://github.com/elimillera/test_package_1/issues"
    attr(,"class")
    [1] "pkg_metric_has_bug_reports_url" "pkg_metric"                    
    [3] "character"                     
    attr(,"label")
    [1] "presence of a bug reports url in repository"
    
    $has_source_control
    character(0)
    attr(,"class")
    [1] "pkg_metric_has_source_control" "pkg_metric"                   
    [3] "character"                    
    attr(,"label")
    [1] "a vector of associated source control urls"
    
    $downloads_1yr
    [1] 0
    attr(,"class")
    [1] "pkg_metric_downloads_1yr" "pkg_metric"              
    [3] "numeric"                 
    attr(,"label")
    [1] "number of downloads in the past year"
    
    $covr_coverage
    $filecoverage
    R/test.R 
           0 
    
    $totalcoverage
    [1] 0
    
    attr(,"class")
    [1] "pkg_metric_covr_coverage" "pkg_metric"              
    [3] "list"                    
    attr(,"label")
    [1] "Package unit test coverage"
    
    $has_maintainer
    [1] "Eli Miller <first.last@example.com> [aut, cre]"
    attr(,"class")
    [1] "pkg_metric_has_maintainer" "pkg_metric"               
    [3] "character"                
    attr(,"label")
    [1] "a vector of associated maintainers"
    
    $has_website
    character(0)
    attr(,"class")
    [1] "pkg_metric_has_website" "pkg_metric"             "character"             
    attr(,"label")
    [1] "a vector of associated website urls"
    
    $has_vignettes
    [1] 2
    attr(,"class")
    [1] "pkg_metric_has_vignettes" "pkg_metric"              
    [3] "integer"                 
    attr(,"label")
    [1] "number of discovered vignettes files"
    
    $has_news
    [1] 1
    attr(,"class")
    [1] "pkg_metric_has_news" "pkg_metric"          "integer"            
    attr(,"label")
    [1] "number of discovered NEWS files"
    
    $export_help
    <pkg_metric_error in UseMethod("assess_export_help"): no applicable method for 'assess_export_help' applied to an object of class "c('pkg_source', 'pkg_ref', 'environment')">
    
    $bugs_status
    [1] FALSE  TRUE FALSE
    attr(,"class")
    [1] "pkg_metric_last_30_bugs_status" "pkg_metric"                    
    [3] "logical"                       
    attr(,"label")
    [1] "vector indicating whether BugReports status is closed"
    
    $license
    [1] "MIT + file LICENSE"
    attr(,"class")
    [1] "pkg_metric_license" "pkg_metric"         "character"         
    attr(,"label")
    [1] "software is released with an acceptable license"
    

---

    <list_of<pkg_metric>[12]>
    $news_current
    logical(0)
    attr(,"class")
    [1] "pkg_metric_news_current" "pkg_metric"             
    [3] "logical"                
    attr(,"label")
    [1] "NEWS file contains entry for current version number"
    
    $has_bug_reports_url
    character(0)
    attr(,"class")
    [1] "pkg_metric_has_bug_reports_url" "pkg_metric"                    
    [3] "character"                     
    attr(,"label")
    [1] "presence of a bug reports url in repository"
    
    $has_source_control
    character(0)
    attr(,"class")
    [1] "pkg_metric_has_source_control" "pkg_metric"                   
    [3] "character"                    
    attr(,"label")
    [1] "a vector of associated source control urls"
    
    $downloads_1yr
    [1] 0
    attr(,"class")
    [1] "pkg_metric_downloads_1yr" "pkg_metric"              
    [3] "numeric"                 
    attr(,"label")
    [1] "number of downloads in the past year"
    
    $covr_coverage
    $filecoverage
    R/test.R 
           0 
    
    $totalcoverage
    [1] 0
    
    attr(,"class")
    [1] "pkg_metric_covr_coverage" "pkg_metric"              
    [3] "list"                    
    attr(,"label")
    [1] "Package unit test coverage"
    
    $has_maintainer
    [1] "Eli Miller <first.last@example.com> [aut, cre]"
    attr(,"class")
    [1] "pkg_metric_has_maintainer" "pkg_metric"               
    [3] "character"                
    attr(,"label")
    [1] "a vector of associated maintainers"
    
    $has_website
    character(0)
    attr(,"class")
    [1] "pkg_metric_has_website" "pkg_metric"             "character"             
    attr(,"label")
    [1] "a vector of associated website urls"
    
    $has_vignettes
    [1] 0
    attr(,"class")
    [1] "pkg_metric_has_vignettes" "pkg_metric"              
    [3] "integer"                 
    attr(,"label")
    [1] "number of discovered vignettes files"
    
    $has_news
    [1] 0
    attr(,"class")
    [1] "pkg_metric_has_news" "pkg_metric"          "integer"            
    attr(,"label")
    [1] "number of discovered NEWS files"
    
    $export_help
    <pkg_metric_error in UseMethod("assess_export_help"): no applicable method for 'assess_export_help' applied to an object of class "c('pkg_source', 'pkg_ref', 'environment')">
    
    $bugs_status
    <pkg_metric_error in scrape_bug_reports.NULL(x, ...): package DESCRIPTION does not have a BugReports field>
    
    $license
    [1] "CC BY 2.0"
    attr(,"class")
    [1] "pkg_metric_license" "pkg_metric"         "character"         
    attr(,"label")
    [1] "software is released with an acceptable license"
    

# Test remote CRAN packages

    <pkg_cran_remote, pkg_remote, pkg_ref> lars v1.2
    $bug_reports_host
      character(0)
    $maintainer
      [1] "Trevor Hastie  <hastie at stanford.edu>"
    $downloads
              date count package
      1 2019-09-03   589    lars
      2 2019-09-04   549    lars
      3 2019-09-05   506    lars
      4 2019-09-06   476    lars
      5 2019-09-07   205    lars
      <continued>
    $source_control_url
      character(0)
    $website_urls
      [1] "http://www-stat.stanford.edu/~hastie/Papers/#LARS"
    $bug_reports_url
      character(0)
    $news
      list()
    $news_urls
      character(0)
    $web_html
      named list()
    $web_url
      [1] "CRAN - Package lars.html"
    $repo_base_url
      [1] "https://cran.rstudio.com"
    $repo
      [1] "https://cran.rstudio.com/src/contrib"
    $source
      [1] "pkg_remote"
    $version
      [1] "1.2"
    $name
      [1] "lars"
    $archive_release_dates...
    $bug_reports...
    $release_date...
    $tarball_url...
    $vignettes...

---

    <pkg_cran_remote, pkg_remote, pkg_ref> lars v1.2
    $bug_reports_host
      character(0)
    $maintainer
      [1] "Trevor Hastie  <hastie at stanford.edu>"
    $downloads
              date count package
      1 2019-09-03   589    lars
      2 2019-09-04   549    lars
      3 2019-09-05   506    lars
      4 2019-09-06   476    lars
      5 2019-09-07   205    lars
      <continued>
    $source_control_url
      character(0)
    $website_urls
      [1] "http://www-stat.stanford.edu/~hastie/Papers/#LARS"
    $bug_reports_url
      character(0)
    $news
      list()
    $news_urls
      character(0)
    $web_html
      named list()
    $web_url
      [1] "CRAN - Package lars.html"
    $repo_base_url
      [1] "https://cran.rstudio.com"
    $repo
      [1] "https://cran.rstudio.com/src/contrib"
    $source
      [1] "pkg_remote"
    $version
      [1] "1.2"
    $name
      [1] "lars"
    $archive_release_dates...
    $bug_reports...
    $release_date...
    $tarball_url...
    $vignettes...

---

    <list_of<pkg_metric>[12]>
    $news_current
    logical(0)
    attr(,"class")
    [1] "pkg_metric_news_current" "pkg_metric"             
    [3] "logical"                
    attr(,"label")
    [1] "NEWS file contains entry for current version number"
    
    $has_bug_reports_url
    character(0)
    attr(,"class")
    [1] "pkg_metric_has_bug_reports_url" "pkg_metric"                    
    [3] "character"                     
    attr(,"label")
    [1] "presence of a bug reports url in repository"
    
    $has_source_control
    character(0)
    attr(,"class")
    [1] "pkg_metric_has_source_control" "pkg_metric"                   
    [3] "character"                    
    attr(,"label")
    [1] "a vector of associated source control urls"
    
    $downloads_1yr
    [1] 187557
    attr(,"class")
    [1] "pkg_metric_downloads_1yr" "pkg_metric"              
    [3] "numeric"                 
    attr(,"label")
    [1] "number of downloads in the past year"
    
    $covr_coverage
    <pkg_metric_error in UseMethod("assess_covr_coverage"): no applicable method for 'assess_covr_coverage' applied to an object of class "c('pkg_cran_remote', 'pkg_remote', 'pkg_ref', 'environment')">
    
    $has_maintainer
    [1] "Trevor Hastie  <hastie at stanford.edu>"
    attr(,"class")
    [1] "pkg_metric_has_maintainer" "pkg_metric"               
    [3] "character"                
    attr(,"label")
    [1] "a vector of associated maintainers"
    
    $has_website
    [1] "http://www-stat.stanford.edu/~hastie/Papers/#LARS"
    attr(,"class")
    [1] "pkg_metric_has_website" "pkg_metric"             "character"             
    attr(,"label")
    [1] "a vector of associated website urls"
    
    $has_vignettes
    <pkg_metric_error in UseMethod("xml_find_all"): no applicable method for 'xml_find_all' applied to an object of class "character">
    
    $has_news
    [1] 0
    attr(,"class")
    [1] "pkg_metric_has_news" "pkg_metric"          "integer"            
    attr(,"label")
    [1] "number of discovered NEWS files"
    
    $export_help
    <pkg_metric_error in UseMethod("assess_export_help"): no applicable method for 'assess_export_help' applied to an object of class "c('pkg_cran_remote', 'pkg_remote', 'pkg_ref', 'environment')">
    
    $bugs_status
    <pkg_metric_error in scrape_bug_reports.default(x, ...): >
    
    $license
    <pkg_metric_error in UseMethod("pkg_ref_cache.description"): no applicable method for 'pkg_ref_cache.description' applied to an object of class "c('pkg_cran_remote', 'pkg_remote', 'pkg_ref', 'environment')">
    

---

    <list_of<pkg_metric>[12]>
    $news_current
    <pkg_metric_error: 'CRAN - Package glmnet.html/news/NEWS.html' does not exist in current working directory ('/home/emiller/riskmetric/tests/testthat').>
    
    $has_bug_reports_url
    character(0)
    attr(,"class")
    [1] "pkg_metric_has_bug_reports_url" "pkg_metric"                    
    [3] "character"                     
    attr(,"label")
    [1] "presence of a bug reports url in repository"
    
    $has_source_control
    character(0)
    attr(,"class")
    [1] "pkg_metric_has_source_control" "pkg_metric"                   
    [3] "character"                    
    attr(,"label")
    [1] "a vector of associated source control urls"
    
    $downloads_1yr
    [1] 815490
    attr(,"class")
    [1] "pkg_metric_downloads_1yr" "pkg_metric"              
    [3] "numeric"                 
    attr(,"label")
    [1] "number of downloads in the past year"
    
    $covr_coverage
    <pkg_metric_error in UseMethod("assess_covr_coverage"): no applicable method for 'assess_covr_coverage' applied to an object of class "c('pkg_cran_remote', 'pkg_remote', 'pkg_ref', 'environment')">
    
    $has_maintainer
    [1] "Trevor Hastie  <hastie at stanford.edu>"
    attr(,"class")
    [1] "pkg_metric_has_maintainer" "pkg_metric"               
    [3] "character"                
    attr(,"label")
    [1] "a vector of associated maintainers"
    
    $has_website
    [1] "https://glmnet.stanford.edu,\nhttps://dx.doi.org/10.18637/jss.v033.i01,\nhttps://dx.doi.org/10.18637/jss.v039.i05"
    attr(,"class")
    [1] "pkg_metric_has_website" "pkg_metric"             "character"             
    attr(,"label")
    [1] "a vector of associated website urls"
    
    $has_vignettes
    <pkg_metric_error in UseMethod("xml_find_all"): no applicable method for 'xml_find_all' applied to an object of class "character">
    
    $has_news
    <pkg_metric_error: 'CRAN - Package glmnet.html/news/NEWS.html' does not exist in current working directory ('/home/emiller/riskmetric/tests/testthat').>
    
    $export_help
    <pkg_metric_error in UseMethod("assess_export_help"): no applicable method for 'assess_export_help' applied to an object of class "c('pkg_cran_remote', 'pkg_remote', 'pkg_ref', 'environment')">
    
    $bugs_status
    <pkg_metric_error in scrape_bug_reports.default(x, ...): >
    
    $license
    <pkg_metric_error in UseMethod("pkg_ref_cache.description"): no applicable method for 'pkg_ref_cache.description' applied to an object of class "c('pkg_cran_remote', 'pkg_remote', 'pkg_ref', 'environment')">
    

# Test installed packages

    <pkg_install, pkg_ref> dplyr v1.0.2
    $bug_reports
      $message
      [1] "HTTP error 403."
      $call
      open.connection(con, "rb")
    $bug_reports_host
      [1] "github"
    $help_aliases
        dplyr-package             %>%          across       add_count      add_c
      ount_
      "dplyr-package"     "reexports"        "across"         "count" "se-deprec
      ated"
              add_row
          "reexports"
      <continued>
    $vignettes
                                                                           base
               "/home/emiller/R/x86_64-pc-linux-gnu-library/3.6/dplyr/doc/base"
                                                                        colwise
            "/home/emiller/R/x86_64-pc-linux-gnu-library/3.6/dplyr/doc/colwise"
                                                                  compatibility
      "/home/emiller/R/x86_64-pc-linux-gnu-library/3.6/dplyr/doc/compatibility"
      <continued>
    $maintainer
                                 Maintainer
      "Hadley Wickham <hadley@rstudio.com>"
    $downloads
              date count package
      1 2019-09-03 35865   dplyr
      2 2019-09-04 40530   dplyr
      3 2019-09-05 38642   dplyr
      4 2019-09-06 35777   dplyr
      5 2019-09-07 23531   dplyr
      <continued>
    $source_control_url
      [1] "https://github.com/tidyverse/dplyr"
    $website_urls
      [1] "https://dplyr.tidyverse.org"        "https://github.com/tidyverse/dpl
      yr"
    $description
           Type      Package Title                            Version
      [1,] "Package" "dplyr" "A Grammar of Data Manipulation" "1.0.2"
           Authors@R
      [1,] "c(person(given = \"Hadley\",\nfamily = \"Wickham\",\nrole = c(\"aut\
      ", \"cre\"),\nemail = \"hadley@rstudio.com\",\ncomment = c(ORCID = \"0000-
      0003-4757-117X\")),\nperson(given = \"Romain\",\nfamily = \"François\",\nr
      <continued>
    $bug_reports_url
      [1] "https://github.com/tidyverse/dplyr/issues"
    $news
      $`/home/emiller/R/x86_64-pc-linux-gnu-library/3.6/dplyr/NEWS.md`
         [1] "# dplyr 1.0.2"
         [2] ""
         [3] "* Fixed `across()` issue where data frame columns would mask objec
      ts referred to"
         [4] "  from `all_of()` (#5460)."
      <continued>
    $path
      [1] "/home/emiller/R/x86_64-pc-linux-gnu-library/3.6/dplyr"
    $source
      [1] "pkg_install"
    $version
      [1] '1.0.2'
    $name
      [1] "dplyr"
    $help...
    $release_date...

---

    <pkg_install, pkg_ref> utils v3.6.2
    $bug_reports_host
      NULL
    $help_aliases
                 utils-package                 $.person             .DollarNames
               "utils-package"                 "person"               "rcompgen"
          .DollarNames.default .DollarNames.environment        .DollarNames.list
                    "rcompgen"               "rcompgen"               "rcompgen"
      <continued>
    $vignettes
                                             Sweave
      "/opt/R/3.6.2/lib/R/library/utils/doc/Sweave"
    $maintainer
                                Maintainer
      "R Core Team <R-core@r-project.org>"
    $downloads
              date count package
      1 2019-09-03     0   utils
      2 2019-09-04     0   utils
      3 2019-09-05     0   utils
      4 2019-09-06     0   utils
      5 2019-09-07     0   utils
      <continued>
    $source_control_url
      character(0)
    $website_urls
      character(0)
    $description
           Package Version Priority Title
      [1,] "utils" "3.6.2" "base"   "The R Utils Package"
           Author
      [1,] "R Core Team and contributors worldwide"
           Maintainer                           Description
      [1,] "R Core Team <R-core@r-project.org>" "R utility functions."
      <continued>
    $bug_reports_url
      NULL
    $news
      list()
    $path
      [1] "/opt/R/3.6.2/lib/R/library/utils"
    $source
      [1] "pkg_install"
    $version
      [1] '3.6.2'
    $name
      [1] "utils"
    $bug_reports...
    $help...
    $release_date...

---

    <list_of<pkg_metric>[12]>
    $news_current
    [1] TRUE
    attr(,"class")
    [1] "pkg_metric_news_current" "pkg_metric"             
    [3] "logical"                
    attr(,"label")
    [1] "NEWS file contains entry for current version number"
    
    $has_bug_reports_url
    [1] "https://github.com/tidyverse/dplyr/issues"
    attr(,"class")
    [1] "pkg_metric_has_bug_reports_url" "pkg_metric"                    
    [3] "character"                     
    attr(,"label")
    [1] "presence of a bug reports url in repository"
    
    $has_source_control
    [1] "https://github.com/tidyverse/dplyr"
    attr(,"class")
    [1] "pkg_metric_has_source_control" "pkg_metric"                   
    [3] "character"                    
    attr(,"label")
    [1] "a vector of associated source control urls"
    
    $downloads_1yr
    [1] 13862367
    attr(,"class")
    [1] "pkg_metric_downloads_1yr" "pkg_metric"              
    [3] "numeric"                 
    attr(,"label")
    [1] "number of downloads in the past year"
    
    $covr_coverage
    <pkg_metric_error in UseMethod("assess_covr_coverage"): no applicable method for 'assess_covr_coverage' applied to an object of class "c('pkg_install', 'pkg_ref', 'environment')">
    
    $has_maintainer
    [1] "Hadley Wickham <hadley@rstudio.com>"
    attr(,"class")
    [1] "pkg_metric_has_maintainer" "pkg_metric"               
    [3] "character"                
    attr(,"label")
    [1] "a vector of associated maintainers"
    
    $has_website
    [1] "https://dplyr.tidyverse.org"        "https://github.com/tidyverse/dplyr"
    attr(,"class")
    [1] "pkg_metric_has_website" "pkg_metric"             "character"             
    attr(,"label")
    [1] "a vector of associated website urls"
    
    $has_vignettes
    [1] 9
    attr(,"class")
    [1] "pkg_metric_has_vignettes" "pkg_metric"              
    [3] "integer"                 
    attr(,"label")
    [1] "number of discovered vignettes files"
    
    $has_news
    [1] 1
    attr(,"class")
    [1] "pkg_metric_has_news" "pkg_metric"          "integer"            
    attr(,"label")
    [1] "number of discovered NEWS files"
    
    $export_help
              rows_upsert             src_local            db_analyze 
                     TRUE                  TRUE                  TRUE 
                 n_groups              distinct            summarise_ 
                     TRUE                  TRUE                  TRUE 
              group_split           group_by_if              sample_n 
                     TRUE                  TRUE                  TRUE 
           group_indices_             as_tibble             nest_join 
                     TRUE                  TRUE                  TRUE 
                   any_of     tbl_nongroup_vars                is.src 
                     TRUE                  TRUE                  TRUE 
           summarize_each             cur_group              order_by 
                     TRUE                  TRUE                  TRUE 
           new_grouped_df              any_vars              collapse 
                     TRUE                  TRUE                  TRUE 
                db_commit             left_join            cur_column 
                     TRUE                  TRUE                  TRUE 
                  matches           select_vars                tbl_df 
                     TRUE                  TRUE                  TRUE 
                   is.tbl         compare_tbls2           group_by_at 
                     TRUE                  TRUE                  TRUE 
                     pull                tally_              min_rank 
                     TRUE                  TRUE                  TRUE 
       progress_estimated             anti_join                  syms 
                     TRUE                  TRUE                  TRUE 
                      %>%       db_create_table                   lag 
                     TRUE                  TRUE                  TRUE 
                  db_desc              tbl_vars          db_data_type 
                     TRUE                  TRUE                  TRUE 
                   across      dplyr_col_modify             mutate_if 
                     TRUE                  TRUE                  TRUE 
          db_create_index             ends_with           arrange_all 
                     TRUE                  TRUE                  TRUE 
                     funs              dim_desc          check_dbplyr 
                     TRUE                  TRUE                  TRUE 
                 src_tbls          slice_sample            eval_tbls2 
                     TRUE                  TRUE                  TRUE 
                 last_col            arrange_if                 .data 
                     TRUE                  TRUE                 FALSE 
            is_grouped_df               rowwise        db_write_table 
                     TRUE                  TRUE                  TRUE 
                       do            n_distinct             bind_cols 
                     TRUE                  TRUE                  TRUE 
                   src_df            sql_set_op              top_frac 
                     TRUE                  TRUE                  TRUE 
               group_keys            rows_patch           rows_insert 
                     TRUE                  TRUE                  TRUE 
         sql_escape_ident             mutate_at                enquos 
                     TRUE                  TRUE                  TRUE 
                  enexprs            sql_select                 tally 
                     TRUE                  TRUE                  TRUE 
               transmute_             bind_rows           rows_update 
                     TRUE                  TRUE                  TRUE 
                     last             filter_at                 union 
                     TRUE                  TRUE                  TRUE 
                semi_join         db_drop_table           sample_frac 
                     TRUE                  TRUE                  TRUE 
               group_vars            select_all             group_by_ 
                     TRUE                  TRUE                  TRUE 
                    slice                  lead                  vars 
                     TRUE                  TRUE                  TRUE 
          summarise_each_      distinct_prepare              cur_data 
                     TRUE                  TRUE                  TRUE 
                summarize                tibble          sql_subquery 
                     TRUE                  TRUE                  TRUE 
                      sym         group_indices            right_join 
                     TRUE                  TRUE                  TRUE 
                     expr          db_has_table          summarise_at 
                     TRUE                  TRUE                  TRUE 
                  ungroup        cur_group_rows          add_rownames 
                     TRUE                  TRUE                  TRUE 
            transmute_all            show_query              db_begin 
                     TRUE                  TRUE                  TRUE 
    group_by_drop_default              coalesce       wrap_dbplyr_obj 
                     TRUE                  TRUE                  TRUE 
              distinct_at     db_create_indexes        db_list_tables 
                     TRUE                  TRUE                  TRUE 
                 relocate               compute               mutate_ 
                     TRUE                  TRUE                  TRUE 
                      lst                filter                mutate 
                     TRUE                  TRUE                  TRUE 
               inner_join       db_query_fields          rename_vars_ 
                     TRUE                  TRUE                  TRUE 
                case_when           rename_with           with_groups 
                     TRUE                  TRUE                  TRUE 
                      do_              type_sum           distinct_if 
                     TRUE                  TRUE                  TRUE 
                  cummean             auto_copy         db_query_rows 
                     TRUE                  TRUE                  TRUE 
                        n             group_map         db_save_query 
                     TRUE                  TRUE                  TRUE 
                  nest_by             num_range            add_count_ 
                     TRUE                  TRUE                  TRUE 
                    ident         sql_semi_join             intersect 
                     TRUE                  TRUE                  TRUE 
                       id                 enquo          transmute_at 
                     TRUE                  TRUE                  TRUE 
               group_nest         as_data_frame         recode_factor 
                     TRUE                  TRUE                  TRUE 
              rename_vars             select_if             rename_if 
                     TRUE                  TRUE                  TRUE 
             src_postgres     dplyr_reconstruct              sql_join 
                     TRUE                  TRUE                  TRUE 
               group_trim               if_else            rename_all 
                     TRUE                  TRUE                  TRUE 
                  setdiff                  quos            with_order 
                     TRUE                  TRUE                  TRUE 
               filter_all              arrange_            group_data 
                     TRUE                  TRUE                  TRUE 
                    top_n                   nth              group_by 
                     TRUE                  TRUE                  TRUE 
                src_mysql             select_at             rename_at 
                     TRUE                  TRUE                  TRUE 
                add_count            dense_rank                count_ 
                     TRUE                  TRUE                  TRUE 
                full_join          cur_data_all                  lst_ 
                     TRUE                  TRUE                  TRUE 
                slice_max        summarise_each                all_of 
                     TRUE                  TRUE                  TRUE 
                   cumall            group_size     sql_translate_env 
                     TRUE                  TRUE                  TRUE 
               select_var            mutate_all          summarize_at 
                     TRUE                  TRUE                  TRUE 
                   slice_          current_vars          summarise_if 
                     TRUE                  TRUE                  TRUE 
               data_frame          compare_tbls            everything 
                     TRUE                  TRUE                  TRUE 
                  tbl_sum              same_src      group_by_prepare 
                     TRUE                  TRUE                  TRUE 
               db_explain             eval_tbls              location 
                     TRUE                  TRUE                  TRUE 
               arrange_at          transmute_if               rename_ 
                     TRUE                  TRUE                  TRUE 
                  arrange          mutate_each_              c_across 
                     TRUE                  TRUE                  TRUE 
                  select_             filter_if          distinct_all 
                     TRUE                  TRUE                  TRUE 
          summarize_each_             summarise              as_label 
                     TRUE                  TRUE                  TRUE 
             group_by_all               copy_to          select_vars_ 
                     TRUE                  TRUE                  TRUE 
                all_equal             tbl_ptype                 ntile 
                     TRUE                  TRUE                  TRUE 
                trunc_mat                   sql                  near 
                     TRUE                  TRUE                  TRUE 
                common_by        db_insert_into                 first 
                     TRUE                  TRUE                  TRUE 
               bench_tbls       dplyr_row_slice            summarize_ 
                     TRUE                  TRUE                  TRUE 
                      src               filter_              setequal 
                     TRUE                  TRUE                  TRUE 
                   rename                cumany                one_of 
                     TRUE                  TRUE                  TRUE 
                     desc              contains                 na_if 
                     TRUE                  TRUE                  TRUE 
                distinct_               glimpse                ensyms 
                     TRUE                  TRUE                  TRUE 
               frame_data              quo_name                   tbl 
                     TRUE                  TRUE                  TRUE 
                slice_min          group_modify           data_frame_ 
                     TRUE                  TRUE                  TRUE 
               group_walk                 count              make_tbl 
                     TRUE                  TRUE                  TRUE 
                cume_dist         is.grouped_df            group_cols 
                     TRUE                  TRUE                  TRUE 
               add_tally_                as.tbl                select 
                     TRUE                  TRUE                  TRUE 
             percent_rank   validate_grouped_df            grouped_df 
                     TRUE                  TRUE                  TRUE 
                  combine             add_tally            row_number 
                     TRUE                  TRUE                  TRUE 
                transmute     sql_escape_string                groups 
                     TRUE                  TRUE                  TRUE 
                      quo               changes               between 
                     TRUE                  TRUE                  TRUE 
                    funs_               collect            group_rows 
                     TRUE                  TRUE                  TRUE 
                    ensym           mutate_each              all_vars 
                     TRUE                  TRUE                  TRUE 
              starts_with               explain            src_sqlite 
                     TRUE                  TRUE                  TRUE 
            summarize_all            slice_tail               add_row 
                     TRUE                  TRUE                  TRUE 
                   recode            slice_head               tribble 
                     TRUE                  TRUE                  TRUE 
              db_rollback              failwith         summarise_all 
                     TRUE                  TRUE                  TRUE 
             summarize_if          cur_group_id           rows_delete 
                     TRUE                  TRUE                  TRUE 
                union_all                enexpr 
                     TRUE                  TRUE 
    attr(,"class")
    [1] "pkg_metric_export_help" "pkg_metric"             "logical"               
    attr(,"label")
    [1] "exported objects have documentation"
    
    $bugs_status
    <pkg_metric_error in open.connection(con, "rb"): HTTP error 403.>
    
    $license
    [1] "MIT + file LICENSE"
    attr(,"class")
    [1] "pkg_metric_license" "pkg_metric"         "character"         
    attr(,"label")
    [1] "software is released with an acceptable license"
    

---

    <list_of<pkg_metric>[12]>
    $news_current
    logical(0)
    attr(,"class")
    [1] "pkg_metric_news_current" "pkg_metric"             
    [3] "logical"                
    attr(,"label")
    [1] "NEWS file contains entry for current version number"
    
    $has_bug_reports_url
    character(0)
    attr(,"class")
    [1] "pkg_metric_has_bug_reports_url" "pkg_metric"                    
    [3] "character"                     
    attr(,"label")
    [1] "presence of a bug reports url in repository"
    
    $has_source_control
    character(0)
    attr(,"class")
    [1] "pkg_metric_has_source_control" "pkg_metric"                   
    [3] "character"                    
    attr(,"label")
    [1] "a vector of associated source control urls"
    
    $downloads_1yr
    [1] 0
    attr(,"class")
    [1] "pkg_metric_downloads_1yr" "pkg_metric"              
    [3] "numeric"                 
    attr(,"label")
    [1] "number of downloads in the past year"
    
    $covr_coverage
    <pkg_metric_error in UseMethod("assess_covr_coverage"): no applicable method for 'assess_covr_coverage' applied to an object of class "c('pkg_install', 'pkg_ref', 'environment')">
    
    $has_maintainer
    [1] "R Core Team <R-core@r-project.org>"
    attr(,"class")
    [1] "pkg_metric_has_maintainer" "pkg_metric"               
    [3] "character"                
    attr(,"label")
    [1] "a vector of associated maintainers"
    
    $has_website
    character(0)
    attr(,"class")
    [1] "pkg_metric_has_website" "pkg_metric"             "character"             
    attr(,"label")
    [1] "a vector of associated website urls"
    
    $has_vignettes
    [1] 1
    attr(,"class")
    [1] "pkg_metric_has_vignettes" "pkg_metric"              
    [3] "integer"                 
    attr(,"label")
    [1] "number of discovered vignettes files"
    
    $has_news
    [1] 0
    attr(,"class")
    [1] "pkg_metric_has_news" "pkg_metric"          "integer"            
    attr(,"label")
    [1] "number of discovered NEWS files"
    
    $export_help
                  aspell_package_Rd_files                                    vi 
                                     TRUE                                  TRUE 
                               read.table                             URLdecode 
                                     TRUE                                  TRUE 
                                rc.status                             write.csv 
                                     TRUE                                  TRUE 
                       RweaveLatexOptions                              formatUL 
                                     TRUE                                  TRUE 
                                   prompt                               upgrade 
                                     TRUE                                  TRUE 
                                 RShowDoc                          argsAnywhere 
                                     TRUE                                  TRUE 
                               read.delim                              de.ncols 
                                     TRUE                                  TRUE 
                           SweaveSyntConv                          new.packages 
                                     TRUE                                  TRUE 
                              read.socket                            personList 
                                     TRUE                                  TRUE 
                              write.table                           read.delim2 
                                     TRUE                                  TRUE 
                 aspell_package_vignettes                           SweaveHooks 
                                     TRUE                                  TRUE 
                                  hasName                     assignInNamespace 
                                     TRUE                                  TRUE 
                            is.relistable                          .DollarNames 
                                     TRUE                                  TRUE 
                                 toBibtex                                 alarm 
                                     TRUE                                  TRUE 
                         RweaveLatexSetup                             checkCRAN 
                                     TRUE                                  TRUE 
                          setRepositories                           warnErrList 
                                     TRUE                                  TRUE 
                              dump.frames                                 Rprof 
                                     TRUE                                  TRUE 
                              sessionInfo                          count.fields 
                                     TRUE                                  TRUE 
                              create.post                           tail.matrix 
                                     TRUE                                  TRUE 
                                   person                         promptPackage 
                                     TRUE                                  TRUE 
                         install.packages                                  news 
                                     TRUE                                  TRUE 
                                URLencode                          type.convert 
                                     TRUE                                  TRUE 
                               help.start                             osVersion 
                                     TRUE                                  TRUE 
                                 de.setup                              aregexec 
                                     TRUE                                  TRUE 
                             rc.getOption                            de.restore 
                                     TRUE                                  TRUE 
                                file.edit                             citHeader 
                                     TRUE                                  TRUE 
                                      fix             makeRweaveLatexCodeRunner 
                                     TRUE                                  TRUE 
                        .RtangleCodeLabel                          write.socket 
                                    FALSE                                  TRUE 
                                    unzip                                Sweave 
                                     TRUE                                  TRUE 
                                      nsl                              read.fwf 
                                     TRUE                                  TRUE 
                            CRAN.packages                     RweaveEvalWithOpt 
                                     TRUE                                  TRUE 
                            limitedLabels                      readCitationFile 
                                     TRUE                                  TRUE 
                                        ?                        process.events 
                                     TRUE                                  TRUE 
                            as.relistable                          getParseText 
                                     TRUE                                  TRUE 
                           isS3stdGeneric                            modifyList 
                                     TRUE                                  TRUE 
                               maintainer                    available.packages 
                                     TRUE                                  TRUE 
                               citeNatbib                            rc.options 
                                     TRUE                                  TRUE 
                                  Rtangle                         setBreakpoint 
                                     TRUE                                  TRUE 
                              head.matrix                     getTxtProgressBar 
                                     TRUE                                  TRUE 
                                     tail                          changedFiles 
                                     TRUE                                  TRUE 
                        RweaveLatexFinish                           getAnywhere 
                                     TRUE                                  TRUE 
                                browseEnv                           object.size 
                                     TRUE                                  TRUE 
                          globalVariables                        packageVersion 
                                     TRUE                                  TRUE 
                              help.search                      package.skeleton 
                                     TRUE                                  TRUE 
                             summaryRprof                     setTxtProgressBar 
                                     TRUE                                  TRUE 
                                timestamp                             getSrcref 
                                     TRUE                                  TRUE 
                                    stack                        capture.output 
                                     TRUE                                  TRUE 
                               bug.report                           rc.settings 
                                     TRUE                                  TRUE 
                             fileSnapshot                   hsearch_db_keywords 
                                     TRUE                                  TRUE 
                                    rtags                       browseVignettes 
                                     TRUE                                  TRUE 
                              contrib.url                            strOptions 
                                     TRUE                                  TRUE 
                              RweaveLatex                    packageDescription 
                                     TRUE                                  TRUE 
                        SweaveSyntaxNoweb                         flush.console 
                                     TRUE                                  TRUE 
                                 Rprofmem                           asDateBuilt 
                                     TRUE                                  TRUE 
                           compareVersion                         as.personList 
                                     TRUE                                  TRUE 
                         getFromNamespace                               recover 
                                     TRUE                                  TRUE 
                            packageStatus                             read.csv2 
                                     TRUE                                  TRUE 
                                     demo                                  edit 
                                     TRUE                                  TRUE 
                   aspell_package_R_files                            isS3method 
                                     TRUE                                  TRUE 
                                       de                           packageDate 
                                     TRUE                                  TRUE 
                              RSiteSearch                              read.DIF 
                                     TRUE                                  TRUE 
                      hsearch_db_concepts                        getSrcLocation 
                                     TRUE                                  TRUE 
                                  lsf.str                                   tar 
                                     TRUE                                  TRUE 
                             help.request                                  cite 
                                     TRUE                                  TRUE 
                               .S3methods                           select.list 
                                     TRUE                                  TRUE 
                                  .romans                        getCRANmirrors 
                                     TRUE                                  TRUE 
                                   relist                                ls.str 
                                     TRUE                                  TRUE 
                          localeToCharset                     download.packages 
                                     TRUE                                  TRUE 
                                 debugger                      chooseCRANmirror 
                                     TRUE                                  TRUE 
                              savehistory                              citEntry 
                                     TRUE                                  TRUE 
                            RweaveTryStop                          close.socket 
                                     TRUE                                  TRUE 
                                 vignette                           getS3method 
                                     TRUE                                  TRUE 
                                 askYesNo                                 combn 
                                     TRUE                                  TRUE 
                              loadhistory                       update.packages 
                                     TRUE                                  TRUE 
                                  glob2rx                          old.packages 
                                     TRUE                                  TRUE 
                          remove.packages                          getParseData 
                                     TRUE                                  TRUE 
                                    xedit                     SweaveSyntaxLatex 
                                     TRUE                                  TRUE 
                              packageName                              bibentry 
                                     TRUE                                  TRUE 
                             RtangleSetup                           findLineNum 
                                     TRUE                                  TRUE 
                          RtangleWritedoc                        txtProgressBar 
                                     TRUE                                  TRUE 
                               promptData                             file_test 
                                     TRUE                                  TRUE 
                           getSrcFilename                                  help 
                                     TRUE                                  TRUE 
                                  toLatex                    installed.packages 
                                     TRUE                                  TRUE 
                                citFooter                               unstack 
                                     TRUE                                  TRUE 
                              mirror2html                             debugcall 
                                     TRUE                                  TRUE 
                               data.entry                                   str 
                                     TRUE                                  TRUE 
                             read.fortran                             dataentry 
                                     TRUE                                  TRUE 
                                 citation                                 emacs 
                                     TRUE                                  TRUE 
                                     head                          promptImport 
                                     TRUE                                  TRUE 
                             removeSource                    make.packages.html 
                                     TRUE                                  TRUE 
                        RweaveChunkPrefix                                  page 
                                     TRUE                                  TRUE 
    aspell_write_personal_dictionary_file                              formatOL 
                                     TRUE                                  TRUE 
                      RweaveLatexWritedoc                          memory.limit 
                                     TRUE                                  TRUE 
                                     find                                  pico 
                                     TRUE                                  TRUE 
                           fixInNamespace                                 adist 
                                     TRUE                                  TRUE 
                                  example                                  data 
                                     TRUE                                  TRUE 
                               write.csv2                           memory.size 
                                     TRUE                                  TRUE 
                                     menu                              read.csv 
                                     TRUE                                  TRUE 
                                 url.show                               history 
                                     TRUE                                  TRUE 
                         chooseBioCmirror                                  View 
                                     TRUE                                  TRUE 
                      assignInMyNamespace                            hsearch_db 
                                     TRUE                                  TRUE 
                                browseURL                                 untar 
                                     TRUE                                  TRUE 
                                   aspell                                   zip 
                                     TRUE                                  TRUE 
                              make.socket                       getSrcDirectory 
                                     TRUE                                  TRUE 
                     suppressForeignCheck                           undebugcall 
                                     TRUE                                  TRUE 
                                  Stangle                aspell_package_C_files 
                                     TRUE                                  TRUE 
                            download.file                               apropos 
                                     TRUE                                  TRUE 
                                 as.roman                                xemacs 
                                     TRUE                                  TRUE 
                               strcapture                               methods 
                                     TRUE                                  TRUE 
                                as.person 
                                     TRUE 
    attr(,"class")
    [1] "pkg_metric_export_help" "pkg_metric"             "logical"               
    attr(,"label")
    [1] "exported objects have documentation"
    
    $bugs_status
    <pkg_metric_error in scrape_bug_reports.NULL(x, ...): package DESCRIPTION does not have a BugReports field>
    
    $license
    [1] "Part of R 3.6.2"
    attr(,"class")
    [1] "pkg_metric_license" "pkg_metric"         "character"         
    attr(,"label")
    [1] "software is released with an acceptable license"
    

