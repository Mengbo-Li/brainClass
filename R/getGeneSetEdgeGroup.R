#' Construct gene set edge groups for a gene set collection (GSC) of interest
#'
#' The `getGeneSetEdgeGroup` function generates the gene set edge groups in
#' `brainclass` classification.
#'
#' @param geneExpr The ROI-by-gene data frame or matrix. Potentially the output
#' from the `filterGeneExpr` function.
#'
#' @param geneSetList A gene set collection stored in a list. Potentially the
#' output from the `filterGeneSets` function
#'
#' @param cutoff The hard-thresholding cutoff on edge weights.
#'
#' @return A list object of vectors, each containing labels of edges that are
#' the most highly weighted in the corresponding gene set expression network.
#' Each item in the returned list represents a gene set edge group. These gene
#' set edge groups are used as feature groups in `brainclass` classification.
#'
#' @examples
#' ## NOT RUN
#' # data(ahba)
#' # data(gscv7.0)
#' # ahba <- filterGeneExpr(ahba)
#' # kegg <- filterGeneSets(geneSetList = gscv7.0$kegg,
#' # candidateGenes = colnames(ahba), min.size = 5, max.size = Inf)
#' # keggEdgeGrp <- getGeneSetEdgeGroup(geneExpr = ahba, geneSetList = kegg)
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
