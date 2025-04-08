# richiamiamo i pacchetti
library(imageRy)
library(terra)
library(ggplot2)
library(patchwork)

im.list()

# importiamo le immagini che ci servono
mato1992 = im.import("matogrosso_l5_1992219_lrg.jpg")
mato1992 = flip(mato1992)
plot(mato1992)

mato2006 = im.import("matogrosso_ast_2006209_lrg.jpg")
mato2006 = flip(mato2006)
plot(mato2006)

# andiamo a effettuare una classificazione attraverso la seguente funzione:
mato1992c = im.classify(mato1992, num_clusters = 2, seed = 4) # usiamo solo due cluster che sono le due classi con cui dividiamo i pixel
# classe 1 = foresta
# classe 2 = antropico
# il seed indica quale delle n-possibili classificazioni che vogliamo visualizzare

mato2006c = im.classify(mato2006, num_clusters = 2, seed = 4) # facciamo la stessa cosa per la seconda foto
# classe 1 = foresta
# classe 2 = antropico

# andiamo a calcolare le percentuali dei pixel:
# iniziamo calcolando la frequenza cioè ogni quanto abbiamo lo stesso pixel
f1992 = freq(mato1992c)
# leggiamo che per la classe 2 (foresta) abbiamo 304437 pixel

# andiamo a calcolare il numero totale di pixel dell'immagine
tot1992 = ncell(mato1992c)
# calcoliamo le proporzioni
prop1992 = f1992/tot1992
# per avere le perentuali andiamo a calcolare le proporzioni*100
perc1992 = prop1992*100
# antropico = circa 17%
# foresta = 83%

#andiamo a calcolarlo per la seconda immagine:
tot2006 = ncell(mato2006c)
perc2006 = freq(mato2006c)*100/ tot2006 # abbiamo rifatto lo stesso calcolo ma più velocemente
# antropico = 55%
# foresta =  45%

# andiamo a usare il pacchetto ggplot2 per creare dei grafici

# creiamo un dataframe (tabella):
class = c("Forest", "Human")
y1992 = c(83, 17)
y2006 = c(45, 55)
tabout = data.frame(class, y1992, y2006)
tabout # visualizziamo la tabellina appena creata

# andiamo a plottare la tabella:
# il parametro aes (aesthetic) definisce cosa va nella x, cosa nella y e il colore
p1 =ggplot(tabout, aes(x = class, y = y1992, color = class)) + 
      geom_bar(stat = "identity", fill = "white") + # definisce un grafico con barre (istogramma)
        ylim(c(0, 100))

p2 = ggplot(tabout, aes(x = class, y = y2006, color = class)) +
      geom_bar(stat= "identity", fill = "white")+
        ylim(c(0, 100))

# possiamo andare ad unire dei grafici fatti con ggplo con la funzione del pacchetto patchwork (i grafici devono essere associati a degli oggetti)
p1 + p2 # abbiamo il problema che non hanno la stessa scala (lo risolviamo nei plot di prima con la funzione ylim)
# otteniamo un grafico riscalato

# possiamo anche metterli uno sopra l'altro usando il /
p1 / p2

# mettiamo insieme le immagini e i grafici
p0 = im.ggplot(mato1992) # plotta solo la prima banda
p00 = im.ggplot(mato2006)
p0 + p00 + p1 + p2


classall = c("Forest1992","Human1992","Forest2006","Human2006")
percentage = c(83,17,45,55)
all = data.frame(classall, percentage)
dev.off()

# Mettiamo insieme un barplot con più gruppi
ggplot(data=all, aes(x=classall, y=percentage, color=classall)) +
  geom_bar(stat="identity", fill="white")

#Solar Orbiter
# importiamo il file che ci serva
im.list()
solar = im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

# ESERCIZIO: classifichiamo l'immagine in tre classi - im.classify()
solarc = im.classify(solar, num_clusters=3)

# Plottiamo l'immagine originale vicino a quella classificata
im.multiframe(1,2)
plot(solar)
plot(solarc)
dev.off()
# 3 = basso
# 1 = medio
# 2 = alto

solarcs = subst(solarc, c(3,1,2), c("c1_low","c2_medium","c3_high"))
plot(solarcs)

# ESERCIZIO: calcolare la percentuale delle classi di energia solare con una riga di codice:
percsolar = freq(solarcs)$count * 100 / ncell(solarcs)
# 37.92693 41.04342 21.02965
# le arrotondiamo a 38 41 21

# creiamo un dataframe con le classi
class = c("c1_low","c2_medium","c3_high")
# controlliamo i nomi degli oggetti
perc = c(38,41,21)
tabsol = data.frame(class, perc)

# plottiamo un ggplot finale
ggplot(tabsol, aes(x=class, y=perc, fill=class, color=class)) +
  geom_bar(stat="identity") +
#  ylim(c(0,100)) 
  coord_flip() 
# + scale_y_reverse()
