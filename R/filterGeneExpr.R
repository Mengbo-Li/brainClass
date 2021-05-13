#' Filter gene expression data by average expression in each region of interest
#'  (ROI)
#'
#' The `filterGeneExpr` function
#'
#' @param geneExpr The ROI-by-gene data frame.
#'
#' @param q The quantile cutoff.
#'
#' @return Downsized gene expression data frame.
#'
#' @examples
#' filterGeneExpr(ahba, q = 0.75)
#'
#' @export
filterGeneExpr <- function(geneExpr, q = 0.75) {
   absavgExp <- abs(apply(geneExpr, 2, mean))
   geneExpr_filt <- geneExpr[, absavgExp >= quantile(absavgExp, probs = q)]
   return(geneExpr_filt)
}
