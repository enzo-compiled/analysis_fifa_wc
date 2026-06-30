library(readr)
library(dplyr)
library(ggplot2)

worldcups <- readRDS("data/processed/worldcups.rds")
wcmatches <- readRDS("data/processed/wcmatches.rds")

dir.create("output/plots", recursive = TRUE, showWarnings = FALSE)

p1 <- worldcups %>%
  ggplot(aes(x = year, y = goals_per_game)) +
  geom_line() +
  geom_point() +
  labs(title = "Goles promedio por partido por Mundial",
       x = "Año", y = "Goles por partido")
ggsave("output/plots/goals_per_game.png", p1)