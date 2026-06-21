#### Maria Luce Loche
## Progetto di Telerilevamento Geo-Ecologico in R - anno 2024/2025
#### Laurea Magistrale in Geologia per lo sviluppo sostenibile (LM-74 R)

# Mappatura dei sedimenti in sospensione e mappatura della torbidità nel Delta del Po
### Indice
1. Inquadramento
2. Obiettivo
3. Dati
4. Mappatura dei plume
5. Conclusioni
6. Bibliografia

## 1 - Inquadramento 
Il delta del Po è situato nell’Italia nord‑orientale, lungo la costa dell’Adriatico settentrionale, tra le regioni Veneto ed Emilia‑Romagna.
L’area deltizia si estende per circa 200–300 km² con una morfologia complessa e articolata in diversi rami distributari (tra cui il Po di Goro e il Po di Pila), che convogliano acqua e sedimenti verso il mare.
Dal punto di vista geomorfologico, il delta del Po è un delta fluvio-influenzato a seguito del taglio di Portoviro avveuto  circa 350 anni fa. 
Il fiume controlla quindi l'apporto sedimentario mentre la corrente lungo costa regola la dispersione e ridistribuzione del sedimento nell'Adriatico.

La torbidità dell'acqua è legata alla concentrazione di sedimenti in sospensione, fortemente influenzata dalle condizioni metereologiche e idrologiche: periodi con precipitazioni intense o ricorrenti determinano una maggiore erosione del bacino e quindi un maggiore apporto a mare creando una maggiore torbidità, viceversa in periodi di secca o con scarse precipitazioni osserveeremo un'acqua più pulita.

Per cui la distribuzione dei sedimenti sospesi nel delta del Po è il risultato dell’interazione tra dinamica fluviale e forzanti meteorologiche, che controllano sia il carico sedimentario sia la dispersione dei plume in ambiente costiero.

## 2 - Obiettivo
Lo scopo di questo progetto è la mappatura del sedimento in sospensione in 4 immagini multispettrali del Sentinel 2. Le immagini sono state scelte per osservare sia la variabilità stagionale (estate e inverno del 2025) sia due casi studio eccezionali quali una alluvione (Maggio 2023) e una secca (Agosto 2022).
Allo scopo di mappare i plume di sedimento sono stati usati diversi indici quali NDWI, NDTI e la combinazione dei due.

## 3- Dati
Le immagini satellitari del Landsat-2 usate sono state scaricate dal portale [Copernicus](https://browser.dataspace.copernicus.eu/) in funzione del periodo scelto. 
Nello specifico le date usate sono:
- 11/08/2022
- 23/05/2023
- 15/08/2025
- 23/11/2025

Le analisi sono state svolte usando ***R Studio*** e i seguenti pacchetti:
``` r
library(terra)    # per analisi immagini satellitari
library(imageRy)  # per analizzare e visualizzare immagini raster  
library(viridis)  # per plottare immagini con varie palette viridis 
library(ggplot2)  # per creare e visualizzare grafici
```
Prima di caricare le immagini è stata settata la working directory e importata l'area di studio sottoforma di shapefile per ritagliare le immagini:
``` r
# set della working directory
setwd("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO")
# Shapefile dell'area di studio
area = vect("ShapeFiles/PO.shp")
```
I dati sono stati caricati tutti allo stesso modo. Di seguito un esempio per l'Agosto 2022:
``` r
# Dati AGOSTO 2022 - Secca record
B2_AGO_2022 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_AGO_2022/B02.jp2")  # Blu
B3_AGO_2022 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_AGO_2022/B03.jp2")  # Verde
B4_AGO_2022 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_AGO_2022/B04.jp2")  # Rosso
B8_AGO_2022 = rast("C:/Users/maria/OneDrive/Desktop/TELERILEVAMENTO/dati_AGO_2022/B08.jp2")  # NIR
# Taglio l'immagine 
AGO_2022 = crop(c(B2_AGO_2022, B3_AGO_2022, B4_AGO_2022, B8_AGO_2022), area)
# Rinomino gli elementi
names(AGO_2022) = c("B2", "B3", "B4", "B8")
```
Per visualizzare le immagini è stato usato il comando *im.plotRGB* andando a specificare le bande per ottenere una visualizzazione in colori naturali (spettro del visibile). Le immagini sono state poi espostate in un multiframe ottenendo l'immagine seguente:
``` r
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
```
<img width="2000" height="2000" alt="Multiframe_ColoriNaturali" src="https://github.com/user-attachments/assets/07e6539a-c982-4611-9a64-0bd98ecde2a2" />
Figura 1 - Multiframe a colori naturali del Delta del Po per i 4 casi presi in considerazione

Per andare ad osservare meglio il contrasto tra acqua e sedimento sono state poi create le immagini a falsi colori andando a sostituire il NIR al blu. Questa operazione permette di visualizzare l'acqua limpida con un colore scuro mentre il sedimento con colori brillanti:
``` r
im.multiframe(2, 2) # multiframe con 2 righe e 2 colonne
im.plotRGB(AGO_2022, r = 3, g = 2, b = 4, title = "Agosto 2022")
im.plotRGB(AGO_2025, r = 3, g = 2, b = 4, title = "Agosto 2025")
im.plotRGB(MAG_2023, r = 3, g = 2, b = 4, title = "Maggio 2023")
im.plotRGB(NOV_2025, r = 3, g = 2, b = 4, title = "Novembre 2025")
dev.off()
```
<img width="2000" height="2000" alt="Multiframe_FalsiColori" src="https://github.com/user-attachments/assets/c6b8a7d8-e1d5-462a-9d61-c593560984e0" />

Figura 2 - Multiframe a falsi colori (NIR al posto della banda 2 del blu) per far risaltare il plume di sedimento alla foce del Po.


