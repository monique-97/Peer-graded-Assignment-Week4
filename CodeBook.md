---
title: "CodeBook.md"
author: "monique-97"
date: "6 09 2020"
output: html_document
---

################################################################
################################################################

CodeBook

2020-09-05


This data cleaning project is part of the Coursera Course "Getting and Cleaning Data"

Coursera project was submitted by: monique-97

################################################################
################################################################

R script called run_analysis.R performs all the steps described in Getting and Cleaning Data Course Project (www.coursera.org):

steps:0-5

 

- ** step0: Downloads and reads the dataset **

Data are downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

UCI HAR Dataset folder is created

Dataset is unziped with unzip() function

** Train and test data are loaded from files, names of variables are assigned as follows: **

subject.train = subject_train.txt

training.labels = y_train.txt #Training labels

training.set = X_train.txt #Training set
 
features = features.txt #features names are taken from the second column
 
subject.test = subject_test.txt

test.labels = y_test.txt #Test labels

test.set = X_test.txt #Test set
 
train_data and test_data dataframes are created from subjects, labels and train/test sets
 
column names are assigned as 'subject', 'labels' and all the features names

 

- ** step1: Merges the training and the test sets to create one data set. **

merged_dataset is created by merging train_data and test_data, rbind() function is used (merged_dataset has 10299 rows, 563 columns)

 

- ** step2: Extracts only the measurements on the mean and standard deviation for each measurement. **

measurements on the mean and standard deviation are found and selected for each measurement

output is written to dataframe called dataset_mean_std (10299 rows, 81 columns)

 

- ** step3: Uses descriptive activity names to name the activities in the data set **

activity labels in dataset_mean_std shown as numbers are replaced by activity taken from second column of activity.labels

 

- ** step4: Appropriately labels the data set with descriptive variable names. **

names of columns are labeled appropriately:

 

f in column's name is replaced by FrequencyDomainSignals
 
t in column's name is replaced by TimeDomainSignals
 
Acc in column’s name is replaced by Accelerometer
 
Gyro in column’s name is replaced by Gyroscope
 
Mag in column’s name is replaced by Magnitude
 
 

all brackets are removed

"-" are replaced by "_"
 
std in column’s name is replaced by standard-deviation
 


- ** step5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. **
 
tidy_dataset is created by taking and calculating the average of each variable for each activity and each subject
 
** final dataset called tidy_dataset (180 rows, 81 columns) is exported into tidy_dataset.txt **
 

################################################################
################################################################

Getting and Cleaning Data Course Project
www.coursera.org

################################################################
################################################################
