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
                      SouthPark_Script_Data=SouthParkRshiny::SouthPark_Script_Data,
                      SouthPark_IMDB_Data=SouthParkRshiny::SouthPark_IMDB_Data,
                      Ratings_Votes_Plots=SouthParkRshiny::Ratings_Votes_Plots,
                      Basic_Plots=SouthParkRshiny::Basic_Plots,
                      Swear_Words_Plots=SouthParkRshiny::Swear_Words_Plots,
                      Sentiment_General_Plots=SouthParkRshiny::Sentiment_General_Plots,
                      Friends_Sentiment_Plots=SouthParkRshiny::Friends_Sentiment_Plots,
                      Support_Sentiment_Plots=SouthParkRshiny::Support_Sentiment_Plots,
                      N_Grams_Plots=SouthParkRshiny::N_Grams_Plots,
                      Transition_Plots=SouthParkRshiny::Transition_Plots,
                      Cooccurrence_Plots=SouthParkRshiny::Cooccurrence_Plots)
  )
}
