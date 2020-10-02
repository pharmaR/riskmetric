pkg_ref_source_good <- pkg_ref("./test_packages/pkgsourcegood")
assess_source_good <- pkg_assess(pkg_ref_source_good)

pkg_ref_source_bad <- pkg_ref("./test_packages/pkgsourcebad")
assess_source_bad <- pkg_assess(pkg_ref_source_bad)

pkg_ref_stdlib_install <- pkg_ref("utils")
assess_stdlib_install <- pkg_assess(pkg_ref_stdlib_install)

pkg_ref_stdlibs_install <- pkg_ref(c("utils", "tools"))
assess_stdlibs_install <- pkg_assess(pkg_ref_stdlibs_install)

pkg_ref_cran_remote_good <- pkg_ref("pkgcranremotegood")
assess_cran_remote_good <- pkg_assess(pkg_ref_cran_remote_good)

pkg_ref_cran_remote_bad  <- pkg_ref("pkgcranremotebad")
assess_cran_remote_bad <- pkg_assess(pkg_ref_cran_remote_bad)
