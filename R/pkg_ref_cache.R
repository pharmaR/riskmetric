available_pkg_ref_fields <- function(x) {
  fs <- names(getNamespace(packageName()))
  f_re <- paste0("^pkg_ref_cache\\.([^.]+)\\.(", paste0(class(x), collapse = "|"), ")")
  fs <- grep(f_re, fs, value = TRUE)
  names(fs) <- fs
  fs <- gsub(f_re, "\\1", fs)
  fs <- fs[order(fs)]
  fs
}

pkg_ref_cache <- function(x, name, ..., .class = as.character(name)) {
  UseMethod("pkg_ref_cache", structure(list(), class = .class))
}
