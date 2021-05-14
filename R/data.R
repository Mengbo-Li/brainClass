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
#' defined by the Power parcellation. The data frame is organised with gene
#' (entrez IDs) on the columns and ROI on the rows. }
#' }
#'
#' @usage
#' data("ahba", package = "brainClass")
#'
#' @references
#' Hawrylycz, M. J., Lein, E. S., Guillozet-Bongaarts, A. L., Shen, E. H., Ng,
#' L., Miller, J. A., ... & Jones, A. R. (2012). An anatomically comprehensive
#' atlas of the adult human brain transcriptome. \emph{Nature}, 489(7416), 391-399.
#'
#' @references
#' Power, J. D., Cohen, A. L., Nelson, S. M., Wig, G. S., Barnes, K. A., Church,
#' J. A., ... & Petersen, S. E. (2011). Functional network organization of the
#' human brain. \emph{Neuron}, 72(4), 665-678.
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
#' @references
#' Liberzon, A., Subramanian, A., Pinchback, R., Thorvaldsdóttir, H., Tamayo,
#' P., & Mesirov, J. P. (2011). Molecular signatures database (MSigDB) 3.0.
#' \emph{Bioinformatics}, 27(12), 1739-1740.
#'
#' @examples
#' data("gscv7.0", package = "brainClass")
"gscv7.0"


#' Processed DiGSeE scores of relevance to schizophrenia of each gene set
#' signature
#'
#' Summarised schizophrenia relevance score of each gene set from the genewise
#' scores downloaded from DiGSeE database. Scores were log-transformed. Details
#' on the processing of raw scores are available in the Supplementary Methods in
#' the reference.
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
#' @references
#' Kim, J., So, S., Lee, H. J., Park, J. C., Kim, J. J., & Lee, H. (2013).
#' DigSee: disease gene search engine with evidence sentences (version cancer).
#' \emph{Nucleic acids research}, 41(W1), W510-W517.
#'
#' Li, M., Kessler, D., Arroyo, J., Freytag, S., Bahlo, M., Levina, E., & Yang,
#' J. Y. H. (2020). Guiding and interpreting brain network classification with
#' transcriptional data. \emph{bioRxiv}.
#'
#'
#' @examples
#' data("digsee", package = "brainClass")
"digsee"
