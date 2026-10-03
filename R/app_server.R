#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @import bslib
#' @import ggplot2
#' @import ggpubr
#' @import golem
#' @import knitr
#' @import kableExtra
#' @importFrom ggtext element_markdown
#' @importFrom ggimage geom_image
#' @importFrom ggraph geom_edge_fan geom_edge_link
#' @noRd
app_server <- function(input, output, session) {

  # Resolve character images from the installed package
  Special_Friends_Faces <- stats::setNames(
    system.file("app", "www", "Images",c("Cartman.png", "Stan.png", "Kyle.png", "Kenny.png"),
                package = "SouthParkRshiny", mustWork = TRUE),
    c("Cartman", "Stan", "Kyle", "Kenny"))

  Support_Characters_Faces <- stats::setNames(
    system.file("app", "www", "Images",c("Liane.png", "Randy.png", "Sharon.png",
                                         "Gerald.png", "Sheila.png", "Mr_Garrison.png"),
                package = "SouthParkRshiny", mustWork = TRUE),
    c("Liane", "Randy", "Sharon", "Gerald", "Sheila", "Mr. Garrison"))

  get_golem_options("Southpark_Summary")
  get_golem_options("SouthPark_IMDB_Data")
  get_golem_options("SouthPark_Script_Data")

  get_golem_options("Basic_Plots")
  get_golem_options("Swear_Words_Plots")
  get_golem_options("Ratings_Votes_Plots")

  get_golem_options("Sentiment_General_Plots")
  get_golem_options("Friends_Sentiment_Plots")
  get_golem_options("Support_Sentiment_Plots")

  get_golem_options("N_Grams_Plots")

  get_golem_options("Transition_Plots")
  get_golem_options("Cooccurrence_Plots")

  Southpark_Summary<-SouthParkRshiny::Southpark_Summary
  SouthPark_IMDB_Data<-SouthParkRshiny::SouthPark_IMDB_Data
  SouthPark_Script_Data<-SouthParkRshiny::SouthPark_Script_Data

  Basic_Plots<-SouthParkRshiny::Basic_Plots
  Swear_Words_Plots<-SouthParkRshiny::Swear_Words_Plots
  Ratings_Votes_Plots<-SouthParkRshiny::Ratings_Votes_Plots

  Sentiment_General_Plots<-SouthParkRshiny::Sentiment_General_Plots
  Friends_Sentiment_Plots<-SouthParkRshiny::Friends_Sentiment_Plots
  Support_Sentiment_Plots<-SouthParkRshiny::Support_Sentiment_Plots

  N_Grams_Plots<-SouthParkRshiny::N_Grams_Plots

  Transition_Plots<-SouthParkRshiny::Transition_Plots
  Cooccurrence_Plots<-SouthParkRshiny::Cooccurrence_Plots

  Prepare_Sentiment_Plot <- function(x) {
    if (inherits(x, "ggplot") || inherits(x, "patchwork")) return(x)

    if (is.list(x)) {
      return(patchwork::wrap_plots(x, ncol = 1, guides = "keep"))
    }

    stop("Expected a plot object or a list of plots.")
  }

  Update_Network_Images <- function(p) {
    Faces <- c(Special_Friends_Faces, Support_Characters_Faces)

    if (all(c("name", "Image") %in% names(p$data))) {
      p$data$Image <- unname(Faces[as.character(p$data$name)])
    }

    # Update layers that contain their own node data
    for (i in seq_along(p$layers)) {
      Layer_Data <- p$layers[[i]]$data

      if (is.data.frame(Layer_Data) &&
          all(c("name", "Image") %in% names(Layer_Data))) {
        Layer_Data$Image <- unname(Faces[as.character(Layer_Data$name)])
        p$layers[[i]]$data <- Layer_Data
      }
    }
    p
  }

  Transition_Plots <- Update_Network_Images(Transition_Plots)
  Cooccurrence_Plots <- Update_Network_Images(Cooccurrence_Plots)

  Make_Face_Labels <- function(Faces) {
    stats::setNames(
      paste0("<img src='", Faces, "' width='30'/> ", names(Faces)),
      names(Faces)
    )
  }

  Special_Friends_Labels <- Make_Face_Labels(Special_Friends_Faces)
  Support_Characters_Labels <- Make_Face_Labels(Support_Characters_Faces)

  Update_Heatmap_Images <- function(p, Labels) {
    Face_Scale <- ggplot2::scale_y_discrete(labels = Labels)
    Face_Theme <- ggplot2::theme(axis.text.y = ggtext::element_markdown(size = 9, face = "bold",
                                                                        colour = "red"))

    if (inherits(p, "patchwork")) {
      return((p & Face_Scale) & Face_Theme)
    }

    if (inherits(p, "ggplot")) {
      return(p + Face_Scale + Face_Theme)
    }

    if (is.list(p)) {
      return(lapply(p, Update_Heatmap_Images, Labels = Labels))
    }

    stop("Expected a ggplot, patchwork or list of plots.")
  }

  Friends_Sentiment_Plots <- Update_Heatmap_Images(Friends_Sentiment_Plots, Special_Friends_Labels)
  Support_Sentiment_Plots <- Update_Heatmap_Images(Support_Sentiment_Plots, Support_Characters_Labels)

  # Your application server logic
  output$Summary_Table<-renderUI({
    Summary_HTML <- Southpark_Summary |>
      kable("html") |>
      kable_styling("striped", full_width = FALSE, font_size = 14) |>
      column_spec(2, background = "deepskyblue", color = "white",
                  border_right = TRUE, width = "2cm") |>
      column_spec(1, background = "blue", color = "white", width = "4cm") |>
      row_spec(c(9, 13, 14), background = "#CC0000", color = "white") |>
      row_spec(0, background = "#FF69B4")

    HTML(as.character(Summary_HTML))
  })

  Basic_Plot <- c(Basic_Plots[1:3], Swear_Words_Plots[1:3])

  output$Basic_Plot<-renderPlot({
    ggarrange(plotlist = Basic_Plot, nrow = 2, ncol = 3, labels = "auto")
  })

  output$Basic_Info_Text<-renderUI({
    tags$p("Figure a shows the relationship between episode ratings and vote counts. ",
           "Figure b summarises episode counts and runtimes by season. ",
           "Figure c summarises average ratings and votes by season. ",
           "Figures d to f show profanity rates for everyone, the four main characters, ",
           "and the selected supporting characters, respectively. ",
           "In stacked character plots, the total height sums character-specific rates; ",
           "it does not represent a combined season rate.")
  })

  Prepare_Ratings_Plot <- function(p) {
    p + ggplot2::facet_wrap(~ seasonNumber, ncol = 4, scales = "free_x") +
      ggplot2::theme(axis.text = ggplot2::element_text(size = 6),
                     axis.title = ggplot2::element_text(size = 9),
                     strip.text = ggplot2::element_text(size = 9, face = "bold"),
                     plot.title = ggplot2::element_text(size = 12, face = "bold"),
                     legend.text = ggplot2::element_text(size = 9),
                     legend.title = ggplot2::element_text(size = 10))
  }

  output$Ratings_Plot <- renderPlot({
    print(Prepare_Ratings_Plot(Ratings_Votes_Plots[[1]]))})

  output$Votes_Plot <- renderPlot({
    print(Prepare_Ratings_Plot(Ratings_Votes_Plots[[2]]))})

  output$Ratings_Votes_Text <- renderUI({
    tags$p("Ratings highlight the highest and lowest rated episodes in each season. ",
           "Votes highlight the most and least voted episodes in each season. ",
           "Blue indicates the highest values and red the lowest. ",
           "Vote counts measure participation rather than episode quality.")
  })

  output$Sentiment_General_Plot<-renderPlot({
    print(Prepare_Sentiment_Plot(Sentiment_General_Plots))
  })

  output$Sentiment_General_Text<-renderUI({
    tags$p("The three panels use the Bing, NRC and Loughran dictionaries. ",
           "Bars show the numbers of episodes with more positive or negative matches ",
           "(left axis); episodes with equal counts are omitted. ",
           "Lines show positive and negative word matches per 100 words ",
           "in each season (right axis).")
  })

  output$Sentiment_Four_Plot<-renderPlot({
    print(Prepare_Sentiment_Plot(Friends_Sentiment_Plots))
  })

  output$Sentiment_Four_Text<-renderUI({
    tags$p("Heatmaps compare Cartman, Stan, Kyle and Kenny across seasons using ",
           "the Bing, NRC and Loughran dictionaries. ",
           "Green indicates a higher positive rate, red a higher negative rate, ",
           "and white equal rates. Tile labels show the higher rate per 100 words ",
           "spoken by that character in that season. ",
           "Each dictionary has its own colour scale.")
  })

  output$Sentiment_Support_Plot<-renderPlot({
    print(Prepare_Sentiment_Plot(Support_Sentiment_Plots))
  })

  output$Sentiment_Support_Text<-renderUI({
    tags$p("Heatmaps compare Liane, Randy, Sharon, Gerald, Sheila and Mr. Garrison ",
           "across seasons using the Bing, NRC and Loughran dictionaries. ",
           "Green indicates a higher positive rate, red a higher negative rate, ",
           "and white equal rates. Grey indicates no tokenized dialogue. ",
           "Tile labels show the higher rate per 100 words spoken by each character. ",
           "Each dictionary has its own colour scale.")
  })

  Network_Background <- ggplot2::theme(
    plot.background = ggplot2::element_rect(fill = "deepskyblue", colour = NA),
    panel.background = ggplot2::element_rect(fill = "deepskyblue", colour = NA)
  )

  output$Transition_Plot <- renderPlot({print(Transition_Plots + Network_Background)},
                                       bg = "deepskyblue")

  output$Cooccurrence_Plot <- renderPlot({print(Cooccurrence_Plots + Network_Background)},
                                         bg = "deepskyblue")

  output$Transition_Text <- renderUI({
    tagList(tags$p("Arrows show speaking transitions between characters. ",
                   "An arrow from Cartman to Stan means Stan speaks immediately ",
                   "after Cartman in the transcript, within the same episode."),
            tags$p("Edge labels show the percentage of a character's transitions ",
                   "to a different speaker that lead to the indicated character. ",
                   "Thicker arrows represent higher percentages. ",
                   "The calculation includes transitions to all other speakers, ",
                   "so the percentages displayed for each character may not sum to 100%."),
            tags$p("Speaking order does not necessarily indicate that one character ",
                   "is directly addressing another."))
  })

  output$Cooccurrence_Text <- renderUI({
    tagList(tags$p("Connections link characters who have dialogue in the same episodes. ",
                   "These connections have no direction."),
            tags$p("Edge labels show Jaccard similarity: the number of episodes ",
                   "containing dialogue from both characters divided by the number ",
                   "containing dialogue from either character. ",
                   "Values range from 0 to 1; higher values and thicker connections ",
                   "indicate greater overlap in episode appearances."),
            tags$p("For example, 0.80 means both characters speak in 80% of the episodes ",
                   "in which at least one of them speaks. ",
                   "Sharing an episode does not necessarily mean sharing a scene ",
                   "or interacting directly."))
  })

  output$N_Grams_Plot<-renderPlot({
    ggarrange(ggarrange(plotlist = N_Grams_Plots[1:2],ncol = 2,common.legend = TRUE,legend="bottom"),
              ggarrange(plotlist = N_Grams_Plots[3:4],ncol = 2,common.legend = TRUE,legend="bottom"),
              ggarrange(plotlist = N_Grams_Plots[5:6],ncol = 2,common.legend = TRUE,legend="bottom"),
              nrow = 3,labels = "auto")+bgcolor("lightskyblue")
  })

  output$Special_Phrases_Text<-renderUI({
    tags$p("Figures a and b show frequent three-word and four-word phrases by season. ",
           "Figures c and d show these phrases for the main characters. ",
           "Figures e and f show these phrases for the supporting characters.")
  })
}
