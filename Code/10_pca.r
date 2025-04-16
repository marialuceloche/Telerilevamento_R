# Analisi multivariata in R di dati satellitari
library(terra)
library(imageRy)
library(ggplot2)
library(patchwork)

# importiamo l'immagine che ci interessa
im.list()
sent = im.import("sentinel.png")
sent = c(sent[[1]], sent[[2]], sent[[3]])

# NIR = band 1
# red = band 2
# green = band 3

# fasi della PCA:
# 1. campionamento
sample = spatSample(sent, 100)
plot(sample)

# 2. PCA
pca = prcomp(sample)
summary(pca)

# 3. mappatura
pcmap = predict(sent, pca, index = c(1:3))

# usando la funzione di imageRy im.pca
pcmapim = im.pca(sent)
# calcoliamo la variabilità
varpca = focal(pcmapim[[1]], matrix(1/9, 3, 3), fun = sd)
# vediamo la differenza con il calcolo del NIR
varnir = focal(sent[[1]], matrix(1/9, 3, 3), fun = sd)

d1 = im.ggplot(varpca)
d2 = im.ggplot(varnir)
d1 + d2


# altro metodo:
sentpca = im.pca(sent, n_samples=100000)
tot = 72 + 59 + 6
72 * 100 / tot
sdpc1 = focal(sentpca[[1]], w=c(3,3), fun="sd")
plot(sdpc1)   
