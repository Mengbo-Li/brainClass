#' Processed Allen Human Brain Atlas (AHBA) data
#'
#' Processed whole brain gene expression data. AHBA samples are mapped into
#' regions of interest (ROIs) defined by Power parcellation.
#'
#' @docType data
#'
#' @format A data frame object.
#' \describe{
#' \item{ahba}{A data frame containing the gene expression information of ROIS
#' defined by the Power parceallation. The data frame is organised with gene
#' (entrez IDs) on the columns and ROI on the rows. }
#' }
#'
#' @usage
#' data("ahba", package = "brainClass")
#'
#' @examples
#' data("ahba", package = "brainClass")
"ahba"

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


#' Processed DiGSeE scores of relevance to schizophrenia of each gene set
#' signature
#'
#' Summarised schizophrenia relevance score of each gene set from the genewise
#' scores downloaded from DiGSeE database. Scores were log-transformed.
#'
#' @docType data
#'
#' @format A list object.
#' \describe{
#' \item{digsee}{A list object of data frames with summarised DiGSeE
#' schizophrenia relevance scores for different gene set collections.
#' Each data frame contains three columns. `prop` means the proportion of
#' genes with an effective DiGSeE score. `sumScore` is the sum of all scores;
#' and `avgScore` stores the mean score of each gene set. }
#' }
#'
#' @usage
#' data("digsee", package = "brainClass")
#'
#' @examples
#' data("digsee", package = "brainClass")
"digsee"
