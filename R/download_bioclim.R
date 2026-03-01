#' Download WorldClim bioclimatic data
#'
#' @param cache_path Character. Directory path for caching downloaded data.
#' @return A `SpatRaster` stack of 19 bioclimatic variables.
#' @export
download_bioclim <- function(cache_path) {
  geodata::worldclim_global(var = "bio", res = 10, path = cache_path)
}
