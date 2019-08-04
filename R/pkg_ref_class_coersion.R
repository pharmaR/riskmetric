#' @importFrom tibble as_tibble
#' @method as_tibble pkg_ref
#' @export
as_tibble.pkg_ref <- function(x, ...) {
  as_tibble(vctrs::new_list_of(list(x),
    ptype = pkg_ref(),
    class = "list_of_pkg_ref"))
}



#' @importFrom tibble as_tibble
#' @method as_tibble list_of_pkg_ref
#' @export
as_tibble.list_of_pkg_ref <- function(x, ...) {
  package_names <- vapply(x, "[[", character(1L), "name")
  versions <- vapply(x, function(xi) as.character(xi$version), character(1L))

  dplyr::tibble(
    package = package_names,
    version = versions,
    pkg_ref = x)
}
