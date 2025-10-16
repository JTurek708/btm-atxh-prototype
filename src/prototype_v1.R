### Behind the Markers - Prototype Map
### October 2025
### Jack Turek

# Install Packages
library(tidyverse)
library(leaflet)
library(leaflet.extras)
library(sp)
library(sf)

# Convert UTM to Lat/Long
bexar_historical_markers <- bexar_historical_markers %>%
  filter(!is.na(Utm_East) & !is.na(Utm_North))
bexar_historical_markers <- bexar_historical_markers %>%
  mutate(Utm_East = as.numeric(Utm_East),
         Utm_North = as.numeric(Utm_North),
         Utm_Zone = as.numeric(Utm_Zone))
utm_crs <- 32614
bexar_sf <- st_as_sf(
  bexar_historical_markers,
  coords = c("Utm_East", "Utm_North"),
  crs = utm_crs,
  remove = FALSE
)
bexar_latlong <- st_transform(bexar_sf, 4326)
coords <- st_coordinates(bexar_latlong)
bexar_latlong <- bexar_latlong %>%
  mutate(Long = coords[,1], Lat = coords[,2])
View(bexar_latlong)

# Quick map plot
leaflet(bexar_latlong) %>%
  addTiles() %>%
  addCircleMarkers(~Long, ~Lat, radius = 6, stroke=FALSE, fillOpacity = 0.7)
