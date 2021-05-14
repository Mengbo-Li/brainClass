#' Transcriptional-data-guided fMRI network classification
#'
#' The `brainclass` function performs fMRI network classification where edges
#' in each fMRI network are treated as a long vector and used as features.
#'
#' @param X A matrix with the training samples, in which each row represents the
#' vectorized upper triangular part (by column order) of the network adjacency
#' matrix.
#' @param y A vector containing the class labels of the training samples (2
#' classes by default).
#' @param edgeGrp Feature groups, in the list format. Each element should
#' contain the names of edges belong to each gene set edge group.
#' @param family See grpregOverlap::grpregOverlap for details.
#' Default is "binomial".
#' @param penalty See grpregOverlap::grpregOverlap for details.
#' Default is "grLasso".
#' @param lambda See grpregOverlap::grpregOverlap for details.
#' Default is 5e-3.
#'
#' @return An object with S3 class "grpregOverlap". See
#' `grpregOverlap::grpregOverlap` for details.
#'
#' @examples
#' ## NOT RUN
#' # ### Obtain data
#' # data(ahba)
#' # library(graphclass)
#' # data(COBRE.data)
#' # data(gscv7.0)
#' # ### Filter gene sets by size
#' # kegg <- filterGeneSets(geneSetList = gscv7.0$kegg,
#' # candidateGenes = colnames(ahba), min.size = 5, max.size = Inf)
#' # ### Get gene set edge groups
#' # keggEdgeGrp <- getGeneSetEdgeGroup(geneExpr = ahba, geneSetList = kegg,
#' # cutoff = 0.99)
#' # ### Exclude edges not belonging to any feature groups from training
#' # edgesToClassify <- unlist(keggEdgeGrp)
#' # edgesToClassify <- edgesToClassify[!duplicated(edgesToClassify)]
#' # ### Model training
#' # train <- brainclass(X = COBRE.data$X.cobre[, edgesToClassify],
#' # y = COBRE.data$Y.cobre, edgeGrp = keggEdgeGrp)
#'
#' @references
#' Li, M., Kessler, D., Arroyo, J., Freytag, S., Bahlo, M., Levina, E., & Yang,
#' J. Y. H. (2020). Guiding and interpreting brain network classification with
#' transcriptional data. \emph{bioRxiv}.
#'
#' @references
#' Zeng, Y., & Breheny, P. (2016). Overlapping group logistic regression with
#' applications to genetic pathway selection. \emph{Cancer informatics}, 15,
#' CIN-S40043.
#'
#' @export
brainclass <- function(X,
                       y,
                       edgeGrp,
                       family = "binomial",
                       penalty = "grLasso",
                       lambda = 5e-3) {
   GS_grpLasso <- grpregOverlap::grpregOverlap(X,
                                               y,
                                               group = edgeGrp,
                                               lambda = lambda,
                                               penalty = penalty,
                                               family = family)
   return(GS_grpLasso)
}
