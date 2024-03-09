#' SouthPark IMDB Data
#' Data from the IMDB website are extracted for the show.
#' The data consists of season, episode, primarytitle, originaltitle, year, runtime(in minutes),
#' averagerating and number of votes.
#'
#' @format A dataframe with
#' \describe{
#' \item{\code{Season}}{Season Number}
#' \item{\code{Episode}}{Episode Number}
#' \item{\code{PrimaryTitle}}{primary title of the episode}
#' \item{\code{OriginalTitle}}{original title of the episode}
#' \item{\code{Year}}{year the episode was aired}
#' \item{\code{Runtime}}{runtime in minutes}
#' \item{\code{AverageRating}}{average rating out of 10}
#' \item{\code{NumberOfVotes}}{number of votes recorded}
#' }
#'
#' @examples
#'
#' sort(unique(SouthPark_IMDB_Data$Season)) # the seasons of the show
#' mean(SouthPark_IMDB_Data$AverageRating) # the average rating of the show
#' sum(SouthPark_IMDB_Data$NumberOfVotes) # sum of the number of votes
#'
"SouthPark_IMDB_Data"
