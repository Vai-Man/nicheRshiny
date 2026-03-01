#' Launch the nicheRshiny Shiny application
#'
#' @return Launches a Shiny app; does not return a value.
#' @export
#' @examples
#' if (interactive()) run_app()
run_app <- function() {
  shiny::shinyApp(ui = app_ui(), server = app_server)
}
