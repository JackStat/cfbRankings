
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


library(shiny)
load("Data/AllRankings.RData")

AllRankings$YearWeek <- paste0(AllRankings$Year, " Week-", AllRankings$Week)


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
  
})
