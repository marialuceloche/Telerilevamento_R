# PROGETTO TELERILEVAMENTO 2025
# Mappatura dei sedimenti in sospensione e mappatura della torbidità nel Delta del Po

# Pacchetti usati:
library(terra) # per analisi immagini satellitari
library(imageRy) # Per analizzare immagini raster in R
library(viridis) # per plottare immagini con varie palette viridis
library(patchwork) # per creare un layout multiplot da più grafici
library(ggplot2) # per visualizzare grafici

# ANALISI SEDIMENTI e TORBIDITA' nel DELTA del PO
# Sono stati scelti 4 casi di cui 2 casi di secca (tra cui l'estate 2022) e 2 casi di piena (tra cui il maggio 2023)
# Paper da cui ho preso spunto: 
cat("Paper Manzo et. al, 2018: https://www.sciencedirect.com/science/article/pii/S0303243417302714")

## CARICO I DATI
# set della working directory
setwd("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO")
# Shapefile dell'area di studio
area = vect("ShapeFiles/PO.shp")

# Dati da Sentinel-2
# Dati AGOSTO 2022 - Secca record
B2_AGO_2022 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_AGO_2022/B02.jp2")
B3_AGO_2022 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_AGO_2022/B03.jp2")
B4_AGO_2022 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_AGO_2022/B04.jp2")
B8_AGO_2022 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_AGO_2022/B08.jp2")
AGO_2022 = crop(c(B2_AGO_2022, B3_AGO_2022, B4_AGO_2022, B8_AGO_2022), area)
names(AGO_2022) = c("B2", "B3", "B4", "B8")

# Dati AGOSTO 2025
B2_AGO_2025 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_AGO_2025/B02.jp2")
B3_AGO_2025 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_AGO_2025/B03.jp2")
B4_AGO_2025 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_AGO_2025/B04.jp2")
B8_AGO_2025 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_AGO_2025/B08.jp2")
AGO_2025 = crop(c(B2_AGO_2025, B3_AGO_2025, B4_AGO_2025, B8_AGO_2025), area)
names(AGO_2025) = c("B2", "B3", "B4", "B8")

# Dati MAGGIO 2023 - Alluvione 
B2_MAG_2023 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_MAG_2023/B02.jp2")
B3_MAG_2023 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_MAG_2023/B03.jp2")
B4_MAG_2023 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_MAG_2023/B04.jp2")
B8_MAG_2023 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_MAG_2023/B08.jp2")
MAG_2023 = crop(c(B2_MAG_2023, B3_MAG_2023, B4_MAG_2023, B8_MAG_2023), area)
names(MAG_2023) = c("B2", "B3", "B4", "B8")

# Dati NOVEMBRE 2025
B2_NOV_2025 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_NOV_2025/B02.jp2")
B3_NOV_2025 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_NOV_2025/B03.jp2")
B4_NOV_2025 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_NOV_2025/B04.jp2")
B8_NOV_2025 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_NOV_2025/B08.jp2")
NOV_2025 = crop(c(B2_NOV_2025, B3_NOV_2025, B4_NOV_2025, B8_NOV_2025), area)
names(NOV_2025) = c("B2", "B3", "B4", "B8")

## VISUALIZZAZIONE in colori naturali
im.multiframe(2, 2) # multiframe con 2 righe e 3 colonne
im.plotRGB(AGO_2022, r = 3, g = 2, b = 1, title = "Agosto 2022")
im.plotRGB(AGO_2025, r = 3, g = 2, b = 1, title = "Agosto 2025")
im.plotRGB(MAG_2023, r = 3, g = 2, b = 1, title = "Maggio 2023")
im.plotRGB(NOV_2025, r = 3, g = 2, b = 1, title = "Novembre 2025")
dev.off()

# =============================================
# Esportazione multiframe
png("Multiframe_ColoriNaturali.png", width = 2000, height = 2000, res = 300)
im.multiframe(2, 2) # multiframe con 2 righe e 2 colonne
im.plotRGB(AGO_2022, r = 3, g = 2, b = 1, title = "Agosto 2022")
im.plotRGB(AGO_2025, r = 3, g = 2, b = 1, title = "Agosto 2025")
im.plotRGB(MAG_2023, r = 3, g = 2, b = 1, title = "Maggio 2023")
im.plotRGB(NOV_2025, r = 3, g = 2, b = 1, title = "Novembre 2025")
dev.off()
# =============================================

# Immagini a falsi colori per osservare meglio l'acqua e il sedimento
# Vado a sostituire il NIR al blu per avere l'acqua limpida in scuro e il sedimento in verde/giallo brillante
im.multiframe(2, 2) # multiframe con 2 righe e 2 colonne
im.plotRGB(AGO_2022, r = 3, g = 2, b = 4, title = "Agosto 2022")
im.plotRGB(AGO_2025, r = 3, g = 2, b = 4, title = "Agosto 2025")
im.plotRGB(MAG_2023, r = 3, g = 2, b = 4, title = "Maggio 2023")
im.plotRGB(NOV_2025, r = 3, g = 2, b = 4, title = "Novembre 2025")
dev.off()

# =============================================
# Esportazione multiframe
png("Multiframe_FalsiColori.png", width = 2000, height = 2000, res = 300)
im.multiframe(2, 2) # multiframe con 2 righe e 2 colonne
im.plotRGB(AGO_2022, r = 3, g = 2, b = 4, title = "Agosto 2022")
im.plotRGB(AGO_2025, r = 3, g = 2, b = 4, title = "Agosto 2025")
im.plotRGB(MAG_2023, r = 3, g = 2, b = 4, title = "Maggio 2023")
im.plotRGB(NOV_2025, r = 3, g = 2, b = 4, title = "Novembre 2025")
dev.off()
# =============================================

# ACQUA (NDWI) e TORBIDITA' (NDTI) 
# NDWI = (verde - NIR)/(verde + NIR) --> per l'acqua
# NDTI = (rosso - verde)/(rosso + verde) --> per la torbidità
# NDTI * NDWI --> acque ricche di sedimenti mostreranno valori più elevati rispetto alle acque limpide (valori nulli)

####### Agosto 2022
# NDWI
NDWI_2022 = (AGO_2022$B3 - AGO_2022$B8) / (AGO_2022$B3 + AGO_2022$B8)
plot(NDWI_2022)
acqua_2022 = NDWI_2022 > 0 
AGO_2022_acqua = mask(AGO_2022, acqua_2022, maskvalue = T, inverse = T)
im.plotRGB(AGO_2022_acqua, r = 3, g = 2, b = 1)
# NDTI
NDTI_2022 = (AGO_2022_acqua$B4 - AGO_2022_acqua$B3) / (AGO_2022_acqua$B4 + AGO_2022_acqua$B3)
plot(NDTI_2022)
# NDTI * NDWI 
sed_2022 = (NDTI_2022 * NDWI_2022)
plot(sed_2022)
plume_2022 = sed_2022 < -0.01
plot(plume_2022)
final_2022 = mask(sed_2022, plume_2022, maskvalue = T, inverse =T)
plot(final_2022)

# Confronto immagine true colours con il plume di sedimento ottenuto
im.multiframe(1, 2)
im.plotRGB(AGO_2022, r = 3, g = 2, b = 1)
plot(final_2022)
dev.off()

# Immagine satellitare con il plume messo in evidenza
im.plotRGB(AGO_2022, r = 3, g = 2, b = 1, title = "Plume sedimento Agosto 2022")
plot(final_2022, add = T, alpha = 1)




####### Agosto 2025
# NDWI 
NDWI_A2025 = (AGO_2025$B3 - AGO_2025$B8) / (AGO_2025$B3 + AGO_2025$B8)
plot(NDWI_A2025)
acqua_A2025 = NDWI_A2025 > 0 # limite a 0.1 per diminuire l'acqua a solo quella carica di sedimento
AGO_2025_acqua = mask(AGO_2025, acqua_A2025, maskvalue = T, inverse = T)
im.plotRGB(AGO_2025_acqua, r = 3, g = 2, b = 1)
# NDTI 
NDTI_A2025 = (AGO_2025_acqua$B4 - AGO_2025_acqua$B3) / (AGO_2025_acqua$B4 + AGO_2025_acqua$B3)
plot(NDTI_A2025)
# NDTI * NDWI 
sed_A2025 = (NDTI_A2025 * NDWI_A2025)
plot(sed_A2025)
plume_A2025 = sed_A2025 < -0.01
plot(plume_A2025)
final_A2025 = mask(sed_A2025, plume_A2025, maskvalue = T, inverse =T)
plot(final_A2025)

# Confronto immagine true colours con il plume di sedimento ottenuto
im.multiframe(1, 2)
im.plotRGB(AGO_2025, r = 3, g = 2, b = 1)
plot(final_A2025)
dev.off()

# Immagine satellitare con il plume messo in evidenza
im.plotRGB(AGO_2025, r = 3, g = 2, b = 1, title = "Plume sedimento Agosto 2025")
plot(final_A2025, add = T, alpha = 1)




####### Maggio 2023
# NDWI
NDWI_2023 = (MAG_2023$B3 - MAG_2023$B8) / (MAG_2023$B3 + MAG_2023$B8)
plot(NDWI_2023)
acqua_2023 = NDWI_2023 > 0 
MAG_2023_acqua = mask(MAG_2023, acqua_2023, maskvalue = T, inverse = T)
im.plotRGB(MAG_2023_acqua, r = 3, g = 2, b = 1)
# NDTI
NDTI_2023= (MAG_2023_acqua$B4 - MAG_2023_acqua$B3) / (MAG_2023_acqua$B4 + MAG_2023_acqua$B3)
plot(NDTI_2023)
# NDTI * NDWI
sed_2023 = (NDTI_2023 * NDWI_2023)
plot(sed_2023)
plume_2023 = sed_2023 < -0.01
plot(plume_2023)
final_2023 = mask(sed_2023, plume_2023, maskvalue = T, inverse =T)
plot(final_2023)

# Confronto immagine true colours con il plume di sedimento ottenuto
im.multiframe(1, 2)
im.plotRGB(MAG_2023, r = 3, g = 2, b = 1)
plot(final_2023)
dev.off()

# Immagine satellitare con il plume messo in evidenza
im.plotRGB(MAG_2023, r = 3, g = 2, b = 1, title = "Plume sedimento Maggio 2023")
plot(final_2023, add = T, alpha = 1)




####### Novembre 2025
# NDWI
NDWI_N2025 = (NOV_2025$B3 - NOV_2025$B8) / (NOV_2025$B3 + NOV_2025$B8)
plot(NDWI_N2025)
acqua_N2025 = NDWI_N2025 > 0 # limite a 0.1 per diminuire l'acqua a solo quella carica di sedimento
NOV_2025_acqua = mask(NOV_2025, acqua_N2025, maskvalue = T, inverse = T)
im.plotRGB(NOV_2025_acqua, r = 3, g = 2, b = 1)
# NDTI 
NDTI_N2025 = (NOV_2025_acqua$B4 - NOV_2025_acqua$B3) / (NOV_2025_acqua$B4 + NOV_2025_acqua$B3)
plot(NDTI_N2025)
# NDTI * NDWI
sed_N2025 = (NDTI_N2025 * NDWI_N2025)
plot(sed_N2025)
plume_N2025 = sed_N2025 < -0.035
plot(plume_N2025)
final_N2025 = mask(sed_N2025, plume_N2025, maskvalue = T, inverse =T)
plot(final_N2025)

# Confronto immagine true colours con il plume di sedimento ottenuto
im.multiframe(1, 2)
im.plotRGB(NOV_2025, r = 3, g = 2, b = 1)
plot(final_N2025)
dev.off()

# Immagine satellitare con il plume messo in evidenza
im.plotRGB(NOV_2025, r = 3, g = 2, b = 1, title = "Plume sedimento Novembre 2025")
plot(final_N2025, add = T, alpha = 1)



# =============================================
# Esporto le singole immagini dei plume
# Agosto 2022
png("Agosto_2022.png", width = 2000, height = 1000, res = 300)
im.plotRGB(AGO_2022, r = 3, g = 2, b = 1, title = "Plume Agosto 2022")
plot(final_2022, add = T, alpha = 1, legend = F)
dev.off()

# Agosto 2025
png("Agosto_2025.png", width = 2000, height = 1000, res = 300)
im.plotRGB(AGO_2025, r = 3, g = 2, b = 1, title = "Plume Agosto 2025")
plot(final_A2025, add = T, alpha = 1, legend = F)
dev.off()

# Maggio 2023
png("Maggio_2023.png", width = 2000, height = 1000, res = 300)
im.plotRGB(MAG_2023, r = 3, g = 2, b = 1, title = "Plume Maggio 2023")
plot(final_2023, add = T, alpha = 1, legend = F)
dev.off()

# Novembre 2025
png("Novembre_2025.png", width = 2000, height = 1000, res = 300)
im.plotRGB(NOV_2025, r = 3, g = 2, b = 1, title = "Plume Novembre 2025")
plot(final_N2025, add = T, alpha = 1, legend = F)
dev.off()
# =============================================
# Esporto le 4 immagini insieme:

png("Plume_multiframe.png", width = 3000, height = 3000, res = 300)
# layout 2 righe x 2 colonne
par(mfrow = c(2,2), mar=c(2,2,5,2))

# Agosto 2022
im.plotRGB(AGO_2022, r = 3, g = 2, b = 1, title = "Agosto 2022")
plot(final_2022, add = TRUE, alpha = 1, legend = FALSE)

# Agosto 2025
im.plotRGB(AGO_2025, r = 3, g = 2, b = 1, title = "Agosto 2025")
plot(final_A2025, add = TRUE, alpha = 1, legend = FALSE)

# Maggio 2023
im.plotRGB(MAG_2023, r = 3, g = 2, b = 1, title = "Maggio 2023")
plot(final_2023, add = TRUE, alpha = 1, legend = FALSE)

# Novembre 2025
im.plotRGB(NOV_2025, r = 3, g = 2, b = 1, title = "Novembre 2025")
plot(final_N2025, add = TRUE, alpha = 1, legend = FALSE)

dev.off()
# =============================================





# Torbidità:
##### Classifico i pixel in 4 gruppi
NDTI_2022c = im.classify(final_2022, num_clusters = 4)
NDTI_A2025c = im.classify(final_A2025, num_clusters = 4)
NDTI_2023c = im.classify(final_2023, num_clusters = 4)
NDTI_N2025c = im.classify(final_N2025, num_clusters = 4)


##### rinomino le classi ottenute
# creo una funzione che permette di mettere in ordine le 4 classi di ogni immagine in funzione della media (dal valore più basso a quello più alto)
riordina_classi = function(raster_ndti, raster_classificato) {
  medie = zonal(raster_ndti, raster_classificato, fun = "mean")
  ordine = medie[order(medie[[2]]), 1]  # cluster ID ordinati dal NDTI più basso al più alto
  subst(raster_classificato, ordine, c("1_bassa", "2_medio-bassa", "3_medio-alta", "4_alta"))
}
# 2022
NDTI_2022c_raw = im.classify(final_2022, num_clusters = 4)
NDTI_2022c = riordina_classi(final_2022, NDTI_2022c_raw)
zonal(final_2022, NDTI_2022c_raw, fun = "mean") # controllo l'ordine dei valori ottenuti per definire l'ordine delle classi

# A2025
NDTI_A2025c_raw = im.classify(final_A2025, num_clusters = 4)
NDTI_A2025c = riordina_classi(final_A2025, NDTI_A2025c_raw)
zonal(final_A2025, NDTI_A2025c_raw, fun = "mean")

# 2023
NDTI_2023c_raw = im.classify(final_2023, num_clusters = 4)
NDTI_2023c = riordina_classi(final_2023, NDTI_2023c_raw)
zonal(final_2023, NDTI_2023c_raw, fun = "mean")

# N2025
NDTI_N2025c_raw = im.classify(final_N2025, num_clusters = 4)
NDTI_N2025c = riordina_classi(final_N2025, NDTI_N2025c_raw)
zonal(final_N2025, NDTI_N2025c_raw, fun = "mean")

# Esporto i plume classificati
png("Plume_classificazione.png", width = 3000, height = 3000, res = 300)
# layout 2 righe x 2 colonne
par(mfrow = c(2,2), mar=c(2,2,5,2))
plot(NDTI_2022c)
plot(NDTI_A2025c)
plot(NDTI_2023c)
plot(NDTI_N2025c)
dev.off()


##### calcolo le percentuali in funzione dell'area del plume
# 2022
area_2022 = global(cellSize(final_2022, unit = "km"), "sum", na.rm = T)
pixel_2022 = cellSize(NDTI_2022c, unit = "km")
classi_2022 = zonal(pixel_2022, NDTI_2022c, fun = "sum", na.rn = T)
classi_2022
perc_2022 = classi_2022$area * 100 / sum(classi_2022$area)

# A2025
area_A2025 = global(cellSize(final_A2025, unit = "km"), "sum", na.rm = T)
pixel_A2025 = cellSize(NDTI_A2025c, unit = "km")
classi_A2025 = zonal(pixel_A2025, NDTI_A2025c, fun = "sum", na.rn = T)
classi_A2025
perc_A2025 = classi_A2025$area * 100 / sum(classi_A2025$area)

# 2023
area_2023 = global(cellSize(final_2023, unit = "km"), "sum", na.rm = T)
pixel_2023 = cellSize(NDTI_2023c, unit = "km")
classi_2023 = zonal(pixel_2023, NDTI_2023c, fun = "sum", na.rn = T)
classi_2023
perc_2023 = classi_2023$area * 100 / sum(classi_2023$area)

# N2025
area_N2025 = global(cellSize(final_N2025, unit = "km"), "sum", na.rm = T)
pixel_N2025 = cellSize(NDTI_N2025c, unit = "km")
classi_N2025 = zonal(pixel_N2025, NDTI_N2025c, fun = "sum", na.rn = T)
classi_N2025
perc_N2025 = classi_N2025$area * 100 / sum(classi_N2025$area)


##### Grafico
g1 = ggplot(classi_2022, aes(x=value, y=area, fill=value)) +
  geom_bar(stat="identity") +
  ylim(0, 300) +
  ylab("Area (km²)") +
  xlab("Classi") +
  ggtitle("Torbidità Agosto 2022") +
  theme(legend.position="none")


g2 = ggplot(classi_A2025, aes(x=value, y=area, fill=value)) +
  geom_bar(stat="identity") +
  ylim(0, 300) +
  ylab("Area (km²)") +
  xlab("Classi") +
  ggtitle("Torbidità Agosto 2025") +
  theme(legend.position="none")

g3 = ggplot(classi_2023, aes(x=value, y=area, fill=value)) +
  geom_bar(stat="identity") +
  ylim(0, 300) +
  ylab("Area (km²)") +
  xlab("Classi") +
  ggtitle("Torbidità Maggio 2023") +
  theme(legend.position="none")

g4 = ggplot(classi_N2025, aes(x=value, y=area, fill=value)) +
  geom_bar(stat="identity") +
  ylim(0, 300) +
  ylab("Area (km²)") +
  xlab("Classi") +
  ggtitle("Torbidità Novembre 2025") +
  theme(legend.position="none")

g1 + g2 + g3 + g4
# g1 = prevalgono le classi media e alta di torbidità concentrata vicino agli emissari del Po 
# g2 = come g1
# g3 = aumento netto delle classi medio-alte a causa del grande apporto di sedimento a seguito delle forti piogge --> si spinge più a mare
# g4 = torbidità bassa e media caratterizzata da una grande dispersione dei sedimenti lungo costa

png("Grafici_Torbidità.png", width = 3000, height = 3000, res = 300)
g1 + g2 + g3 + g4
dev.off()

# ANALISI MULTITEMPORALE ESTATE - INVERNO 2025
# valori positivi → più torbidità in inverno
# valori negativi → più torbidità in estate
# differenza NDTI 
diff_2025 = NDTI_N2025 - NDTI_A2025
more_winter = diff_2025 > 0

png("Differenza_NDTI_2025.png", width = 2000, height = 1000, res = 300)
par(oma = c(0,0,3,0)) 
im.multiframe(1, 2)
plot(diff_2025, col = plasma(100))
plot(more_winter, col = plasma(100))
mtext("Differenza NDTI inverno - estate 2025", 
      side = 3,      # sopra
      outer = TRUE,  # spazio esterno
      cex = 1.5     # dimensione testo
)
dev.off()

