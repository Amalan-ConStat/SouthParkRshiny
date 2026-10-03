#' Cooccurrence Plots
#'
#' A network showing how frequently Cartman, Stan, Kyle and Kenny speak
#' in the same episodes across the selected seasons.
#' Nodes represent characters, displayed using their images.
#' Connections are undirected, with widths and labels showing Jaccard similarity:
#' the number of episodes containing both characters divided by the number
#' containing either character. Higher values indicate greater co-occurrence.
#' Shared episodes do not necessarily indicate direct interaction.
#'
#' @examples
#' length(Cooccurrence_Plots)
#'
"Cooccurrence_Plots"
