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
