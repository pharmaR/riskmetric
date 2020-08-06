# Test Source Packages
test_source_1 <- pkg_ref("./testPackage1")
assess_source_1 <- pkg_assess(test_source_1)
test_source_2 <- pkg_ref("./testPackage2")
assess_source_2 <- pkg_assess(test_source_2)

# Test remote CRAN packages. lars and glmnet were only chosen because they weren't on my system
test_CRAN_remote_1 <- pkg_ref("lars")
# Change the class to stop the package from erroring out due to immutability
class(test_CRAN_remote_1) <- "environment"
test_CRAN_remote_1$web_url <- "CRAN - Package lars.html"
class(test_CRAN_remote_1) <- c("pkg_cran_remote", "pkg_remote", "pkg_ref", "environment")
assess_CRAN_remote_1 <- pkg_assess(test_CRAN_remote_1)

test_CRAN_remote_2 <- pkg_ref("glmnet")
class(test_CRAN_remote_2) <- "environment"
test_CRAN_remote_2$web_url <- "CRAN - Package glmnet.html"
test_CRAN_remote_2$news_url <- "news/NEWS.html"
class(test_CRAN_remote_2) <- c("pkg_cran_remote", "pkg_remote", "pkg_ref", "environment")
assess_CRAN_remote_2 <- pkg_assess(test_CRAN_remote_2)

# # Test installed packages
test_installed_package_1 <- pkg_ref("dplyr")
assess_installed_package_1 <- pkg_assess(test_installed_package_1)
test_installed_package_2 <- pkg_ref("utils")
assess_installed_package_2 <- pkg_assess(test_installed_package_2)
