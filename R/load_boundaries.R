#' Load South American country boundaries
#'
#' Downloads and merges GADM level-0 polygons for all South American countries.
#' Results are cached to `cache_path` as an RDS file.
#'
#' @param cache_path Character. Directory used for caching.
#' @return A `SpatVector` of the merged South American continent polygon.
#' @export
load_boundaries <- function(cache_path) {
  sa_continent_file <- file.path(cache_path, "south_america_continent.gpkg")

  if (file.exists(sa_continent_file)) {
    return(terra::vect(sa_continent_file))
  }

  sa_countries <- c("ARG", "BOL", "BRA", "CHL", "COL", "ECU",
                    "GUF", "GUY", "PRY", "PER", "SUR", "URY", "VEN")

  polys_list <- lapply(sa_countries, function(code) {
    geodata::gadm(code, level = 0, path = cache_path)
  })

  sa_polygons <- terra::aggregate(do.call(rbind, polys_list))
  terra::writeVector(sa_polygons, sa_continent_file, overwrite = TRUE)
  sa_polygons
}
