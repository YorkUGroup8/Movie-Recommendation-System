#install.packages("pacman")
#pacman::p_load(pacman, dplyr, GGally, ggplot2, ggthemes, data.table, reshape2, recommenderlab, arules, arulesViz,
#               ggvis, httr, lubridate, plotly, rio, rmarkdown, shiny, 
#               stringr, tidyr)
library(proxy)
library(recommenderlab)
library(reshape2)


movies <- read.csv("searchmovie_matrix.csv", header = TRUE, stringsAsFactors=FALSE)
movies <- movies[,-1] # removing first column
ratings <- read.csv("searchratings_matrix.csv", header = TRUE)
ratings <- ratings[,-1] # removing first column
#dim(movies) # check dimension
#dim(ratings) # check dimension
#length(unique(movies$movieId)) # unique movieId number in movie data set
#length(unique(ratings$movieId)) # unique movieId number in rating data set

moviesFinal <- movies[-which((movies$movieId %in% ratings$movieId) == FALSE),] # remove excess movies id from movies data sets
#length(unique(moviesFinal$movieId)) # unique movieId number in movies dataset


movie_recommendation <- function(input1,input2,input3) {
  #input1 = "Toy Story (1995)"
  #input2 = "Persuasion (1995)"
  #input3 = "Boomerang (1992)"
  row_num1 <- which(moviesFinal[,2] == input1) # assign input in variable
  row_num2 <- which(moviesFinal[,2] == input2) # assign input in variable
  row_num3 <- which(moviesFinal[,2] == input3) # assign input in variable
  
  userSelect <- matrix(NA,nrow(moviesFinal))
  userSelect[row_num1] <- 5  # hard code first selection to rating 5
  userSelect[row_num2] <- 4  # hard code second selection to rating 4
  userSelect[row_num3] <- 3  # hard code third selection to rating 3
  userSelect <- t(userSelect)
  
  ratingsmatrix <- dcast(ratings, userId~movieId, value.var = "rating", na.rm=FALSE) # transpose into userid = rows and movieId = column
 # head(ratingsmatrix[1:10]) # check matrix
  ratingsmatrix <- ratingsmatrix[,-1] # remove first column
  #head(ratingsmatrix[1:10]) # check matrix after removing first column
  #dim(ratingsmatrix) # check dimension
  colnames(userSelect) <- colnames(ratingsmatrix) # assign column name in userSelect
  
  ratingsmatrix2 <- rbind(userSelect,ratingsmatrix) # combine two row data sets
  ratingsmatrix2 <- as.matrix(ratingsmatrix2)
  #Convert rating matrix into a sparse matrix
  ratingsmatrix2 <- as(ratingsmatrix2, "realRatingMatrix")
  
  #Create Recommender Model. "IBCF" stands for user-based collaborative filtering
  recommender_model <- Recommender(data = ratingsmatrix2, method = "UBCF", parameter = list(normalize = "Z-score", method = "Cosine", nn = 30, minRating = 3))

  
  no_recommendedMovies <- 10 # max 10 movies recommend to each user
  recom <- predict(recommender_model, ratingsmatrix2[1], n = no_recommendedMovies)
  
  recom_list <- as(recom, "list")
  no_result <- data.frame(matrix(NA,1))
  
  recom_result <- data.frame(matrix(NA,10))
  if (as.character(recom_list[1])=='character(0)'){
    no_result[1,1] <- "Did not find any movies for you based on your selection. Try change the selection parameters to find your movies title you like."
    colnames(no_result) <- "No results"
    return(no_result) 
  } else {
    for (i in c(1:10)){
      recom_result[i,1] <- as.character(subset(moviesFinal, 
                                               moviesFinal$movieId == as.integer(recom_list[[1]][i]))$title)
    }
    colnames(recom_result) <- "Kickback and enjoy your recommended movies. Courtesy of Group 8 York Data Science."
    return(recom_result)
  }
}
