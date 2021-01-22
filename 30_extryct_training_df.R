#------------------------------------------------------------------------------
# Type: control script 
# Name: extract_training_data.R
# Author: Chris Reudenbach, creuden@gmail.com
# Description:  extract raw training data according to training areas

# Data: raster data stack of prediction variables , training areas
# Output: raw dataframe containing training data
# Copyright: Hanna Meyer, Thomas Nauss, Chris Reudenbach 2019-2020, GPL (>= 3)
# URL: https://github.com/HannaMeyer/OpenGeoHub_2019/blob/master/practice/ML_LULC.Rmd
#------------------------------------------------------------------------------
rm(list = ls()) 
# 0 - load packages
#-----------------------------
library(caret)
library(exactextractr)
library(dplyr)

if(!exists("envrmt")){
  # 0 - load packages
  #-----------------------------
  require(envimaR)
  
  # 1 - source files
  #-----------------
  source(file.path(envimaR::alternativeEnvi(root_folder = "D:/Benutzer/Muench/edu/mpg-envinsys-plygrnd", alt_env_id = "COMPUTERNAME", alt_env_value = "PCRZP", alt_env_root_folder = "F:/BEN/edu/mpg-envinsys-plygrnd"),
                   "/src/000_setup.R"))
}
# clean run dir
unlink(paste0(envrmt$path_tmp,"*"), force = TRUE)
# 2 - define variables
#-----------------------------
# get the prediction stack  (load  and apply bandnames)
# NOTE you have to adapt the filname according to the prediction stack file
fn="MOF_rgb"
predStack  <- raster::stack(paste0(envrmt$path_aerial,fn,".gri"))
