#' Identify feature groups where all fitted coefficients are non-zero.
#'
#' The `getSelectedGroup` function extracts names of the features groups where
#' all edges have non-zero fitted coefficients.
#'
#' @param fit The `brainclass` fit.
#'
#' @return A character vector. Names of edge groups where all fitted
#' coefficients are non-zero.
#'
#' @note For the data example, see \link[brainClass]{brainclass}.
#'
#' @export
getSelectedGroup <- function(fit) {
   nonZeroEdges <- setdiff(names(which(fit$beta[,as.character(fit$lambda)] !=
                                          0)), "(Intercept)")
   fitted.incidence <- Matrix::rowSums(fit$incidence.mat[, nonZeroEdges])
   names(which(fitted.incidence == sapply(fit$group, length)))
}
