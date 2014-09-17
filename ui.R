
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(
  navbarPage("Tyler Hunt's College Football Rankings"
     ,tabPanel(
       "Rankings"
       ,tags$head(tags$style("#RankingsDT tfoot {display: table-header-group;}"))  
       ,tags$head(includeScript("google-analytics.js"))
       ,wellPanel(uiOutput(outputId = "yearFilter"))
       ,dataTableOutput("RankingsDT")
      )
     ,tabPanel(
       "Predictions"
       ,tags$style(type="text/css", '#PredictionsDT tfoot {display:none;}')
       ,wellPanel(uiOutput(outputId = "teamFilter"))
       ,dataTableOutput("PredictionsDT")
      )
    )
  )
