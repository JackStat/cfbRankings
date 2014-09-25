library(dplyr)
library(googleVis)

load("Data/AllRankings.RData", .GlobalEnv)
load("Data/Predictions.RData", .GlobalEnv)


Predictions <-
  Predictions %>%
  mutate(
    Team = as.character(Team)
    ,OppMargin = round(OppMargin, 2)
    ,Prediction = paste0(100*round(Prediction, 4), " %")
  ) %>% 
  arrange(Team)

AllRankings <-
  AllRankings %>%
  mutate(
    YearWeek = paste0(Year, " Week-", Week)
    ,Rating = round(Rating, 2)
    ,Margin = round(Margin, 2)
    ,WinPotential = round(WinPotential, 2)
    ,Elo = round(Elo, 2)
  )
