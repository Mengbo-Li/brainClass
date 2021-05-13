#' Get transcriptional data of each gene set from the selected gene set
#' collection
#'
#' The `getGeneSetExpr` function partitions the transcriptional data matrix,
#' which is the ROI (region of interest) by gene name data matrix, by each gene
#' set in a given gene set collection.
#'
#' @param genExpr Transcriptional data, which should be a brain region (e.g.,
#' ROIs) by gene name (or any type of gene identifiers) data matrix.
#' @param GeneSetList A list of vectors, each consisting of the gene identifiers
#' in the particular gene set.
#'
#' @return A list object of the transcriptional data matrices corresponding to
#' each gene set in the selected gene set collection, which will then be used to
#' calculate the transcriptional network of each gene set of interest, and can
#' be used as the input of `getGeneSetEdgeGroup`.
#'
#' @examples
#' ## NOT RUN
#' # data(toyData)
#' # getGeneSetExpr(genExpr = toyData$toyGenExpr, GeneSetList =
#' # toyData$exampleGSC)
#'
#' @export
getGeneSetExpr <- function(genExpr, GeneSetList) {
    geneSet_genExpr <- lapply(GeneSetList, function(x) {
        geneExp <- as.matrix(genExpr[, x])
        return(geneExp)
    })
    return(geneSet_genExpr)
}
