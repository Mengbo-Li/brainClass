#' Construct gene set edge groups given gene set collection information
#'
#' The `getGeneSetEdgeGroup` function generates the gene set edge groups to be
#' used as the feature groups in `brainclass` classification based on each
#' transcriptional networks from the selected gene set collection.
#'
#' @param GeneSetExpr A list of transcriptional data matrices, each
#' corresponding to a gene set from the gene set collection of interest.
#' Typically, the output from the `getGeneSetExpr` function.
#' @param informativeCutoff The cutoff on edge weights in each region-wise
#' transcriptional network to obtain labels of edges that are the most highly
#' weighted in each gene set expression network, where the weight of an edge
#' i-j or (i-j) is defined as the absolute value of the Pearson correlation
#' coefficient of the gene expression levels of genes in the gene set between
#' regions i and j (e.g., ROI i and ROI j). The default is set to 0.99.
#' @param EdgeLabel The vector of edge labels in each transcriptional network in
#' the list of transcriptional data matrices supplied to GeneSetExpr. This can
#' be obtained using the `getEdgeLabel` function.
#'
#' @return A list object of vectors, each containing labels of edges that are
#' the most highly weighted in the corresponding transcriptional network of a
#' particular gene set, which forms a gene set edge group.
#' The output of `getGeneSetEdgeGroup` can be used as an input of the
#' `brainclass` function.
#'
#' @examples
#' ## NOT RUN
#' # toyGeneSetExpr <- getGeneSetExpr(genExpr = toyData$toyGenExpr, GeneSetList =
#' # toyData$exampleGSC)
#' # toyEdgeLabels <- getEdgeLabel(nodeLabel = rownames(toyData$toyGenExpr))
#' # getGeneSetEdgeGroup(GeneSetExpr = toyGeneSetExpr, informativeCutoff = 0.99,
#' # EdgeLabel = toyEdgeLabels)
#'
#' @export
getGeneSetEdgeGroup <- function(geneExpr, geneSetList, cutoff = 0.99) {
    lapply(geneSetList, function(i) {
        geneSet_expr_network <- abs(stats::cor(t(geneExpr[, i])))
        network_vector <- geneSet_expr_network[upper.tri(geneSet_expr_network,
                                                         diag = FALSE)]
        edgeLabels <- getEdgeLabel(node = rownames(geneExpr))
        edgeLabels[network_vector >= quantile(network_vector, probs = cutoff)]
    })
}
