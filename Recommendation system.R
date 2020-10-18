#Recommendation Systems
#Problem statement: Recommend a best book based on the author,publisher & ratings.


install.packages("readr")
install.packages("recommenderlab", dependencies=TRUE)
install.packages("Matrix")
library("recommenderlab")
library(caTools)
library(readr)

#Importing Data Set
book_text <- read.table("C://Users//Lenovo//Desktop//ExcelR//Assignments//Completed//Unchecked//Recommendation Systems//book.txt",header = TRUE,sep = ",")
View(book_text)

class(book_text)
summary(book_text)
var(book_text)
sd(book_text$Book.Rating)
range(book_text$Book.Rating)
install.packages("moments")
library(moments)
skewness(book_text$Book.Rating)
kurtosis(book_text$Book.Rating)
sum(is.na(book_text))
attach(book_text)

#metadata about the variable
str(book_text)
table(book_text$Book.Title)

#Rating distribution
hist(book_text$Book.Rating)
barplot(Book.Rating)
boxplot(Book.Rating)
book<-book_text[-1]
View(book)

#The datatype should be realRatingMatrix in order to build recommendation engine
book_matrix <- as(book, 'realRatingMatrix')
View(book_matrix)

#Popularity based 
book_recomm_model1 <- Recommender(book_matrix, method="POPULAR")

#Predictions for two users 
recommended_items1 <- predict(book_recomm_model1, book_matrix[513:514], n=5)
as(recommended_items1, "list")

## Popularity model recommends the same books for all users , we need to improve our model
#Using Collaborative Filtering
#Item Based Collaborative Filtering
book_recomm_model2 <- Recommender(book_matrix, method="IBCF")

#Predictions for Users 
recommended_items2 <- predict(book_recomm_model2, book_matrix, n=3)
as(recommended_items2, "list")

#User Based Collaborative Filtering
book_recomm_model3 <- Recommender(book_matrix, method="UBCF")

#Predictions for two users 
recommended_items3 <- predict(book_recomm_model3, book_matrix[513:514], n=3)
as(recommended_items2, "list")