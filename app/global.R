library(rgdal)
library(maptools)
library(leaflet)
library(dplyr)
library(magrittr)
library(ggplot2)
library(scales)
library(geojsonio)
options(scipen = 15)

useCache = TRUE
# Read stations position and keep only metropolitan French ones
spStations <- geojson_read("../data/geo/meteo.geojson", what = "sp")
spStations@data <- spStations@data[1:42,]
spStations@coords <- spStations@coords[1:42,]

dfStations <- spStations@data %>% 
  mutate(ID = as.numeric(as.character(ID))) %>% 
  rename(numer_sta = ID)

dfStations$Nom <- as.character(dfStations$Nom)

# Read and prepare meteo data
source("../prepare_meteo_data.R")
if (useCache & file.exists("init.Rdata")) load("init.RData") else {
  dfMeteo <- prepare_meteo_data(list.files("../data/meteo/", full.names = TRUE))
  
  dfTemperature <- dfMeteo %>% 
    group_by(Nom, date) %>% 
    summarise(temp = mean(as.numeric(t), na.rm = TRUE) - 273.15)
  
  dfMeanTemp <- dfTemperature %>% 
    group_by(Nom) %>% 
    summarise(mean_temp = mean(temp, na.rm = TRUE)) %>% 
    arrange(-mean_temp) 
    
  
  
  # Palettes
  pal = colorNumeric("RdYlBu", dfMeanTemp$mt)
  
  # Update dfStations
  spStations@data %<>% 
    inner_join(dfMeanTemp)
  save.image("init.RData")
}






