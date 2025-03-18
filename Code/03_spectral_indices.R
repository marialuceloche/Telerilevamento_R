# Codice per calcolare gli indici spettrali da immagini satellitari
# Richiamo, i pacchetti che useremo
library (terra)
library (imageRy)
library (viridis)

im.list() # restituisce la lista di tutti i file che abbiamo a disposizione

# importiamo l'immagine che ci interessa
mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")
# è una immagine del Landsat l5 (satellite della NASA) che monitora la Terra dal 1975 ad oggi
# nel nostro caso l'immagine JPG è stata letta al contrario per cui possiamo usare la funzione seguente:
mato1992 = flip(mato1992) # da sola la funzione non ci mostra l'immagine per cui deve essere ri-plottata
# le bande sono:
# 1 = NIR
# 2 = red
# 3 = green
im.plotRGB(mato1992, r = 1, g = 2, b = 3) # ora stiamo visualizzando l'immagine corretta (cioè girata)

# trasformiamo la visualizzazione dell'immagine mettendo il NIR nella componente verde
im.plotRGB(mato1992, r = 2, g = 1, b = 3) # con questa composizione vediamo tutta la vegetazione in verde e l'attività antropica in viola
# facciamo la stessa cosa con il NIR nel blu
im.plotRGB(mato1992, r = 2, g = 3, b = 1) # osserviamo come il suolo nudo adesso viene rappresentato in giallo --> con geometria euclidea

# Esercizio: importiamo anche l'immagine del 2006
mato2006 = im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 = flip(mato2006)
im.plotRGB(mato2006, r = 2, g = 3, b = 1)

# Plottiamo le due immagini una accanto all'altra con il NIR nella componente blu:
im.multiframe(1, 2)
im.plotRGB(mato1992, r = 2, g = 3, b = 1, title = "Mato Grosso 1992")
im.plotRGB(mato2006, r = 2, g = 3, b = 1, title = "Mato Grosso 2006")
# notiamo come nel 2006 il suolo nudo è aumentato notevolmente rispetto a quella del 1992

# Radiometric resolution
plot(mato1992[[1]], col = inferno(100))
plot(mato2006[[1]], col = inferno(100))
# vediamo come la risoluzione delle due immagini è diversa: questo dipende dal bit.

# DVI
# importiamo l'immagine del 2006
# mato2006 <- im.import("matogrosso_ast_2006209_lrg")

# Esercizio: plottare l'immagine del 2006 con il NIR nel verde:
im.plotRGB(mato2006, 2, 1, 3)
# Esercizio: plottare l'immagine del 2006 con il NIR nel blu:
im.plotRGB(mato2006, 2, 3, 1)

# Esercizio: plottare le due immagini assieme:
par(mfrow=c(1,2))
im.plotRGB(mato1992, 1, 2, 3)
im.plotRGB(mato2006, 1, 2, 3)
dev.off()

# Calcoliamo il DVI
# DVI 1992
dvi1992 = mato1992[[1]] - mato1992[[2]]
dvi1992
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100) # gli diamo una palette
plot(dvi1992, col=cl)

# DVI 2006
dvi2006 = mato2006[[1]] - mato2006[[2]]
dvi2006
cl <- colorRampPalette(c("darkblue", "yellow", "red", "black"))(100) 
plot(dvi2006, col=cl)

# Possiamo calcolarlo più velocemente da imageRy:
dvi1992i <- im.dvi(mato1992, 1, 2)
dvi2006i <- im.dvi(mato2006, 1, 2)


# NDVI
ndvi1992 = (mato1992[[1]] - mato1992[[2]]) / (mato1992[[1]] + mato1992[[2]])
ndvi2006 = (mato2006[[1]] - mato2006[[2]]) / (mato2006[[1]] + mato2006[[2]])
par(mfrow=c(1,2))
plot(ndvi1992, col=cl)
plot(ndvi2006, col=cl)
dev.off()

# scientifically meaningful image for everyone!
clvir <- colorRampPalette(c("violet", "dark blue", "blue", "green", "yellow"))(100)
plot(ndvi2006, col=clvir)
