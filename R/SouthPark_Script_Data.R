#' SouthPark Summary
#'
#' Overall summary plot from the script data.
#'
#' @format A dataframe with
#' \describe{
#' \item{\code{Trivia}{trivial information labels}}
#' \item{\code{Values}{data for the trivial information}}
#' }
#'
#'
"Southpark_Summary"

#' SouthPark Script Data
#'
#' Data for the scripts scraped from the website are stored here.
#' The data consists of season, episode, character and line.
#'
#' @format A dataframe with
#' \describe{
#' \item{\code{Season}}{Season Number}
#' \item{\code{Episode}}{Episode Number}
#' \item{\code{Character}}{Character Name}
#' \item{\code{Line}}{The lines the character spoke}
#' }
#'
#' @examples
#' unique(SouthPark_Script_Data$Season) # the seasons of the show
#' unique(SouthPark_Script_Data$Character) |> length() # the unique characters in the show
#'
"SouthPark_Script_Data"


#' SouthPark IMDB Data
#' Data from the IMDB website are extracted for the show.
#' The data consists of season, episode, primarytitle, originaltitle, year, runtime(in minutes),
#' averagerating and number of votes.
#'
#' @format A dataframe with
#' \describe{
#' \item{\code{Season}{Season Number}}
#' \item{\code{Episode}{Episode Number}}
#' \item{\code{PrimaryTitle}{primary title of the episode}}
#' \item{\code{OriginalTitle}{original title of the episode}}
#' \item{\code{Year}{year the episode was aired}}
#' \item{\code{Runtime}{runtime in minutes}}
#' \item{\code{AverageRating}{average rating out of 10}}
#' \item{\code{NumberOfVotes}{number of votes recorded}}
#' }
#'
#' @examples
#'
#' sort(unique(SouthPark_IMDB_Data$Season)) # the seasons of the show
#' mean(SouthPark_IMDB_Data$AverageRating) # the average rating of the show
#' sum(SouthPark_IMDB_Data$NumberOfVotes) # sum of the number of votes
"SouthPark_IMDB_Data"

#' N Grams plots
#'
#' Three and four word phrases common among seasons, main characters and supporting characters
#' are summarised through a plot here, from the script data.
#'
#' @format A list with
#' \describe{
#' \item{\code{1}{Three word pharases over seasons}}
#' \item{\code{2}{Four word pharases over seasons}}
#' \item{\code{3}{Three word pharases over main characters}}
#' \item{\code{4}{Four word pharases over main characters}}
#' \item{\code{5}{Three word pharases over supporting characters}}
#' \item{\code{6}{Four word pharases over supporting characters}}
#' }
#'
#' @examples
#' length(N_Grams_plots)
#'
"N_Grams_plots"

#' Sentiment General plots
#'
#' Number of positive and negative words based on bing,nrc,loughran among the seasons
#' are summarised through a plot here, from the script data.
#'
#' @format A list with
#' \describe{
#' \item{\code{1}{positive words from bing over seasons}}
#' \item{\code{2}{negative words from bing over seasons}}
#' \item{\code{3}{positive words from nrc over seasons}}
#' \item{\code{4}{negative words from nrc over seasons}}
#' \item{\code{5}{positive words from loughran over seasons}}
#' \item{\code{6}{negative words from loughran over seasons}}
#' }
#'
#' @examples
#' length(Sentiment_General_plots)
#'
"Sentiment_General_plots"

#' Sentiment Four plots
#'
#' Number of positive and negative words based on bing,nrc,loughran among the main four characters
#' per season are summarised through a plot here, from the script data.
#'
#' @format A list with
#' \describe{
#' \item{\code{1}{positive words from bing over seasons}}
#' \item{\code{2}{negative words from bing over seasons}}
#' \item{\code{3}{positive words from nrc over seasons}}
#' \item{\code{4}{negative words from nrc over seasons}}
#' \item{\code{5}{positive words from loughran over seasons}}
#' \item{\code{6}{negative words from loughran over seasons}}
#' }
#'
#' @examples
#' length(Sentiment_Four_plots)
#'
"Sentiment_Four_plots"

#' Sentiment Support plots
#'
#' Number of positive and negative words based on bing,nrc,loughran among the supporting characters
#' per season are summarised through a plot here, from the script data.
#'
#' @format A list with
#' \describe{
#' \item{\code{1}{positive words from bing over seasons}}
#' \item{\code{2}{negative words from bing over seasons}}
#' \item{\code{3}{positive words from nrc over seasons}}
#' \item{\code{4}{negative words from nrc over seasons}}
#' \item{\code{5}{positive words from loughran over seasons}}
#' \item{\code{6}{negative words from loughran over seasons}}
#' }
#'
#' @examples
#' length(Sentiment_Support_plots)
#'
"Sentiment_Support_plots"

#' Ratings Votes plots
#'
#' Detailed plots for ratings and votes from the IMDB data.
#'
#' @format A list with
#' \describe{
#' \item{\code{1}{Rating for all seasons and episodes}}
#' \item{\code{2}{Votes for all seasons and episodes}}
#' }
#'
#' @examples
#' length(Ratings_Votes_plots)
#'
"Ratings_Votes_plots"


#' Swear words plots
#'
#' Swear word plots for main and supporting characters per seasons.
#' Total number of words and unique words are summarised through plots.
#'
#' @format A list with
#' \describe{
#' \item{\code{1}{Swear words in general}}
#' \item{\code{2}{Swear words for main characters}}
#' \item{\code{3}{Swear words for supporting characters}}
#' }
#'
#' @examples
#' length(Swear_Words_plots)
#'
"Swear_Words_plots"

#' Basic plots
#'
#' Average rating and votes summarised in different ways.
#'
#' @format A list with
#' \describe{
#' \item{\code{1}{Number of Votes vs Average Rating}}
#' \item{\code{2}{Number of episodes in seasons and their runtime}}
#' \item{\code{3}{Average ratings and votes for each season}}
#' }
#'
#' @examples
#' length(Basic_plots)
#'
"Basic_plots"
