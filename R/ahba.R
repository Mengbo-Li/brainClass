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
#' data(ahba, package = "brainClass")
#'
#' @examples
#' data(ahba, package = "brainClass")
"AHBA_roi_by_gene"
