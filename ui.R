
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
       ,tags$style(type="text/css", '#RankingsDT .dataTables_wrapper { font-size: 12px }')
       ,tags$head(includeScript("google-analytics.js"))
       
       ,fluidPage(
         column(
           3
           ,br()
           ,br()
           ,br()
           ,wellPanel(
             selectizeInput(inputId = 'filterSelect'
                            , label = 'Year'
                            , choices = unique(AllRankings$YearWeek)
                            , selected = max(AllRankings$YearWeek)
                            , multiple=FALSE
                            , width = '100%')
             )
           )
         ,column(
           9
           ,dataTableOutput("RankingsDT")
          )
        )
      )
     ,tabPanel(
       "Predictions"
       ,fluidPage(
         column(
           3
           ,br()
           ,br()
           ,br()
           ,wellPanel(
             selectInput(inputId = 'filterSelect2'
                         , label = 'Team'
                         , choices = unique(Predictions$Team)
                         , selected = sample(Predictions$Team,1)
                         , multiple=FALSE
                         , width = '100%')
            )
           )
         ,column(
           9
           ,tags$style(type="text/css", '#PredictionsDT .dataTables_wrapper { font-size: 12px }')
           ,tags$style(type="text/css", '#PredictionsDT tfoot {display:none;}')
           ,dataTableOutput("PredictionsDT")
          )
        )
      )
    )
  )
