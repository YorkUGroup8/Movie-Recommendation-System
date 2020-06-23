#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(proxy)
library(recommenderlab)
library(reshape2)
source("Modelalgorithm.R")

search <- read.csv("searchmovie_matrix.csv", header = TRUE, stringsAsFactors=FALSE)
ratings <- read.csv("searchratings_matrix.csv", header = TRUE)
search <- search[-which((search$movieId %in% ratings$movieId) == FALSE),]


shinyServer(function(input, output) {
    
    output$ui1 <- renderUI({
        if (is.null(input$input_genres1))
            return()
        
        switch(input$input_genres1,
               "Action" = selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                      choices = sort(subset(search, Action == 1)$title),
                                      selected = sort(subset(search, Action == 1)$title)[1]),
               "Adventure" = selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                         choices = sort(subset(search, Adventure == 1)$title),
                                         selected = sort(subset(search, Adventure == 1)$title)[1]),
               "Animation" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                          choices = sort(subset(search, Animation == 1)$title),
                                          selected = sort(subset(search, Animation == 1)$title)[1]),
               "Children" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                         choices = sort(subset(search, Children == 1)$title),
                                         selected = sort(subset(search, Children == 1)$title)[1]),
               "Comedy" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                       choices = sort(subset(search, Comedy == 1)$title),
                                       selected = sort(subset(search, Comedy == 1)$title)[1]),
               "Crime" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                      choices = sort(subset(search, Crime == 1)$title),
                                      selected = sort(subset(search, Crime == 1)$title)[1]),
               "Documentary" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                            choices = sort(subset(search, Documentary == 1)$title),
                                            selected = sort(subset(search, Documentary == 1)$title)[1]),
               "Drama" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                      choices = sort(subset(search, Drama == 1)$title),
                                      selected = sort(subset(search, Drama == 1)$title)[1]),
               "Fantasy" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                        choices = sort(subset(search, Fantasy == 1)$title),
                                        selected = sort(subset(search, Fantasy == 1)$title)[1]),
               "Film.Noir" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                          choices = sort(subset(search, Film.Noir == 1)$title),
                                          selected = sort(subset(search, Film.Noir == 1)$title)[1]),
               "Horror" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                       choices = sort(subset(search, Horror == 1)$title),
                                       selected = sort(subset(search, Horror == 1)$title)[1]),
               "Musical" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                        choices = sort(subset(search, Musical == 1)$title),
                                        selected = sort(subset(search, Musical == 1)$title)[1]),
               "Mystery" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                        choices = sort(subset(search, Mystery == 1)$title),
                                        selected = sort(subset(search, Mystery == 1)$title)[1]),
               "Romance" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                        choices = sort(subset(search, Romance == 1)$title),
                                        selected = sort(subset(search, Romance == 1)$title)[1]),
               "Sci.Fi" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                       choices = sort(subset(search, Sci.Fi == 1)$title),
                                       selected = sort(subset(search, Sci.Fi == 1)$title)[1]),
               "Thriller" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                         choices = sort(subset(search, Thriller == 1)$title),
                                         selected = sort(subset(search, Thriller == 1)$title)[1]),
               "War" =  selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                    choices = sort(subset(search, War == 1)$title),
                                    selected = sort(subset(search, War == 1)$title)[1]),
               "Western" = selectInput("select1", "Movie Title of Priority # 1 (Genre List)",
                                       choices = sort(subset(search, Western == 1)$title),
                                       selected = sort(subset(search, Western == 1)$title)[1])
        )
    })
    
    output$ui2 <- renderUI({
        if (is.null(input$input_genres2))
            return()
        
        switch(input$input_genres2,
               "Action" = selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                      choices = sort(subset(search, Action == 1)$title),
                                      selected = sort(subset(search, Action == 1)$title)[1]),
               "Adventure" = selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                         choices = sort(subset(search, Adventure == 1)$title),
                                         selected = sort(subset(search, Adventure == 1)$title)[1]),
               "Animation" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                          choices = sort(subset(search, Animation == 1)$title),
                                          selected = sort(subset(search, Animation == 1)$title)[1]),
               "Children" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                         choices = sort(subset(search, Children == 1)$title),
                                         selected = sort(subset(search, Children == 1)$title)[1]),
               "Comedy" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                       choices = sort(subset(search, Comedy == 1)$title),
                                       selected = sort(subset(search, Comedy == 1)$title)[1]),
               "Crime" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                      choices = sort(subset(search, Crime == 1)$title),
                                      selected = sort(subset(search, Crime == 1)$title)[1]),
               "Documentary" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                            choices = sort(subset(search, Documentary == 1)$title),
                                            selected = sort(subset(search, Documentary == 1)$title)[1]),
               "Drama" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                      choices = sort(subset(search, Drama == 1)$title),
                                      selected = sort(subset(search, Drama == 1)$title)[1]),
               "Fantasy" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                        choices = sort(subset(search, Fantasy == 1)$title),
                                        selected = sort(subset(search, Fantasy == 1)$title)[1]),
               "Film.Noir" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                          choices = sort(subset(search, Film.Noir == 1)$title),
                                          selected = sort(subset(search, Film.Noir == 1)$title)[1]),
               "Horror" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                       choices = sort(subset(search, Horror == 1)$title),
                                       selected = sort(subset(search, Horror == 1)$title)[1]),
               "Musical" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                        choices = sort(subset(search, Musical == 1)$title),
                                        selected = sort(subset(search, Musical == 1)$title)[1]),
               "Mystery" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                        choices = sort(subset(search, Mystery == 1)$title),
                                        selected = sort(subset(search, Mystery == 1)$title)[1]),
               "Romance" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                        choices = sort(subset(search, Romance == 1)$title),
                                        selected = sort(subset(search, Romance == 1)$title)[1]),
               "Sci.Fi" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                       choices = sort(subset(search, Sci.Fi == 1)$title),
                                       selected = sort(subset(search, Sci.Fi == 1)$title)[1]),
               "Thriller" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                         choices = sort(subset(search, Thriller == 1)$title),
                                         selected = sort(subset(search, Thriller == 1)$title)[1]),
               "War" =  selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                    choices = sort(subset(search, War == 1)$title),
                                    selected = sort(subset(search, War == 1)$title)[1]),
               "Western" = selectInput("select2", "Movie Title of Priority # 2 (Genre List)",
                                       choices = sort(subset(search, Western == 1)$title),
                                       selected = sort(subset(search, Western == 1)$title)[1])
        )
    })
    
    output$ui3 <- renderUI({
        if (is.null(input$input_genres3))
            return()
        
        switch(input$input_genres3,
               "Action" = selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                      choices = sort(subset(search, Action == 1)$title),
                                      selected = sort(subset(search, Action == 1)$title)[1]),
               "Adventure" = selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                         choices = sort(subset(search, Adventure == 1)$title),
                                         selected = sort(subset(search, Adventure == 1)$title)[1]),
               "Animation" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                          choices = sort(subset(search, Animation == 1)$title),
                                          selected = sort(subset(search, Animation == 1)$title)[1]),
               "Children" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                         choices = sort(subset(search, Children == 1)$title),
                                         selected = sort(subset(search, Children == 1)$title)[1]),
               "Comedy" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                       choices = sort(subset(search, Comedy == 1)$title),
                                       selected = sort(subset(search, Comedy == 1)$title)[1]),
               "Crime" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                      choices = sort(subset(search, Crime == 1)$title),
                                      selected = sort(subset(search, Crime == 1)$title)[1]),
               "Documentary" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                            choices = sort(subset(search, Documentary == 1)$title),
                                            selected = sort(subset(search, Documentary == 1)$title)[1]),
               "Drama" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                      choices = sort(subset(search, Drama == 1)$title),
                                      selected = sort(subset(search, Drama == 1)$title)[1]),
               "Fantasy" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                        choices = sort(subset(search, Fantasy == 1)$title),
                                        selected = sort(subset(search, Fantasy == 1)$title)[1]),
               "Film.Noir" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                          choices = sort(subset(search, Film.Noir == 1)$title),
                                          selected = sort(subset(search, Film.Noir == 1)$title)[1]),
               "Horror" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                       choices = sort(subset(search, Horror == 1)$title),
                                       selected = sort(subset(search, Horror == 1)$title)[1]),
               "Musical" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                        choices = sort(subset(search, Musical == 1)$title),
                                        selected = sort(subset(search, Musical == 1)$title)[1]),
               "Mystery" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                        choices = sort(subset(search, Mystery == 1)$title),
                                        selected = sort(subset(search, Mystery == 1)$title)[1]),
               "Romance" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                        choices = sort(subset(search, Romance == 1)$title),
                                        selected = sort(subset(search, Romance == 1)$title)[1]),
               "Sci.Fi" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                       choices = sort(subset(search, Sci.Fi == 1)$title),
                                       selected = sort(subset(search, Sci.Fi == 1)$title)[1]),
               "Thriller" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                         choices = sort(subset(search, Thriller == 1)$title),
                                         selected = sort(subset(search, Thriller == 1)$title)[1]),
               "War" =  selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                    choices = sort(subset(search, War == 1)$title),
                                    selected = sort(subset(search, War == 1)$title)[1]),
               "Western" = selectInput("select3", "Movie Title of Priority # 3 (Genre List)",
                                       choices = sort(subset(search, Western == 1)$title),
                                       selected = sort(subset(search, Western == 1)$title)[1])
        )
    })
    
    output$table <- renderTable({
        movie_recommendation(input$select1, input$select2, input$select3)
    })
})