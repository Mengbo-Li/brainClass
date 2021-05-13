#' Filter gene sets by size and presence of the gene in the reference gene
#' expression data set
#'
#' The `filterGeneSets` function filters gene sets by their sizes, and filters
#' out genes not in the candidate list.
#'
#' @param geneSetList A gene set collection stored in a list.
#'
#' @param candidateGenes A character vector of all genes to be considered.
#'
#' @param min.size Minimum number of genes to keep a gene set.
#'
#' @param max.size Maximum number of genes to keep a gene set.
#'
#' @return Filtered list of gene sets given the gene set collection.
#'
#' @examples
#' ## NOT RUN
#' # filterGeneSets(gscv7.0$kegg, colnames(ahba), min.size = 5, max.size = Inf)
#'
#' @export
filterGeneSets <- function(geneSetList,
                           candidateGenes,
                           min.size = 25,
                           max.size = 500) {
   filt1 <- lapply(geneSetList, function(i) {intersect(candidateGenes, i)})
   filt1_length <- sapply(filt1, length)
   filt2 <- filt1[filt1_length >= min.size & filt1_length <= max.size]
   return(filt2)
}
