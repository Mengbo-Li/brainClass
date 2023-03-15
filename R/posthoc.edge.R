#' Obtain the edgewise post-hoc interpretability metrics
#'
#' The `posthoc.edge` function calculates the edgewise interpretation metrics on
#' a set of edges selected by a generic network classifier such as
#' `graphclass::graphclass`.
#'
#' @param selected.edgeLabels Lables of edges selected by a generic network
#' classification algorithm.
#'
#' @param all.edgeLabels All edges (features) included in the classification to
#' be evaluated.
#'
#' @param geneSetList Reference gene set collection. What type of gene sets do
#' you wish to interpret selected functional edges by?
#'
#' @param geneExpr Gene expression data, which is represented as a ROI-by-gene
#' data frame or matrix. ROI stands for region of interest, which corresponds to
#' each node in the networks of classification.
#'
#' @param get.jaccard Logical. Whether to return the Jaccard index metrics.
#'
#' @param jaccard.cutoff Hard-thresholding cutoff to calculate the Jaccard index
#' metric. See references for details.
#'
#' @param get.betweenness Logical. Whether to return the edge betweenness
#' centrality metrics.
#'
#' @param betweenness.cutoff Hard-thresholding cutoff to calculate the edge
#' betweenness centrality metric. See references for details.
#'
#' @param iter Number of random draws for constructing the null distribution of
#' each metric.
#'
#' @param adjust.p Logical. Whether or not to return adjusted p-values.
#'
#' @param ...
#'
#' @return Evalutaion metrics stored in a data frame.
#'
#' @references
#' Li, M., Kessler, D., Arroyo, J., Freytag, S., Bahlo, M., Levina, E., & Yang,
#' J. Y. H. (2020). Guiding and interpreting brain network classification with
#' transcriptional data. \emph{bioRxiv}.
#'
#' Csardi, G., & Nepusz, T. (2006). The igraph software package for complex
#' network research. \emph{InterJournal, complex systems}, 1695(5), 1-9.
#'
#' @examples
#' ## NOT RUN
#' # ## For example, interpretability of glmnet selected edges by KEGG pathways
#' # data(ahba)
#' # data(gscv7.0)
#' # library(graphclass)
#' # data(COBRE.data)
#' # X_cobre <- COBRE.data$X.cobre; y_cobre <- COBRE.data$Y.cobre
#' # colnames(X_cobre) <- getEdgeLabel(node = c(1:74, 76:264))
#' #
#' # library(glmnet)
#' # cvfit <- cv.glmnet(X_cobre, y_cobre, family = "binomial", nfolds = 10)
#' # selectedEdges <- coef(cvfit, s = "lambda.min")
#' # selectedEdges <- names(selectedEdges[selectedEdges@i + 1, ])[-1]
#' # metrics <- posthoc.edge(selected.edgeLabels = selectedEdges,
#' # all.edgeLabels = colnames(X_cobre), geneSetList = gscv7.0$kegg,
#' # geneExpr = ahba,iter = 100)
#'
#' @export
posthoc.edge <- function(selected.edgeLabels,
                         all.edgeLabels,
                         geneSetList,
                         geneExpr,
                         get.jaccard = TRUE,
                         jaccard.cutoff = 0.99,
                         get.betweenness = TRUE,
                         betweenness.cutoff = 0.75,
                         iter = 200,
                         adjust.p = TRUE, ...) {
   if (get.jaccard) {
      require(DescTools)
      # jaccard evaluation
      gs_j <- getGeneSetEdgeGroup(geneExpr, geneSetList, cutoff = jaccard.cutoff)
      res_j <- do.call(rbind, lapply(gs_j, function(gsi) {
         # generate null distribution
         null_j <- unlist(lapply(1:iter, function(i) {
            rand_set_of_edges <- sample(all.edgeLabels,
                                        size = length(selected.edgeLabels))
            jaccard(gsi, rand_set_of_edges)
         }))
         res <- data.frame(Jaccard = jaccard(gsi, selected.edgeLabels))
         res$Jaccard.PValue = t.test(x = FisherZ(null_j),
                                     mu = FisherZ(res$Jaccard),
                                     alternative = "less")$p.value
         if (adjust.p)
            res$Jaccard.PValue <- p.adjust(res$Jaccard.PValue, ...)
         return(res)
      }))
   }
   if (get.betweenness) {
      # edge betweenness
      require(igraph)
      gs_btw <- getGeneSetEdgeGroup(geneExpr, geneSetList,
                                    cutoff = betweenness.cutoff)
      res_btw <- do.call(rbind, lapply(gs_btw, function(gsi) {
         edges_matrix <- do.call(rbind, strsplit(gsi, "-"))
         gs_graph <- graph_from_edgelist(edges_matrix, directed = FALSE)
         edge_metric <- data.frame(edgeName =
                                      as.character(attributes(E(gs_graph))$vnames),
                                   BT = edge_betweenness(gs_graph,
                                                         directed = FALSE,
                                                         weights = NULL))
         edge_metric$edgeName <- gsub("\\|", "-", edge_metric$edgeName)
         res <- data.frame(avg.edge.btw =
                              mean(edge_metric$BT[edge_metric$edgeName %in%
                                                     selected.edgeLabels]))
         # generate null distribution
         null_btw <- unlist(lapply(1:iter, function(i) {
            rand_set_of_edges <- sample(all.edgeLabels,
                                        size = length(selected.edgeLabels))
            mean(edge_metric$BT[edge_metric$edgeName %in% rand_set_of_edges])
         }))
         res$edge.btw.PValue <- t.test(x = null_btw, mu = res$avg.edge.btw,
                                       alternative = "less")$p.value
         if (adjust.p)
            res$edge.btw.PValue <- p.adjust(res$edge.btw.PValue, ...)
         return(res)
      }))
   }
   if (get.jaccard & get.betweenness) return(cbind(res_j, res_btw))
   else if (get.jaccard) return(res_j)
   else return(res_btw)
}
