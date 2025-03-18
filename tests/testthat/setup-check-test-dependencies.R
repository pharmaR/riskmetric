desc <- file.path(testthat::test_path("."), "..", "..", "DESCRIPTION")

desc_deps <- read.dcf(desc, fields = "Config/Needs/testing")[[1]]
deps_strs <- trimws(strsplit(deps, ",")[[1]])
deps_parts <- tools:::.split_dependencies(deps_strs)

is_satisfied <- function(dep) {
  # first check if package is installed at all
  is_installed <- length(find.package(dep$name, quiet = TRUE)) > 0L
  if (!is_installed) return(FALSE)

  # check if package has a version bound, eg `pkg (>= 1.2.3)`
  has_version_constraint <- !is.null(dep$op)
  if (!has_version_constraint) return(TRUE)

  # finally, confirm that version bound is met
  version <- packageVersion(dep$name)
  is_constraint_satisfied <- do.call(dep$op, list(version, dep$version))

  is_constraint_satisfied
}

unsatisfied_deps <- deps_strs[!vapply(deps_parts, is_satisfied, logical(1L))]
if (length(unsatisfied_deps) > 0L) {
  stop(
    "\n",
    "  Missing Suggests packages required for testing:\n",
    paste0("    ", unsatisfied_deps, collapse = "\n"), "\n\n",
    "  Resolve using:\n",
    '    pak::local_install_dev_deps(dependencies = "Config/Needs/testing")',
    "\n\n"
  )
}
