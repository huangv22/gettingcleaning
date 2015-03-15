# Codebook

## Data

### Input
Obtain the data here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Output
The resulting `./data/tidy.txt` dataset includes a mean variable for each activity and each subject.

For each X,Y, Z direction, the following variables are included: 
tBodyAcc, tGravityAcc, tBodyAccJerk, tBodyGyro, tBodyGyroJerk, tBodyAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag, fBodyAcc, fBodyAccJerk, fBodyGyro, fBodyAccMag, fBodyBodyAccJerkMag, fBodyBodyGyroMag, fBodyBodyGyroJerkMag

## Transformations
The script, `run_analysis.R`, goes through the following steps:

- Set up the working environment
-- Set up directory
--  Download and store
- Merges the training and the test sets to create one data set
-- Read tables
-- Merge training and testing sets and set column names
- Extracts only the measurements on the mean and standard deviation for each measurement
- Appropriately labels the data set with descriptive variable names. 
- Creates a second, independent tidy data set with the average of each variable for each activity and each subject

