library(dplyr)
# library(googleVis)
# library(lubridate)
# library(lme4)
# library(tidyr)

# load("Data/AllGames.RData", .GlobalEnv)
load("Data/AllRankings.RData")
load("Data/Predictions.RData")
# meta<-read.csv("Data/TeamMeta.csv")


Predictions <-
  Predictions %>%
  mutate(
    Team = as.character(Team)
    ,OppMargin = round(OppMargin, 2)
    ,Prediction = paste0(100*round(Prediction, 4), " %")
  ) %>% 
  arrange(Team) %>%
  select(
    Team
    ,Opponent
    ,Date
    ,Week
    ,Prediction
#     ,OppMargin
    )

AllRankings <-
  AllRankings %>%
  mutate(
    YearWeek = paste0(Year, " Week-", Week)
    ,Rating = round(Rating, 2)
    ,Margin = round(Margin, 2)
    ,WinPotential = round(WinPotential, 2)
    ,Elo = round(Elo, 2)
  )
