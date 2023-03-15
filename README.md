# *brainClass*: Transcriptional-data-guided brain network classification 

Transcriptional-data-guided brain network classification that links the brain connectome to the brain transcriptome. Processed example data included. See https://www.biorxiv.org/content/10.1101/2020.05.15.099028v1 for details. 

## Installation 

To install the package, use the following script in R:

```
# install.packages("devtools")
devtools::install_github("Mengbo-Li/brainClass")
```

## Data

Processed COBRE and UMich fMRI network data are obtained from the [**graphclass**](https://github.com/jesusdaniel/graphclass) package. See [**graphclass.pdf**](https://github.com/jesusdaniel/graphclass/blob/master/graphclass.pdf) for details and references.

The whole brain gene expression data are publicly available from the Allen Human Brain Atlas ([**AHBA**](http://human.brain-map.org/static/download?rw=t)). Processed AHBA samples are summarised into the region-of-interest (ROI) level, where ROIs are defined by the Power Parcellation. Corrected MNI coordinates of the AHBA wells are obtained from [**chrisgorgo/alleninf**](https://github.com/chrisgorgo/alleninf). 

Data references:

Aine, C. J., Bockholt, H. J., Bustillo, J. R., Cañive, J. M., Caprihan, A., Gasparovic, C., ... & Calhoun, V. D. (2017). Multimodal neuroimaging in schizophrenia: description and dissemination. *Neuroinformatics*, 15(4), 343-364.

Hawrylycz, M. J., Lein, E. S., Guillozet-Bongaarts, A. L., Shen, E. H., Ng, L., Miller, J. A., ... & Jones, A. R. (2012). An anatomically comprehensive atlas of the adult human brain transcriptome. *Nature*, 489(7416), 391-399.

Kim, J., So, S., Lee, H. J., Park, J. C., Kim, J. J., & Lee, H. (2013). DigSee: disease gene search engine with evidence sentences (version cancer). *Nucleic acids research*, 41(W1), W510-W517.

Liberzon, A., Subramanian, A., Pinchback, R., Thorvaldsdóttir, H., Tamayo, P., & Mesirov, J. P. (2011). Molecular signatures database (MSigDB) 3.0. *Bioinformatics*, 27(12), 1739-1740.

Power, J. D., Cohen, A. L., Nelson, S. M., Wig, G. S., Barnes, K. A., Church, J. A., ... & Petersen, S. E. (2011). Functional network organization of the human brain. *Neuron*, 72(4), 665-678.

Relión, J. D. A., Kessler, D., Levina, E., & Taylor, S. F. (2019). Network classification with applications to brain connectomics. *The annals of applied statistics*, 13(3), 1648. 


## Penalised group lasso algorithms

The *brainClass* package uses the *grpregOverlap::grpregOverlap* algorithm for penalised logistic regression with (user-defined) overlapping feature (covariate) groups. The GitHub page of the *grpregOverlap* package is [**here**](https://github.com/YaohuiZeng/grpregOverlap). 

## Analysis pipeline

See [**vignettes**](https://mengbo-li.github.io/brainClass/) for the standard workflow with *brainClass*. 

## Contact

Open an [**issue**](https://github.com/Mengbo-Li/brainClass/issues) or email me at mengboli103@gmail.com. 



