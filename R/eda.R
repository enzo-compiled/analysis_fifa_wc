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
ggsave("output/plots/top_winners_games.png", p2)

p3 <- worldcups %>%
  count(winner, sort = TRUE) %>%
  ggplot(aes(x = reorder(winner, n), y = n, fill = winner)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  labs(title = "Países con más mundiales",
       x = "País", y = "Títulos")
ggsave("output/plots/top_winners_final.png", p3)

p4 <- wcmatches %>%
  mutate(
    team1 = if_else(home_team < away_team, home_team, away_team),
    team2 = if_else(home_team < away_team, away_team, home_team)
  ) %>%
  count(team1, team2, sort = TRUE) %>%
  slice_head(n = 5) %>%
  mutate(rivales = paste(team1, "vs", team2)) %>%
  ggplot(aes(x = reorder(rivalry, n), y = n, fill = rivales)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  geom_text(aes(label = n), hjust = -0.2) +
  labs(title = "Top 5 rivalidades",
       x = "", y = "Partidos") + 
  theme(plot.title = element_text(hjust = 0))
ggsave("output/plots/top_rivales.png", p4)