## ----setup, include = FALSE-----------------------------------------------------------------------
options(width = 100, digits = 3)
knitr::opts_chunk$set(collapse = TRUE, 
                      comment = "#>", 
                      echo = TRUE, 
                      cache = FALSE, 
                      prompt = FALSE,
                      tidy = TRUE,
                      comment = NA, 
                      message = FALSE, 
                      warning = FALSE, 
                      tidy = TRUE, 
                      tidy.opts = list(width.cutoff = 60),
                      fig.width = 7, 
                      fig.height = 5, 
                      dev = "png")

## ---- eval = FALSE--------------------------------------------------------------------------------
#  # install.packages("devtools")
#  devtools::install_github("Mengbo-Li/brainClass")

## -------------------------------------------------------------------------------------------------
library(tidyverse)
library(brainClass)
library(graphclass)

## -------------------------------------------------------------------------------------------------
data("ahba")
data("gscv7.0")
data("digsee")
data("COBRE.data")

## -------------------------------------------------------------------------------------------------
class(ahba)
dim(ahba)
ahba[1:5, 1:10]

## -------------------------------------------------------------------------------------------------
X_cobre <- COBRE.data$X.cobre
y_cobre <- COBRE.data$Y.cobre
colnames(X_cobre) <- getEdgeLabel(node = c(1:74, 76:264))
rownames(X_cobre) <- as.character(1:124)
y_cobre[y_cobre == -1] <- 0
table(y_cobre)

## -------------------------------------------------------------------------------------------------
length(gscv7.0)
names(gscv7.0)
length(gscv7.0$kegg)
gscv7.0$kegg[1:3]

## -------------------------------------------------------------------------------------------------
length(digsee)
names(digsee)
head(digsee$kegg)

## -------------------------------------------------------------------------------------------------
ahba <- filterGeneExpr(ahba)
ahba <- ahba[rownames(ahba)[order(as.numeric(rownames(ahba)))], ]
ahba <- ahba[-which(rownames(ahba) == "75"), ]
dim(ahba)

## -------------------------------------------------------------------------------------------------
kegg <- filterGeneSets(geneSetList = gscv7.0$kegg, candidateGenes = colnames(ahba), 
                       min.size = 5, max.size = Inf)
summary(sapply(kegg, length))

## ---- eval = FALSE--------------------------------------------------------------------------------
#  # Not run
#  kegg <- filterGeneSets(geneSetList = gscv7.0$kegg, candidateGenes = colnames(ahba),
#                         min.size = 2, max.size = Inf)

## -------------------------------------------------------------------------------------------------
keggEdgeGrp <- getGeneSetEdgeGroup(geneExpr = ahba, geneSetList = kegg, cutoff = 0.99)

## -------------------------------------------------------------------------------------------------
edgesToClassify <- unlist(keggEdgeGrp)
X_cobre_filterd <- X_cobre[, edgesToClassify[!duplicated(edgesToClassify)]]

set.seed(10)
cvfolds <- getCVfolds(y_cobre, k = 10, repeats = 1)
trainid <- cvfolds[[1]] %>% filter(k != 1)
fit <- brainclass(X = X_cobre_filterd[trainid$Ind, ], y = y_cobre[trainid$Ind], edgeGrp = keggEdgeGrp)

## -------------------------------------------------------------------------------------------------
testid <- cvfolds[[1]] %>% filter(k == 1)
test <- predict(fit, X = X_cobre_filterd[testid$Ind, ], type = "class")
table(test, y_cobre[testid$Ind])

## -------------------------------------------------------------------------------------------------
# install.package("glmnet")
library(glmnet)

cvfit <- cv.glmnet(X_cobre, y_cobre, family = "binomial", nfolds = 10)
selectedEdges <- coef(cvfit, s = "lambda.min")
selectedEdges <- names(selectedEdges[selectedEdges@i + 1, ])[-1]
length(selectedEdges)

## -------------------------------------------------------------------------------------------------
metrics <- posthoc.edge(selected.edgeLabels = selectedEdges, 
                        all.edgeLabels = colnames(X_cobre), 
                        geneSetList = kegg, 
                        geneExpr = ahba, 
                        iter = 100)
DT::datatable(signif(metrics, 2))

## -------------------------------------------------------------------------------------------------
metrics <- merge(metrics, digsee[["kegg"]], by = 0) %>% 
   mutate(truth = ((avgScore >= quantile(avgScore, 0.95)) + (sumScore >= quantile(sumScore, 0.95)) > 0) + 0)
table(metrics$truth)
metrics$Row.names[metrics$truth == 1]

## -------------------------------------------------------------------------------------------------
rocs <- getROC(truth = metrics$truth, test.metric = metrics$Jaccard, step.size = 0.01)

ggplot(rocs, aes(x = fpr, y = tpr)) + 
  geom_line() + 
  geom_abline(slope = 1, intercept = 0, color = "darkred", linetype = 2) + 
  labs(x = "FPR", y = "TPR") + 
  theme_minimal()

## -------------------------------------------------------------------------------------------------
DescTools::AUC(rocs$fpr, rocs$tpr)

## -------------------------------------------------------------------------------------------------
rocs <- getROC(truth = metrics$truth, test.metric = 1-metrics$Jaccard.PValue, step.size = 0.01)

ggplot(rocs, aes(x = fpr, y = tpr)) + 
  geom_line() + 
  geom_abline(slope = 1, intercept = 0, color = "darkred", linetype = 2) + 
  labs(x = "FPR", y = "TPR") + 
  theme_minimal()

DescTools::AUC(rocs$fpr, rocs$tpr)

## -------------------------------------------------------------------------------------------------
gscs <- c("kegg", "reactome", "position", "tft")
rocs <- lapply(gscs, function(ind) {
   # filter the gene sets by size
   gsc_i <- filterGeneSets(geneSetList = gscv7.0[[ind]], 
                           candidateGenes = colnames(ahba), 
                           min.size = 5, 
                           max.size = Inf)
   # obtain Jaccard indices
   res <- posthoc.edge(selected.edgeLabels = selectedEdges, 
                       all.edgeLabels = colnames(X_cobre), 
                       geneSetList = gsc_i, 
                       geneExpr = ahba, 
                       get.jaccard = TRUE, 
                       get.betweenness = FALSE, 
                       iter = 100)
   # get roc
   res <- merge(res, digsee[[ind]], by = 0) %>% 
      mutate(truth = ((avgScore >= quantile(avgScore, 0.95)) + (sumScore >= quantile(sumScore, 0.95)) > 0) + 0)
   roc <- getROC(truth = res$truth, test.metric = res$Jaccard, step.size = 0.01)
   
   roc$gsc <- ind
   return(roc)
}) %>% do.call(rbind, .)

## -------------------------------------------------------------------------------------------------
ggplot(rocs, aes(x = fpr, y = tpr, color = gsc)) + 
   geom_line() + 
   geom_abline(slope = 1, intercept = 0, color = "darkred", linetype = 2) + 
   labs(x = "FPR", y = "TPR", color = "GSC") + 
   ggtitle("ROC curves by Jaccard Index") + 
   theme_minimal()

## -------------------------------------------------------------------------------------------------
group_by(rocs, gsc) %>% 
   summarise(auc = DescTools::AUC(fpr, tpr))

## -------------------------------------------------------------------------------------------------
sessionInfo()

