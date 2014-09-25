
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

  }, options = list(
    "sDom" = 'T<"clear">lfrtip',
    "oTableTools" = list(
      "sSwfPath" = "//cdnjs.cloudflare.com/ajax/libs/datatables-tabletools/2.1.5/swf/copy_csv_xls.swf",
      "aButtons" = list(
        "copy",
        "print",
        list("sExtends" = "collection",
             "sButtonText" = "Save",
             "aButtons" = c("csv","xls")
        )
      )
    )
  )
  )
  
  
  
  Preds <- reactive({
    
    subset(Predictions, Team == input$filterSelect2)
    
  })
  
  output$PredictionsDT <- renderDataTable({
        
    Preds()
        
  }, options = list(
    bPaginate = FALSE
    ,bFilter = FALSE
    ,"sDom" = 'T<"clear">lfrtip'
    ,"oTableTools" = list(
      "sSwfPath" = "//cdnjs.cloudflare.com/ajax/libs/datatables-tabletools/2.1.5/swf/copy_csv_xls.swf"
      ,"aButtons" = list(
        "copy"
        ,"print"
        ,list("sExtends" = "collection"
             ,"sButtonText" = "Save"
             ,"aButtons" = c("csv","xls")
          )
        )
      )
    )
  )
  
  
  
})
