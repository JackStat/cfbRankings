require(shiny)
require(plyr)

shinyServer(function(input, output) {

  # a large table, reative to input$show_vars
  output$mytable1 = renderDataTable({
    read.csv("Data/RegularSeasRank.csv") 
  }, options = list(bCaseInsensitive=TRUE))

  # sorted columns are colored now because CSS are attached to them
  output$mytable2 = renderDataTable({
    read.csv("Data/Bowl2013Predictions.csv")
  }, options = list(aLengthMenu = c(10, 25, 50, 100), iDisplayLength = 100, bCaseInsensitive=TRUE))

})
