# R code for visualizing satellite images

# Se non lo si è ancora fatto:
# install.packages("devtools")
# library (devtools)
# install_github("ducciorocchini/imageRy")

library (terra) # pacchetto da cui passano tutti i dati di telerilevamento --> è più veloce della sua controparte più vecchia "raster"
library (imageRy)

# Iniziamo con le funzioni
im.list() # restituisce la lista di tutti i file che abbiamo a disposizione

# ATTENZIONE: per l'intero corso andiamo ad usare = invece di <-
b2 = im.import("sentinel.dolomites.b2.tif") # andiamo ad importare la banda 2 dell'immagine che ci interessa
# bande del sentine 2: https://custom-scripts.sentinel-hub.com/custom-scripts/sentinel-2/bands/
cl = colorRampPalette(c("black", "dark grey", "light grey"))(100) # andiamo a definire le gamme di colori che ci interessano, con una variazione tra un colore e l'altro di 100 tonalità (gamme che separano un colore dall'altro)
plot(b2, col = cl) # rapresento l'immagine con la nuova scala di colori
# osserviamo che tutti gli oggetti che riflettono il blu avranno delle tonalità chiare, tendente al grigio chiaro

# Esercizio: creare la propria palette
# sito per colori: https://sites.stat.columbia.edu/tzheng/files/Rcolor.pdf
blue = colorRampPalette(c("navy", "royalblue1", "paleturquoise1"))(100)
plot(b2, col =  blue)

# Importiamo le altre bande della stessa immagine:
b3 = im.import("sentinel.dolomites.b3.tif") # banda del verde (circa 500 nm)
b4 = im.import("sentinel.dolomites.b4.tif") # banda del rosso (circa 650 nm)
b8 = im.import("sentinel.dolomites.b8.tif") # banda dell'infrarosso vicino (near infra-red NIR) (circa 750 nm)

# andiamo a plottare tutte le bande insieme:
par(mfrow = c(1, 4)) # apre una finestra vuota con 1 riga e 4 colonne
plot(b2)
plot(b3)
plot(b4)
plot(b8)
# in alternativa usiamo:
im.multiframe(1,4)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

# Esercizio: plottare le bande usando la funzione im.multiframe mettendo i plot uno sopra l'altro:
im.multiframe(4,1)
plot(b2)
plot(b3)
plot(b4)
plot(b8)

# due righe e due colonne e cambiando i colori
cl2 = colorRampPalette(c("black", "darkgrey", "white"))(100)
im.multiframe(2,2)
plot(b2, col =cl2)
plot(b3, col =cl2)
plot(b4, col =cl2)
plot(b8, col =cl2)
dev.off()

# Mettiamo insieme le bande:
sent = c(b2, b3, b4, b8) # creiamo una immagine con 4 bande tramite uno stack c()
names(sent) = c("b2_Blue", "b3_Green", "b4_Red", "b8_NIR") # cambio i nomi delle bande in sent
plot(sent, col = cl2)  # il plot ora ci fa visualizzare i nomi delle bande sopra

# Plottiamo una sola banda da uno stack
plot(sent$b8_NIR)
# oppure
plot(sent[[4]]) # prendiamo solo il quarto elemento

# Importiamo diverse bande tutte insieme
sentdol = im.import("sentinel.dolomites") # metto solo la parte del nome che è comune a tutte le immagini che mi interessa

# Per fare una correlazione tra due immagini alla volta nel nostro dataset:
pairs(sentdol)
# attraverso il coeff. di correlazione di Pierson osserviamo la correlazione tra le bande 

# Importiamo il pacchetto di colori Viridis:
install.packages("viridis")
library (viridis)
# Esempio di plot con viridis
plot(sentdol, col = viridis(100))
plot(sentdol, col = mako(100))
