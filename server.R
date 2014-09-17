
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#


library(shiny)


shinyServer(function(input, output) {
  
  
  output$yearFilter <- renderUI({

  })
    
  
  output$RankingsDT <- renderDataTable({
    
    subset(AllRankings, YearWeek == input$filterSelect)[,-c(10:12)]

  })
  
  
  
  Preds <- reactive({
    
    subset(Predictions, Team == input$filterSelect2)
    
  })
  
  output$PredictionsDT <- renderDataTable({
        
    Preds()
        
  }, options=list(
    bSortClasses = TRUE
    ,bPaginate = FALSE
    ,bFilter = FALSE
    )
  )  
  
})
