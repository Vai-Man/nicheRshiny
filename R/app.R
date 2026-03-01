app_ui <- function() {
  shiny::fluidPage(
    shiny::titlePanel("BIO1 Workflow \u2013 South America"),
    shiny::sidebarLayout(
      shiny::sidebarPanel(
        shiny::actionButton("run_workflow", "Run Workflow",
                            class = "btn-primary btn-lg", width = "100%"),
        shiny::hr(),
        shiny::p(
          "Note: Initial run downloads data and may take 1-2 minutes.",
          "Subsequent runs are instant.",
          style = "font-size: 12px; color: #666;"
        )
      ),
      shiny::mainPanel(
        shiny::tabsetPanel(
          shiny::tabPanel("BIO1 Global",
            shiny::plotOutput("plot_global",  height = "500px")),
          shiny::tabPanel("BIO1 Cropped",
            shiny::plotOutput("plot_cropped", height = "500px")),
          shiny::tabPanel("BIO1 Masked",
            shiny::plotOutput("plot_masked",  height = "500px")),
          shiny::tabPanel("Stats",
            shiny::verbatimTextOutput("stats_output"))
        )
      )
    )
  )
}

app_server <- function(input, output, session) {
  cached_data <- shiny::reactiveVal(NULL)

  workflow_data <- shiny::eventReactive(input$run_workflow, {
    if (!is.null(cached_data())) return(cached_data())

    shiny::withProgress(message = "Running workflow...", value = 0, {
      cache_path <- tools::R_user_dir("nicheRshiny", which = "cache")
      dir.create(cache_path, showWarnings = FALSE, recursive = TRUE)

      shiny::incProgress(0.15, detail = "Step 1: Downloading WorldClim")
      bio_stack <- download_bioclim(cache_path)

      shiny::incProgress(0.20, detail = "Step 2: Extracting BIO1")
      bio1_global <- extract_bio1(bio_stack)

      shiny::incProgress(0.30, detail = "Step 3: Cropping to South America")
      bio1_cropped <- crop_south_america(bio1_global)

      shiny::incProgress(0.50, detail = "Step 4: Loading boundaries")
      sa_polygons <- load_boundaries(cache_path)

      shiny::incProgress(0.80, detail = "Step 5: Masking")
      bio1_masked <- mask_bioclim(bio1_cropped, sa_polygons)

      shiny::incProgress(0.95, detail = "Step 6: Statistics")
      stats <- compute_stats(bio1_masked)

      result <- list(
        bio1_global  = bio1_global,
        bio1_cropped = bio1_cropped,
        bio1_masked  = bio1_masked,
        stats        = stats
      )
      cached_data(result)
      result
    })
  })

  output$plot_global <- shiny::renderPlot({
    shiny::req(workflow_data())
    terra::plot(workflow_data()$bio1_global, main = "BIO1 \u2013 Global")
  })

  output$plot_cropped <- shiny::renderPlot({
    shiny::req(workflow_data())
    terra::plot(workflow_data()$bio1_cropped, main = "BIO1 \u2013 Cropped")
  })

  output$plot_masked <- shiny::renderPlot({
    shiny::req(workflow_data())
    terra::plot(workflow_data()$bio1_masked, main = "BIO1 \u2013 Masked")
  })

  output$stats_output <- shiny::renderPrint({
    shiny::req(workflow_data())
    print(workflow_data()$stats)
  })
}
