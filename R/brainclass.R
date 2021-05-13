#' Transcriptional data guided fMRI network classification
#'
#' The `brainclass` function performs fMRI network classification where edges
#' in each fMRI network are treated as a long vector and used as features.
#'
#' @param X A matrix with the training samples, in wich each row represents the
#' vectorized (by column order) upper triangular part of a network adjacency
#' matrix.
#' @param y A vector containing the class labels of the training samples (2
#' classes by default).
#' @param edgeGrp A list of vectors, each containing integer indices or
#' character names of variables in the group.
#' @param family See grpregOverlap::grpregOverlap for details.
#' Default is "binomial".
#' @param penalty See grpregOverlap::grpregOverlap for details.
#' Default is "grLasso".
#' @param lambda See grpregOverlap::grpregOverlap for details.
#' Default is 5e-3.
#'
#' @return An object with S3 class "grpregOverlap".
#' See grpregOverlap::`grpregOverlap` for details.
#'
#' @examples
#' ## NOT RUN
#' # Load a toy data set.
#' # data(toyData)
#' # res <- brainclass(X = toyData$X, y = toyData$y, edgeGrp = toyData$grpList)
#'
#' @references
#' Zeng,Y. and Breheny,P. (2016) Overlapping group logistic regression with
#' applications to genetic pathway selection. Cancer Informatics, 15,
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
