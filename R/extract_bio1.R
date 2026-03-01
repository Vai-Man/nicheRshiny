#' Extract BIO1 layer from a bioclimatic stack
#'
#' @param bio_stack A `SpatRaster` stack returned by [download_bioclim()].
#' @return A single-layer `SpatRaster` representing annual mean temperature.
#' @export
extract_bio1 <- function(bio_stack) {
  bio_stack[[1]]
}
