# Test Source Packages
ref_source_1 <- pkg_ref("./testPackage1")
assess_source_1 <- pkg_assess(ref_source_1)
ref_source_2 <- pkg_ref("./testPackage2")
assess_source_2 <- pkg_assess(ref_source_2)

# Test remote CRAN packages. lars and glmnet were only chosen because they weren't on my system
ref_CRAN_remote_1 <- pkg_ref("lars")
# Change the class to stop the package from erroring out due to immutability
tmp_class <- class(ref_CRAN_remote_1)
class(ref_CRAN_remote_1) <- "environment"
ref_CRAN_remote_1$web_url <- "CRAN-Package_lars.html"
class(ref_CRAN_remote_1) <- tmp_class
assess_CRAN_remote_1 <- pkg_assess(ref_CRAN_remote_1)
# This isn't the best but we have to remove the pointers because they are based
# on the memory location and change each run
class(ref_CRAN_remote_1) <- "environment"
ref_CRAN_remote_1$web_html$node <- NULL
ref_CRAN_remote_1$web_html$doc <- NULL
class(ref_CRAN_remote_1) <- tmp_class

ref_CRAN_remote_2 <- pkg_ref("glmnet")
tmp_class <- class(ref_CRAN_remote_2)
class(ref_CRAN_remote_2) <- "environment"
ref_CRAN_remote_2$web_url <- "CRAN-Package_glmnet.html"
ref_CRAN_remote_2$news_url <- "news/NEWS.html"
class(ref_CRAN_remote_2) <- tmp_class
assess_CRAN_remote_2 <- pkg_assess(ref_CRAN_remote_2)
class(ref_CRAN_remote_2) <- "environment"
ref_CRAN_remote_2$web_html$node <- NULL
ref_CRAN_remote_2$web_html$doc <- NULL
class(ref_CRAN_remote_2) <- tmp_class

# Test installed packages
ref_installed_package_1 <- pkg_ref("dplyr")
assess_installed_package_1 <- pkg_assess(ref_installed_package_1)
ref_installed_package_2 <- pkg_ref("utils")
assess_installed_package_2 <- pkg_assess(ref_installed_package_2)
