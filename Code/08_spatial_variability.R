# richiamiamo i pacchetti
library(imageRy)
library(terra)
library(viridis)
library(ggplot2)
library(patchwork)

# Deviazione standard = quanto un sistema varia intorno alla media 
# usiammo come esempio una serie di numeri
23 22 23 49

# dobbiamo prima calcolare la sommatoria degli scarti quadratici 
# calcoliamo la media
m = (23 + 22 + 23 + 49)/4
# m = 29.25

# calcoliamo gli scarti quadratici
num = (23-29.25)^2 + (22-29.25)^2 + (23-29.25)^2 + (49-29.25)^2
# num = 520.75
den = 4 - 1

# calcoliamo la varianza 
variance = num/den
# variance = 173.58

# la deviazione standard è la radice della varianza
stdev = sqrt(variance)
# stdev = 13.17

# oppure possiamo usare la funzione sd()
sd(c(23, 22, 23, 49))
# 13.17

# se abbiamo una immagine a vogliamo fare un calcolo della dev. standard, possiamo osservare quale zona è molto diversa dal resto
# solitamente indica delle specie molto diverde dal resto dell'immagine (es. stagno in un campo di grano, minerale diverso rispetto alla matrice)

# dall'immagine (da un solo layer), facciamo passare una finestra quadrata (moving window) di tot pixel che ci calcola, al suo centro, la dev. media di tot pixel
# otteniamo una griglia di valori di deviazione

# importiamo l'immagine del ghiacciaio
im.list()
sent = im.import("sentinel.png") #l'immagine contine quattro bande (NIR, red, green, banda di controllo)
sent = flip(sent)

# band 1 = NIR
# band 2 = red
# band 3 = green

#ESERCIZIO: plottiamo l'immagine in RGB usando il NIR nella componente del rosso:
im.plotRGB(sent, r = 1, g = 2, b = 3)
# la vegetazione ha una altissima riflettanza nel NIR mentre l'acqua risulta nera perchè lo assorbe completamente

# ESERCIZIO: fare un multiframe con il NIR in tutte le componenti RGB a rotazione:
im.multiframe(1, 3)
im.plotRGB(sent, r = 1, g = 2, b = 3)
im.plotRGB(sent, r = 2, g = 1, b = 3) # NIR nel verde --> vegetazione verde acceso
im.plotRGB(sent, r = 2, g = 3, b = 1) # NIR sul blu --> suolo nudo giallo
dev.off()


# Calcolo della eterogeneità spaziale
# associamo la banda del NIR ad un elemento corrispondente
NIR = sent[[1]] # usiamo solo il NIR perchè ci serve solo un livello
plot(NIR)

# ESERCIZIO: plottiamo la banda del NIR con la palette inferno del pacchetto viridis
plot(NIR, col = inferno(100))

# creiamo una moving window:
# usiamo la funzione focal che ci da i valori di un intorno
sd3 = focal(NIR, w = c(3,3), fun = sd)
# w indica la indow che può essere quadrata o rettangolare, specificando due numeri (uno di riga e uno di colonna)
# fun determina la funzione che essa deve calcolare, nel nostro caso la deviazione standard
plot(sd3)
# osserviamo che tutte le zone con più alta variabilità identificano un passaggio netto tra due materiali molto diverso

# plottiamo una accanto all'altra le due immagini
im.multiframe(1, 2)
im.plotRGB(sent, r = 1, g = 2, b = 3)
plot(sd3)
dev.off()

# possiamo anche cambiare la moving window

# ESERCIZIO: calcolare la SD del NIR con una moving window di 5 pixels
sd5 = focal(NIR, w = c(5,5), fun = sd)
plot(sd5)
# aumentando la finestra aumentiamo la dimensione delle aree in cui abbiamo la differenza

# ESERCIZIO: usiamo ggplot per plottare la SD
gg5 = im.ggplot(sd5) # cambia solo che stiamo usando la griglia grigia

# ESERCIZIO: plottiamo le due mappe di ggplot (sd3 e sd5), una accanto all'altra, con ggplot
gg3 = im.ggplot(sd3)
gg5 + gg3

# installiamo il pacchetto RStoolbox
#install.packages("RStoolbox")
library(RStoolbox)

# ESERCIZIO: usare ggplot per plottare il set originale in RGB (con la funzione ggRGB()) insieme alle due SD di prima
RGB = ggRGB(sent, r = 1, g = 2, b = 3)
RGB + gg3 + gg5
# e' un metodo carino per avere tutte le immagini uguali anche se hanno la legenda
