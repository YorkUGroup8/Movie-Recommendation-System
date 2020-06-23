#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


genre_Picklist <- c("Adventure", "Animation", "Children", "Comedy", "Fantasy", "Romance",
                    "Drama", "Thriller", "Action", "Crime", "Documentary", "Film-Noir",
                    "Horror", "Musical", "Mystery", "Sci-Fi", "War", "Western") # total 18 genres

shinyUI(fluidPage(
    titlePanel("Welcome to Group 8 (Movie Recommender)"),
    fluidRow(
        
        column(4, h3("Pick genres of your favourite movie's"),
                  h4("(list help narrow your movies)"),
               wellPanel(
                   selectInput("input_genres1", "Priority # 1 (Genre List)", genre_Picklist),
                   selectInput("input_genres2", "Priority # 2 (Genre List)", genre_Picklist),
                   selectInput("input_genres3", "Priority # 3 (Genre List)", genre_Picklist)
                        )
               ),
        
        column(3, h3("Pick your favourite movie title"),
                  h5("     ."),
               wellPanel(
                   # This outputs the dynamic UI component
                   uiOutput("ui1"),
                   uiOutput("ui2"),
                   uiOutput("ui3")
                        )
               ),
        
        column(4, h3("Well done! Here are your recommended movies"),
               tableOutput("table")
                )
        ) ,
    
    fluidRow(
        column(12,
               helpText("Credit: Code used on this app was acquired from the original project by  Jekaterina Novikova, PhD (Building a Movie Recommendation System)., please visit the link",
                        a("the link", href="https://rpubs.com/jeknov/movieRec", target="_blank")
                        ),
               helpText("For GitHub, please visit the link",
                        a("the link", href = "", target="_blank")
                        )
            )
        )
  )
)