########################################
#   UNIVERSIDAD NACIONAL DE INGENIERÌA #
#                                      #
#     ANALISIS EXPLORATORIO            #
#     DE LA BASE MODELO SEGMENTACION Y #
#     PREDICCIÒN - CAJA                #
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

#-------------- 0. Cargando los paquetes --------------#

install.packages(c(
    "caret",
    "DataExplorer",
    "VIM",
    "missForest",
    "ggplot2",
    "dummies",
    "lattice",
    "colorspace",
    "data.table",
    "randomForest",
    "foreach",
    "itertools",
    "MASS",
    "pROC",
    "foreign",
    "gmodels",
    "InformationValue",
    "caTools",
    "MLmeTrics",
    "dplyr",
    "iterators",
    "MLmeTrics",
    "tidyverse",
    "kableExtra",
    "scales",
    "Boruta",
    "BRugs",
    "R2OpenBUGS",
    "factoextra",
    "mvoutlier",
    "outliers",
    "cluster",
    "fpc",
    "mclust",
    "dbscan",
    "readxl",
    "psych",
    "corrplot",
    "mclust",
    "gclus",
    "rrcov",
    "tourr",
    "aplpack",
    "TeachingDemos",
    "rgl",
    "ape",
    "DMwR",
    "GGally",
    "Hmisc",
    "PerformanceAnalytics",
    "e1071",
    "class",
    "sqldf",
    "unbalanced",
    "h2o",
    "ROCR",
    "tm",
    "SnowballC",
    "wordcloud",
    "C50",
    "e1071",
    "ggpubr",
    "gridExtra",
    "gdata",
    "ggbiplot",
    "GPArotation",
    "nFactors",
    "gplots",
    "RColorBrewer",
    "semPlot"
), dependencies = T)


install.packages(c("tidyverse"), dependencies = T)


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
head(ds, 10)
summary(ds) # resumen
names(ds) # nombre de los campos
dim(ds) # mostrar la dimensiòn de los datos
dplyr::glimpse(ds)

# Var continuas: Edad, CantCred, Desem, SalVigSol, Monto_Tasaciòn, DiasEfec, MaxDeuda, MaxDiasAtra, MaxGramOro, AntiDias
# Var categòricas: Sexo, EstaCiv, TipoViv, FlagAtra, FlagAdj
# ---> consultar si los flag son una categòrica


#-------------- 5. Verificaciòn de datos perdidos--------------#
library(DataExplorer)
plot_missing(ds)


#############################################
#### DISTRIBUCION DE VARIABLES CONTINUAS ####
#############################################

par(mfrow = c(2, 5))
hist(ds$Edad, main = "Edad del cliente", col = "orange")
hist(ds$CantCred, main = "Cantidad de Crèdito", col = "orange")
hist(ds$Desem, main = "Desembolso", col = "orange") # posibles datos atìpicos
hist(ds$SalVigSol, main = "Saldo Vigente", col = "orange") # posibles datos atìpicos
hist(ds$Monto_Tasación, main = "Monto Tasaciòn", col = "orange") # posibles datos atìpicos
hist(ds$DiasEfec, main = "Dias Efect", col = "orange")
hist(ds$MaxDeuda, main = "Max Deuda", col = "orange")
hist(ds$MaxDiasAtra, main = "Max Dìas de Atraso", col = "orange")
hist(ds$MaxGramOro, main = "Max Gramos de Oro", col = "orange") # posibles datos atìpicos
hist(ds$AntiDias, main = "Anti Dìas", col = "orange")
par(mfrow = c(1, 1))

boxplot(ds$Desem, main = "Desembolso")
boxplot(ds$SalVigSol, main = "Saldo Vigente")
boxplot(ds$Monto_Tasación, main = "Monto Tasaciòn")
boxplot(ds$MaxGramOro, main = "Max Gramos de Oro")
boxplot(ds$Edad, main = "Edad del cliente")


par(mfrow = c(1, 2))
hist(ds$FlagAtra, main = "FlagAtra", col = "orange")
hist(ds$FlagAdj, main = "FlagAdj", col = "orange")

###############################################
#### DISTRIBUCION DE VARIABLES CATEGORICAS ####
###############################################

par(mfrow = c(1, 3))
plot(ds$Sexo, main = "Sexo", col = "seashell")
plot(ds$EstaCiv, main = "Estado Civil", col = "seashell")
plot(ds$TipoViv, main = "Tipo Vivienda", col = "seashell")
par(mfrow = c(1, 1))
