# Getting and Cleaning Data Course Project
This repository contains the following files.
- `README.md` explains the analysis files.
- `CodeBook.md` describes the variables, the values, and any transformations.
- `run_analysis.R` is an R script that generates a tidy dataset according to the following procedure.
- `tidy_dataset.txt` is generated last.

## 0. Downloads and extracts the dataset.
The original dataset is downloaded from the following url.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## 1. Merges the training and the test sets to create one data set.
Each data set are binded as follows.

|some features... | activity | subject |
| --- | --- | --- |
|X_train.txt | y_train.txt | subject_train.txt |
|X_test.txt | y_test.txt | subject_test.txt |

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
Adopts the measurements containing `mean` and `std` as the name from the original `features.txt`.

## 3. Uses descriptive activity names to name the activities in the data set
Adopts the activeity names from the original `activity_labels.txt`.

## 4. Appropriately labels the data set with descriptive variable names.
Converts the names of the original `features.txt` as follows.
- Converts the first letter of words to uppercase (ex. "mean" -> "Mean", "std" -> "Std").
- Deletes special characters (ex. "(", ")", "-").

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Groups by `activity` and `subject` and calculates the averages by mean(), and writes the result to a file (`tidy_dataset.txt`).
