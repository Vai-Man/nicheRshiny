#' Crop a raster to the South American bounding box
#'
#' @param bio1 A `SpatRaster` layer.
#' @return A `SpatRaster` cropped to the extent of South America.
#' @export
crop_south_america <- function(bio1) {
  sa_bbox <- terra::ext(-85, -30, -60, 15)
  terra::crop(bio1, sa_bbox)
}
