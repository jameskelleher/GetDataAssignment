# Getting and Cleaning Data Course Project

### Project Info
#### (If you are peer reviewing, please skip to the next section)
This project is my submission for the "Getting and Cleaning Data" class taught by John Hopkins University through Coursera.

The assignment is as follows:

"The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

"Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

"You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."

### Description of Analysis
The project uses only one R script, `run_analysis.R`.

This script first checks for the existence of the dataset in the working directory; if it can't find the data, it downloads a copy.

Given that the data necessary to create the tidy data set (specified in step 5 above) is located across multiple txt files, the script must read in each one of these files as a separate data frame.
