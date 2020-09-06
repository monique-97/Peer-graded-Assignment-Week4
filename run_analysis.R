################################################################
################################################################
#Rscript: run_analysis.R
#2020-09-05

#This data cleaning project is part of the Coursera Course "Getting and Cleaning Data"
#Coursera project was submitted by: monique-97

################################################################
################################################################


## step0: download and read dataset

library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./UCI HAR Dataset.zip")
unzip("UCI HAR Dataset.zip", exdir = getwd())

#train data
subject.train <- read.table('./UCI HAR Dataset/train/subject_train.txt')
training.labels <- read.table('./UCI HAR Dataset/train/y_train.txt')
training.set <- read.table('./UCI HAR Dataset/train/X_train.txt')

features <- read.table('./UCI HAR Dataset/features.txt', sep = ' ') #read features
features <- as.character(features[,2]) #take features names

train_data <-  data.frame(subject.train, training.labels, training.set)
names(train_data) <- c(c('subject', 'labels'), features)

#test data
subject.test <- read.table('./UCI HAR Dataset/test/subject_test.txt')
test.labels <- read.table('./UCI HAR Dataset/test/y_test.txt')
test.set <- read.table('./UCI HAR Dataset/test/X_test.txt')

test_data <-  data.frame(subject.test, test.labels, test.set)
names(test_data) <- c(c('subject', 'labels'), features)


## step1: merge the training and the test sets to create one data set

merged_dataset <- rbind(train_data, test_data)

## step2: extract only the measurements on the mean and standard deviation for each measurement

dataset_mean_std <- merged_dataset %>% select(subject, labels, contains("-mean"), contains("-std"))

## step3: use descriptive activity names to name the activities in the data set

activity.labels <- read.table('./UCI HAR Dataset/activity_labels.txt', header = FALSE)
activity.labels <- as.character(activity.labels[,2])
dataset_mean_std$labels <- activity.labels[dataset_mean_std$labels]

## step4: appropriately label the data set with descriptive variable names

descriptive.names <- names(dataset_mean_std)

descriptive.names <- gsub("^f", "FrequencyDomainSignals_", descriptive.names)
descriptive.names <- gsub("^t", "TimeDomainSignals_", descriptive.names)
descriptive.names <- gsub("Acc", "Accelerometer", descriptive.names)
descriptive.names <- gsub("Gyro", "Gyroscope", descriptive.names)
descriptive.names <- gsub("Mag", "Magnitude", descriptive.names)

descriptive.names <- gsub("[(]", "", descriptive.names) #remove brackets
descriptive.names <- gsub("[)]", "", descriptive.names) #remove brackets
descriptive.names <- gsub("-", "_", descriptive.names)
descriptive.names <- gsub("std", "standard-deviation", descriptive.names)


names(dataset_mean_std) <- descriptive.names

## step5: from the data set in step 4, create a second, independent tidy data set with the average of each variable 
## for each activity and each subject

tidy_dataset <- dataset_mean_std %>% group_by(subject, labels) %>% summarise_all(list(mean=mean))
write.table(tidy_dataset, file = "tidy_dataset.txt", row.name=FALSE)


################################################################
################################################################

##Getting and Cleaning Data Course Project
##www.coursera.org

################################################################
################################################################
