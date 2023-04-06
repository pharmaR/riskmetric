test_that("Assessments requiring dependencies listed in Suggests are implemented
          consistently", {

  skip("skip")
  # get all assessment objects based on naming convention
  fs <- grep("^assess_[^.]*$",
    getNamespaceExports("riskmetric"),
    value = TRUE
  )
  fn_objs <- Map(getExportedValue, fs, ns = list("riskmetric"))

  # figure out which ones have suggests attribute set
  sugg_ix <- sapply(fn_objs, function(fn) !is.null(attr(fn, "suggests")))
  sugg_fns <- fn_objs[sugg_ix]

  # TODO:
  #   - ~~test to confirm all functions for specific class have calls to
  #     `validate_suggests_install` as their first args~~
  #   - ~~can we find the matching `pkg_ref_cache` fn from the default method~~
  #   - that function attributes and package options are set appropriately
  #   - if you need a min version, you should specify it in the `DESCRIPTION`
  #   - packageDescription("oysteR")['Suggests']
  for (fn_name in names(sugg_fns)) {

    # Check 1: confirm the first line of the function is a call to
    #          validate_suggests_install
    line_1 <- as.character(body(sugg_fns[[fn_name]]))[[2]]
    expect_true(grepl("^validate_suggests_install", line_1))

    # Check 2: Get matching pkg_metric object from S3 methods and confirm a call
    #          validate_suggests_install is present
    sources <- c(
      "pkg_install", "default", "pkg_source", "pkg_cran_remote",
      "pkg_bioc_remote"
    )
    implemented_methods <- intersect(
      sprintf("%s.%s", fn_name, sources),
      ls(loadNamespace("riskmetric"))
    )

    for (s in implemented_methods) {
      # get associated function object and parse all references to pkg_ref_cache
      # slots in the function body
      fn_obj <- eval(str2expression(sprintf("riskmetric:::%s", s)))
      fn_txt <- as.character(body(fn_obj))
      rc_refs <- regmatches(fn_txt, regexpr("(?<=\\$)[^\\s,)}]*",
        fn_txt,
        perl = TRUE
      ))
      # find default definitions for any implemented pkg_ref_cache functions and
      # confirm they include calls to validate_suggests_install
      for (rcr in rc_refs) {
        rc_n <- sprintf("riskmetric:::pkg_ref_cache.%s", rcr)
        fn_obj <- eval(str2expression(rc_n))
        line_1 <- as.character(body(fn_obj))[[2]]
        expect_true(grepl("^validate_suggests_install", line_1))
      }
    }

    # Check 3: Confirm an appropriately named option has been set to enable the
    #          suppression of multiple install attempts
    expect_type(attr(sugg_fns[[fn_name]], "suggests"), "logical")
    expect_type(attr(sugg_fns[[fn_name]], "suggests_pkg"), "character")
    op_nm <- sprintf("riskmetric.skip_%s_install", attr(sugg_fns[[fn_name]], "suggests_pkg"))
    expect_type(getOption(op_nm), "logical")



  }
})
