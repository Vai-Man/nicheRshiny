#' Mask a raster to South American boundaries
#'
#' Reprojects `sa_polygons` to match `bio1_cropped` if CRS differs, then masks.
#'
#' @param bio1_cropped A `SpatRaster` cropped to South America's extent.
#' @param sa_polygons A `SpatVector` of South American boundaries.
#' @return A masked `SpatRaster`.
#' @export
mask_bioclim <- function(bio1_cropped, sa_polygons) {
  if (!terra::same.crs(bio1_cropped, sa_polygons)) {
    sa_polygons <- terra::project(sa_polygons, terra::crs(bio1_cropped))
  }
  terra::mask(bio1_cropped, sa_polygons)
}
