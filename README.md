# Movie-Recommendation-System
By Jad Abou Zaki, Amin Muhammad Samnani and Joshua Seyoum

This project is based on the June 2016 Project by Jekaterina Novikova, PhD.
https://rpubs.com/jeknov/movieRec


## The Analytical Problem
Step one: We need to either have the customers viewing history (Content -Based Collaborative Filtering) or get their opinion on what they liked and make some recommendations based on other customers with similar patterns of liked movies  (User-Based Collaborative Filtering). Because we do not have the viewing history of the customers using the app and we also want to easily be able to match new customers with the right movie we will use User-Based Collaborative Filtering to match users in our database with similar tastes and suggest movies liked by these parties.
Step two: Once the correct data is acquired, cleaned, and prepared we will train our recommender and test it.
Step three: Deployment. Once we have our algorithm trained and ready we will use the Shiny App to deploy a web based interface to suggest a list of movies liked by others with similar tastes, this will be done by having the customer pick three movies they enjoyed in the past.
