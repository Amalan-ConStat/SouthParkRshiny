#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @import bslib
#' @import ggplot2
#' @import shinydashboard box
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    bslib::page_navbar(theme = bslib::bs_theme(bg="#F4C430",
                                               fg="darkblue",
                                               primary = "#880808",
                                               secondary = "#880808",
                                               base_font = "Garamond",
                                               heading_font = "Garamond"),
      title = "SouthPark : Rshiny",
      selected = "Basic_Information",
      collapsible = TRUE,
      sidebar = sidebar(tags$head(tags$style(HTML('
                .bslib-page-navbar>.navbar{
                background-color: #C41E3A !important;
                }'))),
                        open = "always",width = "285px",
                        box(width = "285px",tableOutput("Summary_Table")),
                            HTML('<center><img src="www/meme000.gif" width= "240px"></center>')),
      bslib::nav_panel(title = "Basic_Information",
                       icon = icon("grin",lib = "font-awesome"),
                       plotOutput(outputId = "Basic_Plot",width = "1400px",height = "750px"),
                       htmlOutput("Basic_Info_Text")),
      bslib::nav_panel(title = "Ratings and Votes",
                       icon = icon("grin-squint-tears",lib = "font-awesome"),
                       plotOutput(outputId = "Ratings_Votes_Plot",width = "1400px",height = "1200px"),
                       htmlOutput("Ratings_Votes_Text")),
      nav_panel(title = "Sentiment Analysis",
                icon = icon("grin-squint",lib = "font-awesome"),
        tabsetPanel(
          bslib::nav_panel(title = "General",
                           plotOutput(outputId = "Sentiment_General_Plot",
                                      width = "1400px",height="1200px"),
                           htmlOutput("Sentiment_General_Text")),
          bslib::nav_panel(title = "Main Four Characters",
                           plotOutput(outputId = "Sentiment_Four_Plot",
                                      width = "1400px",height="1200px"),
                           htmlOutput("Sentiment_Four_Text")),
          bslib::nav_panel(title = "Supporting Characters",
                           plotOutput(outputId = "Sentiment_Support_Plot",
                                      width = "1400px",height="1200px"),
                           htmlOutput("Sentiment_Support_Text"))
        )
      ),
      bslib::nav_panel(title = "Special Phrases",
                       icon = icon("grin-tongue",lib = "font-awesome"),
                       plotOutput(outputId = "N_Grams_Plot",
                                  width = "1200px",height="1400px"),
                       htmlOutput("Special_Phrases_Text")),
      bslib::nav_panel(title = HTML("</a></li><li><a href='http://www.amalan-mahendran.com/' target='_blank'>About Me"))
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "SouthParkRshiny"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
