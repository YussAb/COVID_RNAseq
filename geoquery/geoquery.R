###########################
#https://medicine.uiowa.edu/humangenetics/sites/medicine.uiowa.edu.humangenetics/files/wysiwyg_uploads/Workshop%20Follow-up_Day%202.pdf
library(GEOquery)
library(dplyr)
library(Biobase)
library(tidyverse)
################################GEO Series Accessions
dir.create("geoData")
gse <- GEOquery::getGEO(GEO = "GSE163426", destdir = "geoData", GSEMatrix = FALSE)
class(gse)

#GSE Metadata
Meta(gse)[c("title", "type", "platform_id", "summary","supplementary_file")]

#GSM samples
GEOquery::GSMList(gse) %>% names()

#GPL Platform
GEOquery::GPLList(gse) %>% names()

#GSM ELEMENT
#Inspect the first sample
GSMList(gse)[[1]] %>% class()
GSMList(gse)[[1]]

#GPL ELEMENT
GPLList(gse)[[1]] %>% class()
GPLList(gse)[[1]]

#####################################GSE Expression Matrix
gse_exprs <- GEOquery::getGEO(GEO = "GSE163426", destdir = "geoData", GSEMatrix = TRUE)
class(gse_exprs)
length(gse_exprs)
names(gse_exprs)
object_size(gse_exprs)
lapply(gse_exprs, class)

#PhenoData
gse_GPL24676 <- gse_exprs$GSE163426_series_matrix.txt.gz
PhenoData <- Biobase::pData(gse_GPL24676)%>% as_tibble()

#SupplementaryData
supp_info <- GEOquery::getGEOSuppFiles(GEO = "GSE163426")
rownames(supp_info)
#gse_raw_pos_supp <-readr::read_delim("GSE163426_count_matrix_raw_pos_ARDS.csv",delim = ",")
#gse_meta_supp <- readr::read_delim("GSE163426_meta_data_pos_ARDS.csv")
#gse_exp_supp <- readr::read_delim("GSE163426_covidvsards.pcgenecounts.csv",delim = ",")

#############################################################################################

######PHENO DATA
sample_exp_supp <- colnames(gse_exp_supp) ; sample_exp_supp <- sample_exp_supp[-1]
sample_exp_supp <- as_data_frame(sample_exp_supp)
colnames(sample_exp_supp) <- c("title")
mergePheno <- merge(sample_exp_supp,PhenoData)

######EXP DATA
BiocManager::install("clusterProfiler")
BiocManager::install("org.Hs.eg.db")
library(clusterProfiler)
library("org.Hs.eg.db")

a <- bitr(x , fromType = "ENSEMBL",
          toType = c("ENTREZID", "SYMBOL"),
          OrgDb = org.Hs.eg.db)

#Exp
#Biobase::experimentData(gse_GPL24676)
#Biobase::sampleNames(gse_GPL24676)
#Biobase::featureNames(gse_GPL24676)
#Biobase::exprs(gse_GPL24676)
#ALL_tbl <- dplyr::bind_cols(Feature = Biobase::featureNames(gse_GPL24676),
 #                           as_tibble(Biobase::exprs(gse_GPL24676)))
