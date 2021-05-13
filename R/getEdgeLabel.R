#' Obtain labels of edges in a network
#'
#' The `getEdgeLabel` function generates the labels of edges in a network upon
#' being supplied names of the nodes in the network.
#'
#' @param node A numeric or character vector, which contains the names of
#' all nodes in a network.
#'
#' @return A character vector of edge labels for each transcriptional network,
#' which can be used as an input of the `getGeneSetEdgeGroup` function. The
#' label or the name of an edge is denoted in the format of i-j, where i-j
#' denotes an edge that connects node i and node j in the network of interest.
#'
#' @examples
#' getEdgeLabel(c(1:10, 12:20))
#' getEdgeLabel(paste("ROI", 1:5, sep = ""))
#' # In COBRE data
#' getEdgeLabel(c(1:74, 76:264))
#'
#' @export
getEdgeLabel <- function(node) {
   id_mat <- paste(rep(as.character(node), n = length(node)),
                   rep(as.character(node), each = length(node)), sep = "-")
   ids <- matrix(id_mat, nrow = length(node), byrow = FALSE)
   ids <- ids[upper.tri(ids, diag = FALSE)]
   return(ids)
}
