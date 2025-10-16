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
