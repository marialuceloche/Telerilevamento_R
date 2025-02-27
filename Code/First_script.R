# First R coding from scratch
# Operazioni e oggetti
2+3
anna <- 2+3 # assign an operation to an object
chiara <- 4+6 
anna + chiara # operation
# Vettori
filippo <- c(0.2, 0.4, 0.6, 0.8, 0.9) # un set di diversi argomenti forma un vettore o array
luca <- c(100, 80, 60, 50, 10)
plot(luca, filippo, pch = 19, col = "blue", cex = 2, xlab = "rubbish", ylab = "biomass")

# Installing packages
# CRAN
install.packages("terra")
library(terra)

# GitHub
install.packages("devtools")
library(devtools)
# Installiamo il paccheetto imageRy del prof:
install_github("ducciorocchini/imageRy")
library(imageRy)




