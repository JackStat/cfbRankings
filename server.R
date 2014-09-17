
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


library(shiny)
library(dplyr)
load("Data/AllRankings.RData")
load("Data/Predictions.RData")

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
  
  


shinyServer(function(input, output) {
  
  
  output$yearFilter <- renderUI({
    selectizeInput(inputId = 'filterSelect'
                   , label = 'Year'
                   , choices = unique(AllRankings$YearWeek)
                   , selected = max(AllRankings$YearWeek)
                   , multiple=FALSE
                   , width = '100%')
  })
    
  
  output$RankingsDT <- renderDataTable({
    
    subset(AllRankings, YearWeek == input$filterSelect)[,-c(10:12)]

  })
  
  output$teamFilter <- renderUI({
    selectInput(inputId = 'filterSelect2'
                   , label = 'Team'
                   , choices = unique(Predictions$Team)
                   , selected = sample(Predictions$Team,1)
                   , multiple=FALSE
                   , width = '100%')
  })
  
  
  output$PredictionsDT <- renderDataTable({
    
    subset(Predictions, Team == input$filterSelect2)
    
  })
  
  
  
  
})
