# nicheRshiny

Interactive Shiny app that downloads WorldClim bioclimatic data, crops and masks BIO1 to South America, and reports summary statistics.

## Installation

```r
# install.packages("remotes")
remotes::install_github("vai-man/nicheRshiny")
```

## Usage

```r
library(nicheRshiny)
run_app()
```

## Workflow

1. **Download** – Fetches WorldClim 10-min resolution bioclimatic variables via `geodata`.
2. **Extract** – Selects the BIO1 (annual mean temperature) layer.
3. **Crop** – Clips to South American bounding box (`-85, -30, -60, 15`).
4. **Boundaries** – Downloads and caches GADM level-0 polygons for 13 South American countries.
5. **Mask** – Masks the raster to the continent outline.
6. **Statistics** – Reports min, max, mean, and sd.

Downloaded data is cached in `tools::R_user_dir("nicheRshiny", which = "cache")` so subsequent runs are instant.
