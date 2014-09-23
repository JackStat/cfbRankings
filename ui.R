
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(
  navbarPage(
    "Tyler Hunt's College Football Rankings"
    ,header = list("opacity: .9")
#     ,theme='bootstrap.css'
      ,tabPanel(
        "Rankings"
        ,tags$style("body {background-image: url('10-20-30.jpg');}")
#         ,tags$head(tags$style("#RankingsDT tfoot {display: table-header-group;}"))  
#         ,tags$style(type="text/css", '.navbar .brand { color: #BE0303 }')
        ,tags$style(type="text/css", '.navbar { opacity: .90 }')
        ,HTML("<link href='http://fonts.googleapis.com/css?family=Abel' rel='stylesheet' type='text/css'>")
        ,tags$style(type="text/css", "body {font-family: 'Abel', sans-serif; }")
        ,tags$style(type="text/css", ".selectize-dropdown, .selectize-input, .selectize-input input {font-family: 'Abel', sans-serif; }")
        ,tags$style(type="text/css", 'a { color: #BE0303;}')
        ,tags$style(type="text/css", '#RankingsDT .dataTables_wrapper { font-size: 12px }')
        ,tags$style(type="text/css", '#PredictionsDT .dataTables_info {display:none;}')

        ,tags$head(includeScript("google-analytics.js"))
       
        ,fluidPage(
         column(
           3
           ,wellPanel(
             h5('Updated as of September 20, 2014')
             ,selectizeInput(inputId = 'filterSelect'
                            , label = 'Year'
                            , choices = unique(AllRankings$YearWeek)
                            , selected = max(AllRankings$YearWeek)
                            , multiple=FALSE
                            , width = '100%')
             ,br()
             ,HTML("<p> Photograph by Giovanni Arteaga. </p>")
             ,style = "background-color: #FFFfff; opacity: .9;"
             )
           )
         ,column(
           10
           ,wellPanel(dataTableOutput("RankingsDT")
                      ,style = "background-color: #FFFfff; opacity: .9;")
          )
        )
      )
     ,tabPanel(
       "Predictions"
       ,fluidPage(
         column(
           3
           ,wellPanel(
             h5('Updated as of September 20, 2014')
             ,selectInput(inputId = 'filterSelect2'
                         , label = 'Team'
                         , choices = unique(Predictions$Team)
                         , selected = sample(Predictions$Team,1)
                         , multiple=FALSE
                         , width = '100%')
             ,br()
             ,HTML("<p> Photograph by Giovanni Arteaga. </p>")
             ,style = "background-color: #FFFfff; opacity: .9;"
            )
           )
         ,column(
           9
           ,tags$style(type="text/css", '#PredictionsDT .dataTables_wrapper { font-size: 12px }')
           ,tags$style(type="text/css", '#PredictionsDT tfoot {display:none;}')
           ,wellPanel(dataTableOutput("PredictionsDT")
                      ,style = "background-color: #FFFfff; opacity: .9;")
           
          )
        )
      )
    )
  )
