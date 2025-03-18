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

# ora usiamo un dataset completo
im-import()

