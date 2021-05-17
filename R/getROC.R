#' Obtain the receiver operating characteristic (ROC) curve
#'
#' The `getROC` function calculates the ROC curve given the test and truth
#' values for binary classes. The true class must be binary. The test metric
#' should be numeric.
#'
#' @param truth The true class (0 or 1) of each observation, a binary vector.
#'
#' @param test.metric The test metric, a numeric vector.
#'
#' @param step.size The step size for the ROC curve.
#'
#' @return Coordinates on the ROC curve, that is, the false positive rate (fpr)
#' and the true positive rate (tpr) values at each step.
#'
#' @examples
#' ## NOT RUN
#' # res <- getROC(truth = rep(0:1, each = 5), test.metric = c(1:10))
#' # ## useful function for calculating the area under the ROC curve:
#' # DescTools::AUC(res$tpr, res$fpr)
#'
#' @export
getROC <- function(truth,
                   test.metric,
                   step.size = 0.05) {
   do.call(rbind, lapply(seq(0, 1, step.size), function(step) {
      binarised <- data.frame(truth = truth,
                              test = (test.metric >= quantile(test.metric,
                                                              probs = step))+0)
      roc <- data.frame(tpr = table(binarised)["1", "1"]/
                           sum(table(binarised)["1", ]),
                        fpr = table(binarised)["0", "1"]/
                           sum(table(binarised)["0", ]))
      roc$step <- step
      return(roc)
   }))
}
