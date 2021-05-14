#' Calculate Jaccard Index of two sets
#'
#' The `jaccard` function calculates the Jaccard Index of two sets.
#'
#' @param x,y Vectors of the same node containing a sequence of non-duplicated
#' items.
#'
#' @return The Jaccard Index as a numeric.
#'
#' @examples
#' ## NOT RUN
#' # jaccard(1:10, 1:20)
#'
#' @export
jaccard <- function(x, y) {
  length(intersect(x, y)) / (length(setdiff(x, y)) + length(setdiff(y, x)) +
                               length(intersect(x, y)))
}
