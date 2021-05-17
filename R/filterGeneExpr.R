#' Filter gene expression data by average expression
#'
#' The `filterGeneExpr` function applies downsizing on the gene expression data
#' by average expression.
#'
#' @param geneExpr The ROI-by-gene data frame or matrix.
#'
#' @param q The quantile cutoff.
#'
#' @return Downsized gene expression data.
#'
#' @examples
#' ## NOT RUN
#' # filterGeneExpr(ahba, q = 0.75)
#'
#' @export
filterGeneExpr <- function(geneExpr, q = 0.75) {
   absavgExp <- abs(colMeans(geneExpr, na.rm = TRUE))
   geneExpr_filt <- geneExpr[, absavgExp >= quantile(absavgExp, probs = q)]
   return(geneExpr_filt)
}
