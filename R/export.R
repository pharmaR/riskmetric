serialize_with_attributes <- function(x) {
  if (is.list(x) && !is.null(names(x))) {
    result <- list()
    for (n in names(x)) {
      result[[n]] <- serialize_with_attributes(x[[n]])
    }
    return(result)
  }

  # For atomic or S3 elements with attributes
  val <- unclass(x)
  attrs <- attributes(x)

  # Sanitize attributes (no S3 objects inside)
  if (!is.null(attrs)) {
    for (a in names(attrs)) {
      if (inherits(attrs[[a]], "AsIs") || is.factor(attrs[[a]])) {
        attrs[[a]] <- as.character(attrs[[a]])
      } else if (!is.atomic(attrs[[a]])) {
        attrs[[a]] <- unclass(attrs[[a]])
      }
    }
  }

  list(
    value = val,
    attributes = attrs
  )
}


export_json <- function(metrics, file = "PACKAGES.json") {
  metrics_serialized <- serialize_with_attributes(metrics)
  jsonlite::write_json(metrics_serialized, path = file, pretty = TRUE, auto_unbox = FALSE)
}

export_dcf <- function(metrics, file = "PACKAGES") {
  write.dcf(metrics, file = file)
}
