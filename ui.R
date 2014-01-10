require(shiny)

shinyUI(navbarPage("College Football: by Tyler Hunt",
  tabPanel('Regular Season Rankings', 
           dataTableOutput("mytable1")),
  tabPanel('Bowl Predictions',
           dataTableOutput("mytable2"))
    )
)
        