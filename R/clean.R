library(dplyr)
library(tidyverse)

worldcups <- read.csv("data/raw/worldcups.csv")
wcmatches <- read.csv("data/raw/wcmatches.csv")

head(worldcups)

worldcups <- worldcups %>% mutate(
  goals_per_game = goals_scored / games,
  attendance_per_game = attendance / games
)

#wcmatches[wcmatches$outcome == "D", ]

wcmatches <- wcmatches %>% mutate(
  goals_per_match = home_score + away_score,
  empate = outcome == "D"
)

saveRDS(worldcups, "data/processed/worldcups.rds")
saveRDS(wcmatches, "data/processed/wcmatches.rds")