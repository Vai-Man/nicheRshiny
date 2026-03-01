#' Compute summary statistics for a raster layer
#'
#' @param bio1_masked A masked `SpatRaster`.
#' @return A `data.frame` with min, max, mean, and sd columns.
#' @export
compute_stats <- function(bio1_masked) {
  terra::global(bio1_masked, fun = c("min", "max", "mean", "sd"), na.rm = TRUE)
}
