#' Obtain receiver operating characteristic (ROC) curve
#'
#' The `getROC` function calculates
#'
#' @param metrics The data frame storing
#'
#' @return
#'
#' @examples
#' ## NOT RUN
#' # jaccard(1:10, 1:20)
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
