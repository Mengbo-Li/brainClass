#' Gene set collections downloaded from MSigDB v7.0
#'
#' Gene set collections in entrez ID. Downloaded from the MSigDB database
#' version 7.0
#'
#' @docType data
#'
#' @format A list object.
#' \describe{
#' \item{gscv7.0}{A list object of gene set collections of different types.
#' Here we included 8 different collections, including the positional (by
#' gene location on each chromosome). KEGG pathways, REACTOME pathways,
#' transcription factor targets, immunological signatures and three classes of
#' geno ontology terms (biological processes, cellular components and molecular
#' functions). }
#' }
#'
#' @usage
#' data("gscv7.0", package = "brainClass")
#'
#' @examples
#' data("gscv7.0", package = "brainClass")
"gscv7.0"
