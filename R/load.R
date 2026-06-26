library(readr)
library(dplyr)

worldcups <- read.csv("data/raw/worldcups.csv")
wcmatches <- read.csv("data/raw/wcmatches.csv")

glimpse(worldcups)
glimpse(wcmatches)

cat("worldcups:", nrow(worldcups), "filas;", ncol(worldcups), "columnas.\n")
cat("wcmatches:", nrow(wcmatches), "filas;", ncol(wcmatches), "columnas.\n")

