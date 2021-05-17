#' Obtain labels of edges in a network
#'
#' The `getEdgeLabel` function generates the labels of edges in a network upon
#' names of the nodes in the network.
#'
#' @param node A numeric or character vector, which contains the names of
#' all nodes in a network.
#'
#' @param sep The seperation pattern. Default is "-".
#'
#' @return A character vector of all edge labels for each network.
#'
#' @examples
#' getEdgeLabel(c(1:10, 12:20))
#' getEdgeLabel(paste("ROI", 1:5, sep = ""))
#' # In COBRE data
#' getEdgeLabel(c(1:74, 76:264))
#'
#' @export
getEdgeLabel <- function(node, sep = "-") {
   id_mat <- paste(rep(as.character(node), n = length(node)),
                   rep(as.character(node), each = length(node)), sep = sep)
   ids <- matrix(id_mat, nrow = length(node), byrow = FALSE)
   ids <- ids[upper.tri(ids, diag = FALSE)]
   return(ids)
}
