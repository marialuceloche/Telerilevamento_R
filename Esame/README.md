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

## 3 - Dati
Le immagini satellitari del Landsat-2 usate sono state scaricate dal portale [Copernicus](https://browser.dataspace.copernicus.eu/) in funzione del periodo scelto. 
Nello specifico le date usate sono:
- 11/08/2022
- 23/05/2023
- 15/08/2025
- 23/11/2025

Le analisi sono state svolte usando _**R Studio**_ e i seguenti pacchetti:
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

> [!NOTE]
> Da qui in avanti il codice mostrato farà riferimento solo ad uno dei casi osservati (Agosto 2022). 
> Per leggere il codice completo fare riferimento allo scrip di R:


Per visualizzare le immagini è stato usato il comando _im.plotRGB_ andando a specificare le bande per ottenere una visualizzazione in colori naturali (spettro del visibile). Le immagini sono state poi espostate in un multiframe ottenendo l'immagine seguente:
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
_Figura 1 - Multiframe a colori naturali del Delta del Po per i 4 casi presi in considerazione._


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
_Figura 2 - Multiframe a falsi colori (NIR al posto della banda 2 del blu) per far risaltare il plume di sedimento alla foce del Po._

> [!NOTE]
> Tutte le immagini sono state esportate usando la funzione _png()_ e _dev.off()_
>

**4 - Mappatura dei plume
Per andare ad estrapolare il plume dalle immagini satellitari sono stai usati due indici principali:

*** NDWI (Normalized Difference Water Index)
Questo indice permette di evidenziare e mappare la presenza di acqua libera, sfruttando le bande del verde e del NIR, minimizzado la presenza di suolo e vegetazione. L'NDWI è stato usato per separare la terraferma dal'acqua in modo da riuscire a mappare solo i sedimenti del plume e non quelli terrestri.

Calcolo NDWI e maschera per l'acqua:
``` r
# NDWI = (verde - NIR)/(verde + NIR) --> per l'acqua
####### Agosto 2022
NDWI_2022 = (AGO_2022$B3 - AGO_2022$B8) / (AGO_2022$B3 + AGO_2022$B8)      # Calcolo NDWI
acqua_2022 = NDWI_2022 > 0                                                 # Considero solo l'acqua
AGO_2022_acqua = mask(AGO_2022, acqua_2022, maskvalue = T, inverse = T)    # Taglio l'immagine
im.plotRGB(AGO_2022_acqua, r = 3, g = 2, b = 1)                            # Visualizzo l'acqua
```

*** NDTI (Normalized Difference Turbidity Index)
L'indice NDTI permette di valutare la qualità dell'acqua e la sua torbidità in funzione dei sedimenti sospesi in essa sfruttando le bande del rosso e del verde. L'acqua limpida tenderà a riflette maggiormento il verde rispetto a quella torbida.

Calcolo NDTI
``` r
# NDTI = (rosso - verde)/(rosso + verde) --> per la torbidità
NDTI_2022 = (AGO_2022_acqua$B4 - AGO_2022_acqua$B3) / (AGO_2022_acqua$B4 + AGO_2022_acqua$B3)
plot(NDTI_2022)
```
Ottenuti i due indici è stata sfriuttata la loro combinazione per mettere in risalto la torbidà ed avere una indicazione qualitativa sulla qualità dell'acqua: acque ricche di sedimenti mostreranno valori più elevati rispetto a quelle limpide (valori tendendi a 0).

Per andare ad isolare il sedimento nell'oggetto _plume_2022_ è stato impostato un livello soglia scelto in base al risultato di _plot(sed_2022)_: questo valore cambia da caso a caso.
``` r
# NDTI * NDWI
sed_2022 = (NDTI_2022 * NDWI_2022)
plot(sed_2022)
plume_2022 = sed_2022 < -0.1        
plot(plume_2022)
final_2022 = mask(sed_2022, plume_2022, maskvalue = T, inverse =T)
plot(final_2022)

## Confronto immagine true colours con il plume di sedimento ottenuto
im.multiframe(1, 2)
im.plotRGB(AGO_2022, r = 3, g = 2, b = 1)
plot(final_2022)
dev.off()
```
<img width="2000" height="1000" alt="Confronto_2022" src="https://github.com/user-attachments/assets/83d15147-f5a1-4f83-8667-5abd648e7eae" />
_Figura 3 - Confronto tra l'immagine satellitare e il plume ottenuto attraverso il prodotto NDTI x NDWI_

Per mettere in evidenza i sedimenti dei 4 casi, sono stati aggiunti con la funzione _add = T_ i plume alle immagini satellitari nella seguente maniera.
``` r
# Immagine satellitare con il plume messo in evidenza
im.plotRGB(AGO_2022, r = 3, g = 2, b = 1, title = "Plume sedimento Agosto 2022")
plot(final_2022, add = T, alpha = 1)
```
Il risultato per tutti i casi studio è il seguente:
<img width="3000" height="3000" alt="Plume_multiframe" src="https://github.com/user-attachments/assets/052816a0-181a-4e88-aa68-53dc7ee31546" />
_Figura 4 - Immagini satellitari con in evidenza i plume ottenuti dal prodotto NDTI x NDWI._

Per andare ad osservare come varia la torbidità è stata effetturata una classificazione dei pixel ottenuti dal calcolo del NDTI. Questa operazione ha lo scopo di ottenere una valutazione dei pixel in 4 classi di torbidità (bassa, medio-bassa, medio-alta e alta) in percentuale.

``` r
# Torbidità:
# Classifico i pixel in 4 gruppi
NDTI_2022c = im.classify(NDTI_2022, num_clusters = 4)

# rinomino le classi ottenute
NDTI_2022c = subst(NDTI_2022c, c(1,2,3,4), c("1_bassa", "2_medio-bassa", "3_medio-alta", "4_alta"))

# calcolo le percentuali
perc_2022 = freq(NDTI_2022c)$count_100/ncell(NDTI_2022c)

# Dataframe
classi = c("bassa", "medio-bassa", "medio-alta", "alta")
tabella = data.frame(
  classe = classi,
  perc_2022 = perc_2022,
  perc_A2025 = perc_A2025,
  perc_2023 = perc_2023,
  perc_N2025 = perc_N2025
)

tabella$classe <- factor(
  tabella$classe,
  levels = c("bassa", "medio-bassa", "medio-alta", "alta")
)

# Grafico
g1 = ggplot(tabella, aes(x = classe, y = perc_2022, fill = classe)) +
  geom_bar(stat = "identity") +
  ggtitle("Torbidità Agosto 2022") +
  ylab("Percentuale (%)") +
  ylim(0, 50) +
  theme(legend.position="none")
```
<img width="2000" height="2000" alt="Grafici_Torbidità" src="https://github.com/user-attachments/assets/0af3d22f-a1bb-4616-85e5-10afd44fd278" />
_Figura 5 - Istogrammi delle classi di torbidità ottenute dalla classificazione dell'indice NDTI._

Infine, per andare ad osservare come cambia la torbidità in base alla stagionalità, è stata effettuata una analisi multitemporale tra inverno ed estate 2025:
``` r
# ANALISI MULTIVARIATA INVERNO - ESTATE 2025
# differenza NDTI 
diff_2025 = NDTI_N2025 - NDTI_A2025
more_winter = diff_2025 > 0
# I valori positivi indicano una maggiore torbidità in inverno

# Esporto le immagini
png("Differenza_NDTI_2025.png", width = 2000, height = 500, res = 300)
par(oma = c(0,0,3,0))          # Aggiunge spazio sopra
im.multiframe(1, 2)
plot(diff_2025, col = plasma(100))
plot(more_winter, col = plasma(100))
mtext("Differenza NDTI inverno - estate 2025", 
      side = 3,                 # Mette il titolo sopra
      outer = TRUE,             # Nello spazio esterno
      cex = 1.5                 # Dimensione testo
)
dev.off()
```
<img width="2000" height="1000" alt="Differenza_NDTI_2025" src="https://github.com/user-attachments/assets/bb9f9918-d65f-4ce8-9b23-f456bc0c5ba1" />
_Figura 6 - Analisi multitemporale rapresentante la differenza di torbidità tra inverno ed estate 2025._

## 5 - Conclusioni
In conclusione possiamo affermare che l'analisi condotto ha permesso di evidenziare la dinamica spaziale e temporale del plume di sedimenti del Po attraverso l'ultilizzo di immagini Sentinel-2 ed indici spettrali.

Le mappe di torbidità ottenute mostrano come la distribuzione della trobidità sia fortemente variabile nel tempo e nello spazio, con una maggiore concentrazione lungo la fascia costiera.
Durante i periodi di maggiore piovosità i plume tendono ad essere molto sviluppati a causa della elevata portata fluvile che si riflette in un incremento delle classi di torbidità medio-alta.
Al contrario, per periodi estivi di bassa portata, la distribuzione delle torbidità risulta più eterogenea e maggiormente concentrata nelle classi medio-basse lungo costa.

> [!TIP]
> Aggiungere indicazioni sul meteo durante quei periodi avrebbe permesso di ottenere una valutazione migliore della correlazione diretta tra meteo e sedimento in sospensione.
>

L'analisi differenziale dell'indice NDTI tra inverno ed estate ha permesse di osservare le aree maggiormente influenzate dalle variazioni stagionali: si nota un netto incremento della torbidità alla foce del canali distributori del Po durante i mesi invernali.

## 6 - Bibliografia
- [Manzo, Ciro, et al. "Spatio-temporal analysis of prodelta dynamics by means of new satellite generation: the case of Po river by Landsat-8 data." International journal of applied earth observation and geoinformation 66 (2018): 210-225.](https://www.sciencedirect.com/science/article/pii/S0303243417302714)
- [Visualising coastal turbidity with Sentinel-2](https://knowledge.dea.ga.gov.au/notebooks/Real_world_examples/Turbidity_animated_timeseries/)
- [River Turbidity Estimation using Sentinel-2 data](https://developers.arcgis.com/python/latest/samples/river-turbidity-estimation-using-sentinel2-data-/)
