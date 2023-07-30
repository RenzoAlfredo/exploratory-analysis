########################################
#   UNIVERSIDAD NACIONAL DE INGENIERÌA #
#                                      #
#     ANALISIS EXPLORATORIO            #
#     DE LA BASE MODELO SEGMENTACION Y #
#     PRODECCION - CAJA                #
#                                      #
#              GRUPO 6                 #
#       RENZO HUAMANYAURI HUAMAN       #
#                                      #
########################################

#---------------------------------------------------------
# Para limpiar el workspace, por si hubiera algun dataset
# o informacion cargada
rm(list = ls())

#---------------------------------------------------------

#-------------- 1. Cargamos las librerìas --------------#
library(ggplot2)
library(caret)
library(DataExplorer)
library(VIM)
library(missForest)
# library(dummies)
library(lattice)
library(colorspace)
library(data.table)
library(randomForest)
library(foreach)
library(itertools)
library(MASS)
library(pROC)
library(foreign)
library(gmodels)
# library(InformationValue)
library(caTools)
# library(MLmeTrics)
library(dplyr)
# library(tidyverse)
# library(kableExtra)
library(scales)
library(Boruta)
# library(BRugs)
library(R2OpenBUGS)
library(factoextra)
library(mvoutlier)
library(outliers)
library(cluster)
library(fpc)
library(mclust)
library(dbscan)
library(readxl)
library(psych)
library(corrplot)
library(mclust)
library(gclus)
library(rrcov)
library(tourr)
library(aplpack)
library(TeachingDemos)
library(rgl)
library(ape)
# library(DMwR)
library(GGally)
library(Hmisc)
library(PerformanceAnalytics)
library(e1071)
library(class)
library(sqldf)

#-------------- 2. Leemos el directorio --------------#
setwd("/home/renzo/Documentos/Maestria-DS/R FOR DATA SCIENCE/rstudio-practica/exploratory-analysis") # Fija el directorio de trabajo
getwd() # Ver el directorio de trabajo


#-------------- 3. Lectura de datos--------------#
library(foreign)
ds <- read.spss("BASE MODELO SEGMENTACION Y PREDICCIÓN - CAJA - GRUPO 1.sav",
    use.value.labels = TRUE,
    to.data.frame = TRUE
)

#-------------- 4. Browsing de la informaciòn--------------#
str(ds) # estructura
head(ds) # top 6 de filas
summary(ds) # resumen
names(ds) # nombre de los campos

#-------------- 5. Verificaciòn de datos perdidos--------------#
library(DataExplorer)
plot_missing(ds)


