#' Obtain labels of edges in a network
#'
#' The `getEdgeLabel` function generates the labels of edges in a network upon
#' being supplied names of the nodes in the network.
#'
#' @param nodeLabel A numeric or character vector, which contains the names of
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
getEdgeLabel <- function(nodeLabel) {
    nodeLabel <- as.character(nodeLabel)
    network_ref <- matrix(stringr::str_c(rep(nodeLabel, length(nodeLabel)),
                                            rep(nodeLabel, each =
                                                    length(nodeLabel)),
                                        sep = "-"), nrow = length(nodeLabel),
                        byrow = FALSE)
    resEdgeLabel <- network_ref[upper.tri(network_ref, diag = FALSE)]
    return(resEdgeLabel)
}
