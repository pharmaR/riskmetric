test_that("Assessments requiring dependencies listed in Suggests are implemented
          consistently", {
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
  #   - that options are set appropriately
  #   - if you need a min version, you should specify it in the `DESCRIPTION`
  #   - packageDescription("oysteR")['Suggests']
  for (fn_name in names(sugg_fns)) {
    # confirm the first line of the function is a call to
    # validate_suggests_install
    line_1 <- as.character(body(sugg_fns[[fn_name]]))[[2]]
    expect_true(grepl("^validate_suggests_install", line_1))

    # get matching pkg_metric object from S3 methods
    sources <- c("pkg_install", "default", "pkg_source", "pkg_cran_remote",
                 "pkg_bioc_remote")
    implemented_methods <- intersect(
      sprintf("%s.%s",fn_name, sources),
      ls(loadNamespace("riskmetric"))
    )

    lapply(implemented_methods, function(s) {
      fn_obj <- eval(str2expression(sprintf("riskmetric:::%s", s)))

      as.character(body(def_obj))


      line_1 <- as.character(body(def_obj))[[2]]


      x <- str2lang(sprintf(
        "riskmetric:::%s.%s",
        fn_name, s
      ))

      get(sprintf(
        "riskmetric:::%s.%s",
        fn_name, s
      ), envir = packageN)

    })






  }
})
