#' @importFrom pillar pillar_shaft
#' @method pillar_shaft list_of_pkg_metric
#' @export
pillar_shaft.list_of_pkg_metric <- function(x, ...) {
  ucx <- lapply(x, unclass)
  p <- pillar::pillar_shaft(ucx)

  is_error <- vapply(x, inherits, logical(1L), "pkg_metric_error")
  p[[1]][is_error] <- vapply(x[is_error], function(xi) {
    pillar::pillar_shaft(xi)[[1]]
  }, character(1L))

  is_atomic_l1 <- vapply(ucx, function(xi) is.atomic(xi) && length(xi) == 1, logical(1L))
  p[[1]][is_atomic_l1] <- vapply(ucx[is_atomic_l1], function(xi) {
    capture.output(pillar::pillar_shaft(xi))
  }, character(1L))

  p
}



#' @importFrom vctrs vec_cast.double
#' @method vec_cast.double list_of_pkg_metric
#' @export
vec_cast.double.list_of_pkg_metric <- function(x, to) {
  out <- vector("numeric", length(x))
  is_error <- vapply(x, inherits, logical(1L), "pkg_metric_error")
  out[is_error] <- NA_real_
  out[!is_error] <- vapply(x, unclass, numeric(1L))
  out
}
