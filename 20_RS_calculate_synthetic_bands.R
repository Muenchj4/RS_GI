#------------------------------------------------------------------------------
# Type: control script 
# Name: 20_RS_calculate_synthetic_bands.R
# Author: Chris Reudenbach, creuden@gmail.com
# Description:  - calculate on base of the original images
#               - RGB Indices
#               - structural images
#               - statistical derivations

# Data: corrected RGB image of AOI 
# Output: comprehensive image stack of useful synthetic bands 
# Copyright: Chris Reudenbach, Thomas Nauss 2017,2020, GPL (>= 3)
# git clone https://github.com/GeoMOER-Students-Space/msc-phygeo-class-of-2020-creu.git
#------------------------------------------------------------------------------
rm(list = ls()) 
if(!exists("envrmt")){
  # 0 - load packages
  #-----------------------------
  require(envimaR)
  
  # 1 - source files
  #-----------------
  source(file.path(envimaR::alternativeEnvi(root_folder = "D:/Benutzer/Muench/edu/mpg-envinsys-plygrnd", alt_env_id = "COMPUTERNAME", alt_env_value = "PCRZP", alt_env_root_folder = "F:/BEN/edu/mpg-envinsys-plygrnd"),
                   "/src/000_setup.R"))
}
# 2 - define variables
#-----------------------------
# link to the GI packages - adapt it to your needs
otb  = link2GI::linkOTB(searchLocation = "/usr/bin/")
saga  = link2GI::linkSAGA()
gdal  = link2GI::linkGDAL()
# clean run/tmp dir
unlink(paste0(envrmt$path_run,"*"), force = TRUE)
# 3 - start code 
#-----------------
# calculation of synthetic bands using the make_syn_bands function which is extracted from the uavRst package
source("D:/Benutzer/Muench/edu/mpg-envinsys-plygrnd/src/Fun/fun_make_syn_bands.R")
res <- make_syn_bands(calculateBands    = T,
                      prefixIdx         = "course2020_",
                      prefixRun         = "course2020_" ,
                      suffixTrainImg    = "MOF_area" ,
                      rgbi              = T,
                      indices           =  c("BI","TGI","GLAI"),#,"VVI","VARI","NDTI","RI","SCI","BI","SI","HI","TGI","GLI","NGRDI","GRVI","GLAI","HUE","CI","SAT","SHP"),
                      channels          = "PCA_RGBI", 
                      hara              = T,
                      haraType          = c("simple", "advanced"),
                      stat              = T,
                      edge              = T,
                      morpho            = T,
                      pardem            = F,
                      kernel            = 5,
                      currentDataFolder = envrmt$path_aerial,
                      currentIdxFolder  = envrmt$path_aerial,
                      sagaLinks = saga,
                      otbLinks = otb,
                      gdalLinks = gdal,
                      path_run = envrmt$path_tmp)
source("D:/Benutzer/Muench/edu/mpg-envinsys-plygrnd/src/Fun/fun_get_crayon.R")
cat(getCrayon()[[3]](":::: finished ",scriptName::current_filename(),"\n"))