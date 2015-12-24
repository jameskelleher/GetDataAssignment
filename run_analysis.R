library(plyr)
library(dplyr)

if (!file.exists("UCI HAR Dataset/")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  temp = tempfile()
  download.file(fileUrl, temp)
  unzip(temp)
  unlink(temp)
}

setwd("UCI HAR Dataset/")

activity_labels = read.table("activity_labels.txt")[,2]
features        = read.table("features.txt")[,2]
subject_test    = read.table("test/subject_test.txt", col.names = "Subject")
dataset_test    = read.table("test/X_test.txt", col.names = features)
activity_test   = read.table("test/y_test.txt", col.names = "Activity")
subject_train   = read.table("train/subject_train.txt", col.names = "Subject")
dataset_train   = read.table("train/X_train.txt", col.names = features)
activity_train  = read.table("train/y_train.txt", col.names = "Activity")

setwd("..")

mean_and_std_features = which(grepl("^t(Body|Gravity)(Acc|Gyro)(Mag)?-(mean\\(\\)|std\\(\\))", features))

dataset_test  = dataset_test[,mean_and_std_features]
dataset_train = dataset_train[,mean_and_std_features]

colnames(dataset_test)  = gsub("(^t|\\.\\.)","",names(dataset_test))
colnames(dataset_train) = gsub("(^t|\\.\\.)","",names(dataset_train))

test = cbind(subject_test, activity_test, isTrain = rep(FALSE, nrow(dataset_test)), dataset_test)
train = cbind(subject_train, activity_train, isTrain = rep(TRUE, nrow(dataset_train)), dataset_train)

result = rbind(train, test)

result$Subject = factor(result$Subject)
result$Activity = activity_labels[result$Activity]

result_summary = ddply(result, .(Subject, Activity), numcolwise(mean))
