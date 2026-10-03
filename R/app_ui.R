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
    golem_add_external_resources(),

    bslib::page_navbar(title = "SouthPark: RShiny",selected = "basic",fillable = FALSE,
      theme = bslib::bs_theme(version = 5,bg = "#F4C430", fg = "darkblue",
        primary = "#880808", secondary = "#880808",
        base_font = "Garamond", heading_font = "Garamond"),
      navbar_options = bslib::navbar_options(bg = "#C41E3A",theme = "dark",collapsible = TRUE),
      sidebar = bslib::sidebar(open = "always", width = 270,uiOutput("Summary_Table"),
        tags$div(style = "text-align: center;",
          tags$img(src = "www/meme000.gif", width = "240",style = "max-width: 100%;",
            alt = "South Park animation"))),
      # Basic information ----
      bslib::nav_panel(title = "Basic Information", value = "basic",icon = icon("grin"),
        plotOutput("Basic_Plot", width = "100%", height = "750px"),htmlOutput("Basic_Info_Text")),
      # Ratings and votes ----
      bslib::nav_panel(title = "Ratings and Votes", icon = icon("grin-squint-tears"),
        bslib::navset_tab(
          bslib::nav_panel(title = "Ratings",
                           plotOutput("Ratings_Plot", width = "100%", height = "1200px")),
          bslib::nav_panel(title = "Votes",
                           plotOutput("Votes_Plot", width = "100%", height = "1200px"))),
        htmlOutput("Ratings_Votes_Text")
      ),
      # Sentiment analysis ----
      bslib::nav_panel(title = "Sentiment Analysis",icon = icon("grin-squint"),
        bslib::navset_tab(
          bslib::nav_panel(title = "General",
            plotOutput("Sentiment_General_Plot",width = "100%", height = "1000px"),
            htmlOutput("Sentiment_General_Text")),
          bslib::nav_panel(title = "Main Four Characters",
            plotOutput("Sentiment_Four_Plot",width = "100%", height = "900px"),
            htmlOutput("Sentiment_Four_Text")),
          bslib::nav_panel(title = "Supporting Characters",
            plotOutput("Sentiment_Support_Plot",width = "100%", height = "1200px"),
            htmlOutput("Sentiment_Support_Text"))
        )
      ),
      # Special phrases ----
      bslib::nav_panel(title = "Special Phrases",icon = icon("grin-tongue"),
        tags$div(style = "overflow-x: auto;",
          plotOutput("N_Grams_Plot",width = "1200px", height = "1400px")),
        htmlOutput("Special_Phrases_Text")),
      # Character networks ----
      bslib::nav_panel(title = "Character Networks",icon = icon("project-diagram"),
        bslib::layout_columns(col_widths = c(6, 6),
          bslib::card(style = "background-color: deepskyblue;",
            bslib::card_header("Speaking Transitions",
              style = "background-color: deepskyblue; color: darkred;"),
            bslib::card_body(padding = 0,
              plotOutput("Transition_Plot", width = "100%", height = "600px"),
              tags$div(style = "padding: 15px; color: yellow;",
                htmlOutput("Transition_Text")))),
          bslib::card(style = "background-color: deepskyblue;",
            bslib::card_header("Episode Co-occurrence",
              style = "background-color: deepskyblue; color: darkred;"),
            bslib::card_body(padding = 0,
              plotOutput("Cooccurrence_Plot", width = "100%", height = "600px"),
              tags$div(style = "padding: 15px; color: yellow;",
                htmlOutput("Cooccurrence_Text"))))
        )
      ),
      # External link ----
      bslib::nav_item(
        tags$a("About Me",href = "https://amalan-mahendran.com/",
          target = "_blank", rel = "noopener noreferrer",class = "nav-link"))
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
