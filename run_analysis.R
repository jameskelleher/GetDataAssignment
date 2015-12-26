library(plyr)
library(dplyr)

if (!file.exists("UCI HAR Dataset/")) {
  fileUrl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  temp = tempfile()
  download.file(fileUrl, temp)
  unzip(temp)
  unlink(temp)
}

activity_labels = read.table("UCI HAR Dataset/activity_labels.txt")[,2]
features        = read.table("UCI HAR Dataset/features.txt")[,2]
subject_test    = read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
dataset_test    = read.table("UCI HAR Dataset/test/X_test.txt", col.names = features)
activity_test   = read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Activity")
subject_train   = read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
dataset_train   = read.table("UCI HAR Dataset/train/X_train.txt", col.names = features)
activity_train  = read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Activity")

mean_and_std_features = which(grepl("(mean\\(\\)|std\\(\\))", features))

subject = rbind(subject_train, subject_test)
activity = rbind(activity_train, activity_test)
isTrain = c(rep(TRUE, nrow(dataset_train)), rep(FALSE, nrow(dataset_test)))
dataset = rbind(dataset_train, dataset_test)

dataset = dataset[,mean_and_std_features]

colnames(dataset)  = gsub("\\.\\.","",names(dataset))

result = cbind(subject, activity, isTrain, dataset)

result$Subject = factor(result$Subject)
result$Activity = activity_labels[result$Activity]

result_summary = ddply(result, .(Subject, Activity), numcolwise(mean))

write.table(result_summary, "result_summary.txt", row.names = FALSE)
