#' Run the Shiny Application
#'
#' @param ... list of golem options.
#'
#' @return used for side effects
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
  # onStart = NULL,
  # options = list(),
  # enableBookmarking = NULL,
  # uiPattern = "/",
  ...
) {
  with_golem_options(
    app = shinyApp(
      ui = app_ui,
      server = app_server#,
      # onStart = onStart,
      # options = options,
      # enableBookmarking = enableBookmarking,
      # uiPattern = uiPattern
    ),
    # golem_opts = list(...)
    golem_opts = list(Southpark_Summary=SouthParkRshiny::Southpark_Summary,
                      SouthPark_IMDB_Data=SouthParkRshiny::SouthPark_IMDB_Data,
                      SouthPark_Script_Data=SouthParkRshiny::SouthPark_Script_Data,
                      Basic_plots=SouthParkRshiny::Basic_plots,
                      Swear_Words_plots=SouthParkRshiny::Swear_Words_plots,
                      Sentiment_General_plots=SouthParkRshiny::Sentiment_General_plots,
                      Sentiment_Four_plots=SouthParkRshiny::Sentiment_Four_plots,
                      Sentiment_Support_plots=SouthParkRshiny::Sentiment_Support_plots,
                      N_Grams_plots=SouthParkRshiny::N_Grams_plots,
                      Ratings_Votes_plots=SouthParkRshiny::Ratings_Votes_plots)
  )
}
