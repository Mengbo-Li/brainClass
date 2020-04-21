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
#' data(toyData)
#' toyGeneSetExpr <- getGeneSetExpr(genExpr = toyData$toyGenExpr, GeneSetList =
#' toyData$exampleGSC)
#' toyEdgeLabels <- getEdgeLabel(nodeLabel = rownames(toyData$toyGenExpr))
#' getGeneSetEdgeGroup(GeneSetExpr = toyGeneSetExpr, informativeCutoff = 0.99,
#' EdgeLabel = toyEdgeLabels)
#'
#' @export
getGeneSetEdgeGroup <- function(GeneSetExpr, informativeCutoff = 0.99,
                                EdgeLabel) {
    GS_edge_grp <- lapply(GeneSetExpr, function(gs_expr) {
        gene_expr_net <- abs(stats::cor(t(gs_expr)))
        gene_expr_netVec <- gene_expr_net[upper.tri(gene_expr_net,diag = FALSE)]
        gs_specific_edge_grps <- EdgeLabel[gene_expr_netVec >=
                                            stats::quantile(gene_expr_netVec,
                                                probs = informativeCutoff)]
        return(gs_specific_edge_grps)
    })
    return(GS_edge_grp)
}
