#' Get indices of the observations assigned to each fold for repeated k-fold
#' cross-validation
#'
#' The `getCVfolds` function splits n observations into k groups in s different
#' ways to be used for repeated k-fold cross-validations over s repeats. This
#' function is designed for situations where the the response variable is
#' binary.
#'
#' @param y A binary vector of length n.
#' @param k An integer giving the number of groups into which n observations
#' need to be split. The default is 10.
#' @param repeats Number of repeats. Default is 50.
#' @param type A character string to specify the type of folds to be obtained.
#' See cvTools::cvFolds for more. The default is "random".
#'
#' @return A list object of data frames, each consisting of two columns, where
#' column k gives the fold for each premuted observation; column Ind gives the
#' index of the observation. Each data frame element of the returned list can be
#' used in a different repeat of k-fold cross-validation.
#'
#' @examples
#' ## NOT RUN
#' # getCVfolds(toyData$y, k = 3, repeats = 5, type = "random")
#'
#' @export
getCVfolds <- function(y, k = 10, repeats = 50, type = "random"){
    class0_ind <- which(y == 0)
    class1_ind <- which(y == 1)
    res <- lapply(seq_len(repeats), function(i){
        class0_fold <- cvTools::cvFolds(n = length(class0_ind), K = k, type = type)
        class0_fold <- data.frame(k = class0_fold$which, Ind = class0_fold$subsets)
        class0_fold$Ind <- class0_ind[class0_fold$Ind]
        class1_fold <- cvTools::cvFolds(n = length(class1_ind), K = k)
        class1_fold <- data.frame(k = class1_fold$which, Ind = class1_fold$subsets)
        class1_fold$Ind <- class1_ind[class1_fold$Ind]
        return(rbind(class0_fold, class1_fold))
    })
    return(res)
}
