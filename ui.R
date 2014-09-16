
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(navbarPage("Tyler Hunt's College Football Rankings"
  ,tabPanel("Rankings"
            ,tags$head(tags$style("tfoot {display: table-header-group;}"))            
            ,wellPanel(uiOutput(outputId = "yearFilter"))
              ,dataTableOutput("RankingsDT")
  )
))
