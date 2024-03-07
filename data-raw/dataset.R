## code to prepare `dataset` dataset goes here
load("data-raw/SouthPark_Script_Data.RData")
usethis::use_data(SouthPark_Script_Data,overwrite = TRUE,compress = "xz")

load("data-raw/SouthPark_IMDB_Data.RData")
usethis::use_data(SouthPark_IMDB_Data,overwrite = TRUE,compress = "xz")

load("data-raw/N_Grams_Plots.RData")
usethis::use_data(N_Grams_plots,overwrite = TRUE,compress = "xz")

load("data-raw/Ratings_Votes_Plots.RData")
usethis::use_data(Ratings_Votes_plots,overwrite = TRUE,compress = "xz")

load("data-raw/Sentiment_Four_Plots.RData")
usethis::use_data(Sentiment_Four_plots,overwrite = TRUE,compress = "xz")

load("data-raw/Sentiment_General_Plots.RData")
usethis::use_data(Sentiment_General_plots,overwrite = TRUE,compress = "xz")

load("data-raw/Sentiment_Support_Plots.RData")
usethis::use_data(Sentiment_Support_plots,overwrite = TRUE,compress = "xz")

load("data-raw/Swear_Words_Plots.RData")
usethis::use_data(Swear_Words_plots,overwrite = TRUE,compress = "xz")

load("data-raw/Basic_Plots.RData")
usethis::use_data(Basic_plots,overwrite = TRUE,compress = "xz")

load("data-raw/SouthPark_Summary.RData")
usethis::use_data(Southpark_Summary,overwrite = TRUE,compress = "xz")
