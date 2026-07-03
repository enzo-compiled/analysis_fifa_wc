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

p2 <- wcmatches %>%
  filter(!is.na(winning_team)) %>%
  count(winning_team, sort = TRUE) %>%
  slice_head(n = 10) %>%
  ggplot(aes(x = reorder(winning_team, n), y = n, fill = winning_team)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  labs(title = "Top 10 paises con más victorias",
       x = "Paises", y = "Victorias")
p2