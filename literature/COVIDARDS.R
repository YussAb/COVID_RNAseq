#CODE
setwd("~/covid")

#PHENODATA
library(tidyverse)
PhenoData <- read_csv("literature/COVIDARDS-v1.0.0/AartikSarma-COVIDARDS-800a4da/covidards.metadata.csv")

#EXPRESSION
ExpData <- read_csv("literature/COVIDARDS-v1.0.0/AartikSarma-COVIDARDS-800a4da/comet.genes.csv")
