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
#' @noRd
app_server <- function(input, output, session) {

  get_golem_options("Southpark_Summary")
  get_golem_options("SouthPark_IMDB_Data")
  get_golem_options("SouthPark_Script_Data")

  get_golem_options("Basic_plots")
  get_golem_options("Swear_Words_plots")
  get_golem_options("Ratings_Votes_plots")

  get_golem_options("Sentiment_General_plots")
  get_golem_options("Sentiment_Four_plots")
  get_golem_options("Sentiment_Support_plots")

  get_golem_options("N_Grams_plots")

  Southpark_Summary<-SouthParkRshiny::Southpark_Summary
  SouthPark_IMDB_Data<-SouthParkRshiny::SouthPark_IMDB_Data
  SouthPark_Script_Data<-SouthParkRshiny::SouthPark_Script_Data

  Basic_plots<-SouthParkRshiny::Basic_plots
  Swear_Words_plots<-SouthParkRshiny::Swear_Words_plots
  Ratings_Votes_plots<-SouthParkRshiny::Ratings_Votes_plots

  Sentiment_General_plots<-SouthParkRshiny::Sentiment_General_plots
  Sentiment_Four_plots<-SouthParkRshiny::Sentiment_Four_plots
  Sentiment_Support_plots<-SouthParkRshiny::Sentiment_Support_plots

  N_Grams_plots<-SouthParkRshiny::N_Grams_plots

  # Your application server logic
  output$Summary_Table<-function(){
    Southpark_Summary |>
      kable("html")  |>
      kable_styling("striped", full_width = F,font_size = 14 )  |>
      column_spec(2,background = "deepskyblue",color="white",
                  border_right = TRUE,width = "2cm")  |>
      column_spec(1,background = "blue",color="white",width = "4cm")  |>
      row_spec(c(9,13),background = "#CC0000",color="white") |>
      row_spec(0,background = "#FF69B4")
    }


  Basic_Plot<-list(Basic_plots[[1]],Basic_plots[[2]],Basic_plots[[3]],
                   Swear_Words_plots[[1]],Swear_Words_plots[[2]],Swear_Words_plots[[3]])

  output$Basic_Plot<-renderPlot({
    suppressWarnings(ggarrange(plotlist = Basic_Plot,nrow = 2,ncol = 3,labels = "auto"))
  })

  output$Basic_Info_Text<-renderUI({
    paste0("Figure a) plots the relationship between rating and votes.",
           "The episodes 'Scott Tenarman Must Die' and 'Make Love, Not Warcraft' have high amount of votes and rating.",
           "b) Indicates the number of episodes per each season and their runtimes.",
           "c) Represents the average rating and votes per season.",
           "d) Swear words in total are counted for each season.",
           "e) Swear words spoken by the main four characters are counted for each season.",
           "f) Swear words spoken by the close contact of the main characters are counted.")
  })

  output$Ratings_Votes_Plot<-renderPlot({
    ggarrange(plotlist = Ratings_Votes_plots, nrow=2,labels = "auto")
  })

  output$Ratings_Votes_Text<-renderUI({
    paste0("Figure a) Rating for all the episodes are ploted, high and low rated episodes are colored in blue and red.",
           "Figure b) Similarly votes are plotted for all the episodes.")
  })

  output$Sentiment_General_Plot<-renderPlot({
    ggarrange(plotlist = Sentiment_General_plots,nrow = 3,ncol = 2,labels = "auto")
  })

  output$Sentiment_General_Text<-renderUI({
    paste0("Figure a) and b) Number of positive and negative words in total based on bing corpus.",
           "Figure c) and d) Number of postivie and negative words in total based on nrc corpus.",
           "Figure e) and f) Number of positive and negative words in total based on loughran.")
  })

  output$Sentiment_Four_Plot<-renderPlot({
    ggarrange(plotlist = Sentiment_Four_plots,nrow = 3,ncol = 2,common.legend = TRUE,
              legend = "bottom",labels = "auto")+bgcolor("lightskyblue")
  })

  output$Sentiment_Four_Text<-renderUI({
    paste0("Figure a) and b) Number of positive and negative words for the main four characters (bing).",
           "Figure c) and d) Number of positive and negative words for the main four characters (nrc).",
           "Figure e) and f) Number of positive and negative words for the main four characters (loughran).")
  })

  output$Sentiment_Support_Plot<-renderPlot({
    ggarrange(plotlist = Sentiment_Support_plots,nrow = 3,ncol = 2,common.legend = TRUE,
              legend = "bottom",labels = "auto")+bgcolor("lightskyblue")
  })

  output$Sentiment_Support_Text<-renderUI({
    paste0("Figure a) and b) Number of positive and negative words for the supporting characters (bing).",
           "Figure c) and d) Number of positive and negative words for the supporting characters (nrc).",
           "Figure e) and f) Number of positive and negative words for the supporting characters (loughran).")
  })

  output$N_Grams_Plot<-renderPlot({
    ggarrange(ggarrange(plotlist = N_Grams_plots[1:2],ncol = 2,common.legend = TRUE,legend="bottom"),
              ggarrange(plotlist = N_Grams_plots[3:4],ncol = 2,common.legend = TRUE,legend="bottom"),
              ggarrange(plotlist = N_Grams_plots[5:6],ncol = 2,common.legend = TRUE,legend="bottom"),
              nrow = 3,labels = "auto")+bgcolor("lightskyblue")
  })

  output$Special_Phrases_Text<-renderUI({
    paste0("Figure a) and b) Most spoken common phrases of three and four words are counted for each season.",
           "Figure c) and d) Most spoken common phrases of three and four words are counted for the main characters.",
           "Figure e) and f) Most spoken common phrases of three and four words are counted for the supporting characters.")
  })
}
