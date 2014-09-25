
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
  
  
  HomeAdv <- reactive({
    TrainGames <-
      AllGames %>%
      left_join(meta %>% 
                  select(
                    Team=cfbwarehouseName
                    ,subdivision)
                , by="Team") %>%
      # - Just keeping last since 1996 (no ties after this year)
      filter(Year >= 1996 & subdivision == 'FBS') %>%
      # - Season starter games are a thing of the past no need to include
      filter(!Notes %in% c("Pigskin Classic", "Kickoff Classic")) %>%
      mutate(
        Win = as.numeric(PF > PA)
        ,Margin = PF-PA
        ,WeekDay = wday(Date)
        ,OppYear = as.factor(paste0(Opponent, Year))
      ) %>%
      group_by(Team, Year) %>%
      mutate(Week=1:length(Team)) %>%
      # - Year limit for rankings
      filter(Year %in% c(input$sliderYear[1]:input$sliderYear[2])) %>%
      arrange(Date) 
    
    TrainGames$Home<-as.factor(TrainGames$Home)
    
    ### - Margin - ###
    m <- lmer(Margin ~
                (1 | Home/Team) + 
                (1 | Opponent)
              , data = TrainGames
              #           , REML = FALSE
    )
    
    Team2 <- data.frame(
      Team = rownames(ranef(m)$`Team:Home`)
      ,Margin = ranef(m)$`Team:Home`[,1]
      ,stringsAsFactors=FALSE)
    
    TeamSplit<-data.frame(do.call(rbind, strsplit(Team2$Team, ":")))
    colnames(TeamSplit)=c("Team", "Home")
    
    levels(TeamSplit$Home)<- c("Away", "Home")
    
    
    Team <- cbind(TeamSplit, Margin=Team2$Margin) %>%
      arrange(desc(Margin)) %>%
      spread(Home, Margin) %>%
      mutate(
        Margin = Home - Away 
        ,Home = round(Home, 2)
        ,Away = round(Away, 2)
        ,Margin = round(Margin, 2)
      ) %>%
      select(
        Team
        ,Home
        ,Away
        ,Margin) %>%
      arrange(desc(Margin)) %>%
      na.omit()
    
    Team
  })
  
  
  output$HomeAdvDT <- renderDataTable({
    
    HomeAdv()
    
  }, options = list(
    "sDom" = 'T<"clear">lfrtip'
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
