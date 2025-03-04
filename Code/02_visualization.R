# R code for visualizing satellite images

# Se non lo si è ancora fatto:
# install.packages("devtools")
# library (devtools)
# install_github("ducciorocchini/imageRy")

library (terra)
library (imageRy)

# Iniziamo con le funzioni
im.list() # restituisce la lista di tutti i file che abbiamo a disposizione

# ATTENZIONE: per l'intero corso andiamo ad usare = invece di <-
b2 = im.import("sentinel.dolomites.b2.tif") # andiamo ad associare alla banda 2 l'immagine che ci interessa
cl = colorRampPalette(c("black", "dark grey", "light grey"))(100) # andiamo a definire le gamme di colori che ci interessano, con una variazione tra un colore e l'altro di 100 tonalità (gamme che separano un colore dall'altro)
plot(b2, col = cl) # rapresento l'immagine con la nuova scala di colori
# osserviamo che tutti gli oggetti che riflettono il blu avranno delle tonalità chiare, tendente al grigio chiaro

# Esercizio: creare la propria palette
blue = colorRampPalette(c("navy", "royalblue1", "paleturquoise1"))(100)
plot(b2, col =  blue)
