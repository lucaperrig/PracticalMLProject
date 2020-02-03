setwd("/Users/lucaperrig/switchdrive/Divers/Cours/DataScience/DataScienceR-JH/8-Practical ML/WeekProject")

library(caret)
library(rattle)
library(randomForest)

#Load
training <- read.csv("pml-training.csv", na.strings = c("NA", ""))
testing <- read.csv("pml-testing.csv", na.strings = c("NA", ""))

#Clean
training <- training[, colSums(is.na(training)) == 0]
testing <- testing[, colSums(is.na(testing)) == 0]

training <- training[-grep("^X$|user_name|timestamp|window", names(training))]
testing <- testing[-grep("^X$|user_name|timestamp|window", names(testing))]

#Split
inTrain <- createDataPartition(training$classe, p=0.70, list=F)
trainData <- training[inTrain, ]
testData <- training[-inTrain, ]

#Train
control <- trainControl(method="cv", 5)
model <- train(classe ~ ., data=trainData, method="rf", trControl=control, ntree=250)
model
