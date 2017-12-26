##
library(dplyr)

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

dataset.zip <- "Dataset.zip"
dataset.dir <- "UCI HAR Dataset"

dataset.features <- paste(dataset.dir, "features.txt", sep = "/")
dataset.activities <- paste(dataset.dir, "activity_labels.txt", sep = "/")

dataset.train.dir <- paste(dataset.dir, "train", sep = "/")
dataset.test.dir <- paste(dataset.dir, "test", sep = "/")

dataset.train.x <- paste(dataset.train.dir, "X_train.txt", sep = "/")
dataset.train.y <- paste(dataset.train.dir, "y_train.txt", sep = "/")
dataset.train.subject <- paste(dataset.train.dir, "subject_train.txt", sep = "/")

dataset.test.x <- paste(dataset.test.dir, "X_test.txt", sep = "/")
dataset.test.y <- paste(dataset.test.dir, "y_test.txt", sep = "/")
dataset.test.subject <- paste(dataset.test.dir, "subject_test.txt", sep = "/")

## 0. Downloads and extracts the dataset.
if (!file.exists(dataset.zip)) {
  download.file(url, dataset.zip)
}
if (!file.exists(dataset.dir)) {
  unzip(dataset.zip)
}

## 1. Merges the training and the test sets to create one data set.
features <- read.table(dataset.features)
names(features) <- c("id", "label")
activities <- read.table(dataset.activities)
names(activities) <- c("id", "label")

x <- rbind(read.table(dataset.train.x), read.table(dataset.test.x))
names(x) <- features$label
y <- rbind(read.table(dataset.train.y), read.table(dataset.test.y))
names(y) <- c("activity")
subject <- rbind(read.table(dataset.train.subject), read.table(dataset.test.subject))
names(subject) <- c("subject")

dataset <- cbind(x, y, subject)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
dataset.extracted <- cbind(x[ ,grep("std|mean", names(x))], y, subject)

## 3. Uses descriptive activity names to name the activities in the data set
dataset.extracted$activity <- activities$label[dataset.extracted$activity]

## 4. Appropriately labels the data set with descriptive variable names.
names(dataset.extracted) <- gsub("mean", "Mean", names(dataset.extracted))
names(dataset.extracted) <- gsub("std", "Std", names(dataset.extracted))
names(dataset.extracted) <- gsub("[\\(\\)-]", "", names(dataset.extracted))

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dataset.summarized <- dataset.extracted %>%
  dplyr::group_by(activity, subject) %>%
  dplyr::summarise_all(mean)

write.table(dataset.summarized, "tidy_dataset.txt", quote = FALSE)

