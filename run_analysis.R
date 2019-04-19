# Author: Enos Sande

# Load Packages and get the Data
library(tidyr)
library(dplyr)
path<-getwd()
# url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(url, file.path(path, "dataFiles.zip"))
# unzip(zipfile = "dataFiles.zip")
assPath<-"./UCI HAR Dataset/"
setwd(assPath)

# Load activity labels and features
activityLabels<- read.table(file.path("activity_labels.txt"), col.names = c("Activity", "activity_label"))
features<-read.table(file.path("features.txt"), col.names = c("index", "featureNames"))
featuresExpected<-grep("(mean|std)\\(\\)",features[,"featureNames"])
measurements<-features[featuresExpected,"featureNames"]
measurements<-gsub('[()]', '', measurements)

# Load train datasets
train<-read.table(file.path("./train/","X_train.txt"))[, featuresExpected]
names(train)<-measurements
trainActivities<-read.table(file.path("./train/","Y_train.txt"),col.names = c("Activity"))
trainSubjects<-read.table(file.path("./train/","subject_train.txt"), col.names = c("SubjectID"))
train<-cbind(trainSubjects,trainActivities,train)
train<-tbl_df(train)

# Load test datasets
test<-read.table(file.path("./test/","X_test.txt"))[, featuresExpected]
names(test)<-measurements
testActivities<-read.table(file.path("./test/","Y_test.txt"),col.names = c("Activity"))
testSubjects<-read.table(file.path("./test/","subject_test.txt"), col.names = c("SubjectID"))
test<-cbind(testSubjects,testActivities,test)
test<-tbl_df(test)
# test<-mutate(test, dataset = "test")
# train<-mutate(train, dataset = "train")

# merge & organize datasets
merged<-bind_rows(train,test) %>% 
  merge(activityLabels, by = "Activity") %>%
  select(SubjectID, activity_label, "tBodyAcc-mean-X":"fBodyBodyGyroJerkMag-std", -Activity)

# Prepare final tidy dataset
merged<-merged %>% mutate(SubjectID = factor(SubjectID), activity_label = factor(activity_label))
merged<-reshape2::melt(data = merged, id = c("SubjectID", "activity_label"))
merged<-reshape2::dcast(data = merged, SubjectID + activity_label ~ variable, fun.aggregate = mean)
write.table(merged, file = "./UCI HAR Dataset/tidyData.txt", row.names = FALSE)
setwd(path)