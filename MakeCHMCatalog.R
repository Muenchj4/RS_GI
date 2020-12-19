---
title: "MakeCHMCatalog"
author: "Muench"
date: "17 12 2020"
output: html_document
---
# ===============================================================================
# makeChmCatalog.R
#
# Author: Chris Reudenbach, creuden@gmail.com
#
# Copyright: Chris Reudenbach, Thomas Nauss 2017-2019, GPL (>= 3)
#
# ===============================================================================

#' creates a canopy height model from generic Lidar las data using the lidR package
#'  
#' In addition the script cuts the area to a defined extent using the lidR catalog concept.
#' Furthermore the data is tiled into a handy format even for poor memory 
#' and a canopy height model is calculated
#'
#' Input:  regular las LiDAR data sets 
#' Output: Canopy heightmodel RDS file of the resulting catalog
#
#================================================================================


# 0 - load packages
#-----------------------------
library("future")

# 1 - source files
#-----------------
source(file.path(envimaR::alternativeEnvi(root_folder = "D:/Benutzer/Muench/edu/mpg-envinsys-plygrnd",
                                          alt_env_id = "COMPUTERNAME",
                                          alt_env_value = "PCRZP",
                                          alt_env_root_folder = "F:/BEN/edu"),
                 "src/mpg_course_basic_setup.R"))

devtools::install_github("r-spatial/link2GI")

source("D:/Benutzer/Muench/edu/mpg-envinsys-plygrnd/src/cut_mof.R")

# 2 - define variables
#---------------------

# get viridris color palette
pal<-mapview::mapviewPalette("mapviewTopoColors")

## define current projection (It is not magic you need to check the meta data or ask your instructor) 
## ETRS89 / UTM zone 32N
proj4 = "+proj=utm +zone=32 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0"
# 3 - start code 
#-----------------


# cut the origdata to the AOI
mof <- cut_mof(coord  = c(477600.0,5632500.0,478350.0,5632500.0),
               proj   = proj4<- sp::CRS("+init=epsg:32632"), 
               envrmt = envrmt)
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## R Markdown

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r cars}
summary(cars)
```

## Including Plots

You can also embed plots, for example:

```{r pressure, echo=FALSE}
plot(pressure)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.
