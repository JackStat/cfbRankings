
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
        ,tags$style("body {background-image: url('10-20-30.jpg');
                            background-size: 140%}")
#         ,tags$head(tags$style("#RankingsDT tfoot {display: table-header-group;}"))  
#         ,tags$style(type="text/css", '.navbar .brand { color: #BE0303 }')
        ,tags$style(type="text/css", '.navbar { opacity: .90 }')
        ,tags$link(
          rel = "stylesheet", 
          href="http://fonts.googleapis.com/css?family=Abel"
        )
        ,tags$style(type="text/css", "body{font-family: 'Abel', sans-serif; }")
        ,tags$style(type="text/css", ".selectize-dropdown, .selectize-input, .selectize-input input {font-family: 'Abel', sans-serif; }")
#         ,tags$style(type="text/css", 'a { color: #BE0303;}')
        ,tags$style(type="text/css", '#RankingsDT .dataTables_wrapper { font-size: 12px }')
        ,tags$style(type="text/css", '#PredictionsDT .dataTables_info {display:none;}')

        ,tagList(
          singleton(tags$head(tags$script(src='//cdnjs.cloudflare.com/ajax/libs/datatables/1.9.4/jquery.dataTables.min.js',type='text/javascript'))),
          singleton(tags$head(tags$script(src='//cdnjs.cloudflare.com/ajax/libs/datatables-tabletools/2.1.5/js/TableTools.min.js',type='text/javascript'))),
          singleton(tags$head(tags$script(src='//cdnjs.cloudflare.com/ajax/libs/datatables-tabletools/2.1.5/js/ZeroClipboard.min.js',type='text/javascript'))),
          singleton(tags$head(tags$link(href='//cdnjs.cloudflare.com/ajax/libs/datatables-tabletools/2.1.5/css/TableTools.min.css',rel='stylesheet',type='text/css'))),
          singleton(tags$script(HTML("if (window.innerHeight < 400) alert('Screen too small');")))
        )

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
             ,HTML("<a href = 'https://www.flickr.com/photos/giophotos/'> <small> Background by Giovanni Arteaga. </small></a>")
             ,style = "background-color: #FFFFFF; opacity: .9;"
             )
           )
         ,column(
           10
           ,wellPanel(
             dataTableOutput("RankingsDT")
             ,style = "background-color: #FFFFFF; opacity: .9;"
             ,br()
            )
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
             ,HTML("<a href = 'https://www.flickr.com/photos/giophotos/'> <small> Background by Giovanni Arteaga. </small></a>")
             ,style = "background-color: #FFFFFF; opacity: .9;"
            )
           )
         ,column(
           9
           ,tags$style(type="text/css", '#PredictionsDT .dataTables_wrapper { font-size: 12px }')
           ,tags$style(type="text/css", '#PredictionsDT tfoot {display:none;}')           
           ,wellPanel(dataTableOutput("PredictionsDT")
                      ,style = "background-color: #FFFFFF; opacity: .9;")
           
          )
        )
      )
    )
  )


