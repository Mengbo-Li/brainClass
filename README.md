# *brainClass*: Transcriptional-data-guided brain network classification 

Transcriptional-data-guided brain network classification that links the brain connectome to the transcriptome. Processed example data included. See https://www.biorxiv.org/content/10.1101/2020.05.15.099028v1 for details. 

## Installation 

To install the package, use the following script in R:

```
# install.packages("devtools")
devtools::install_github("Mengbo-Li/brainClass")
```

## Data

Processed COBRE and UMich fMRI network data are obtained from the *graphclass* package. See [**graphclass.pdf**](https://github.com/jesusdaniel/graphclass/blob/master/graphclass.pdf) for details and references.

The whole brain gene expression data are publicly available from the Allen Human Brain Atlas ([**AHBA**](http://human.brain-map.org/static/download?rw=t)). Processed AHBA samples are summarised into the region-of-interest (ROI) level, where ROIs are defined by the Power Parcellation. Corrected MNI coordinates of the AHBA wells are obtained from [**chrisgorgo/alleninf**](https://github.com/chrisgorgo/alleninf). 

Data references:

Aine, C. J., et al. Multimodal neuroimaging in schizophrenia: description and dissemination. *Neuroinformatics* 15.4 (2017): 343-364.

Arroyo Relión, J.D., Kessler, D., Levina, E., Taylor, S.F., Network classification with applications to brain connectomics. *Ann. Appl. Stat.* 13 (2019), no. 3, 1648--1677

Hawrylycz, Michael J et al. (2012). An anatomically comprehensive atlas of the adult human brain transcriptome. *Nature* 489.7416, pp. 391–399.

Power, Jonathan D et al. (2011). Functional network organization of the human brain. *Neuron* 72.4, pp. 665–678.

## Penalised group lasso algorithms

The *brainClass* package used the **grpregOverlap::grpregOverlap** algorithm for penalised logistic regression with (user-defined) overlapping feature (covariate) groups. The GitHub page of the *grpregOverlap* package is [**here**](https://github.com/YaohuiZeng/grpregOverlap). 


## Contact

Open an [**issue**](https://github.com/Mengbo-Li/brainClass/issues) or email me at mengboli103@gmail.com. 



