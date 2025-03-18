# Codice per effettuare una analisi multitemporale
# richiamiamo i pacchetti
library(imageRy)
library(terra)
library(viridis)
#andiamo a vedere i file disponibili
im.list()
# prendiamo i file che riguardano gli ossidi di azoto prodotti dal traffico --> durante il lockdown sono diminuiti i valori
# importiamo le immagini di gennaio e marzo
EN_01 = im.import("EN_01.png") # immagine RGB in rainbow color dell'ESA --> problema per i daltonici
EN_01 = flip(EN_01)
plot(EN_01)
# immagine pre-analizzata di Gennaio 2020 --> le zone molto industrializzate sono caratterizzate da un forte traffico veicolare
EN_13 = im.import("EN_13.png")
EN_13 = flip(EN_13)
plot(EN_13)
# immagine di Marzo 2020 --> notiamo una discreta diminuzione del traffico automobilistico (quello rimastoi probabilmente sono industrie)

# ESERCIZIO: plottare le due immagini una di fianco all'altra
im.multiframe(1, 2) # multifame da una riga e due colonne
plot(EN_01)
plot(EN_13)
dev.off()

# possiamo fare una differenza tra le due immagini per vedere la variazione (dato che le due immagini sono RGB)
ENdif = EN_01[[1]]-EN_13[[1]] # differenza tra i primi due livelli delle immagini
plot(ENdif)
plot(ENdif, col = inferno(100)) # le zone molto gialle rappresentano quelle in cui c'è stata una netta diminuzione

# ora usiamo un dataset completo --> dati di temperatura dello scioglimento dei ghiacci della Groenlandia (programma COPERNICUS) 
gr = im.import("greenland")
plot(gr) # notiamo un abbassamento delle temperature della calotta di ghiaccio dal 2000 al 2015
gr # restituisce i valori del dataset di immagini 
# plottiamo l'immagine del 2000 e del 2015
im.multiframe(1, 2)
plot(gr[[1]], col = rocket(100))
plot(gr[[4]], col = rocket(100))
dev.off()
# facciamo la differenza tra le due
grdif = gr[[1]]-gr[[4]]
plot(grdif)

# proviamo ad esportare il dato con il set working directory (cartella di riferimento)
setwd("C://Users/maria/OneDrive/Desktop/UNI/MAGISTRALE/Telerilevamento in R/Immagini_esportate") # dobbiamo stare attenti a non usare un backslash "\" ma quelli dritti
getwd() # per controllare che tutto sia giusto

# CREIAMO L'IMMAGINE:
# creiamo il file
png("greenland_output.png") # crea un file png all'interno della cartella di riferimento
# ci plottiamo dentro l'immagine che vogliamo con un plot
plot(gr)
# chiudiamo il file
dev.off()

# possiamo usare anche altri tipi di file: pdf(), tif(), jpeg() ecc...
pdf("greenland_dif.pdf") # pdf dell'immagine della differenza tra le due immagini --> non perde di qualità
plot(grdif)
dev.off()






