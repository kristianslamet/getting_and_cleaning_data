##Variables, Data Used, and Transformations or Work performed to clean up the data

The description for the variables are obtained from the following URL:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The actual download link for the data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script transforms data as below:

Read X_train.txt, y_train.txt and subject_train.txt and loads into trainData, trainLabel and trainSubject variables.
Read X_test.txt, y_test.txt and subject_test.txt and loads into in testData, testLabel and testsubject variables.
Append testData after / below trainData to create fullData; append testLabel after / below trainLabel to create fullLabel; append testSubject after / below trainSubject to create fullSubject.
Read the features.txt file and loads "features" variable. Select only mean and std dev. Also, select fullData columns for only those for mean and std dev.
Clean column names of the subset. 
Read the activity_labels.txt and loads "activity" variable.
Clean the activity names in the second column of activity.
Replace the values of fullLabel according to the activity data frame.
Combine fullSubject, fullLabel and fullData by column to get cleanedData. Name the "ubject" and "activity" columns. 
Write the cleanedData out to "merged_clean_data.txt" file in root of the folder.
Create a second independent tidy data set with the average of each measurement for each activity and each subject.
Write the result out to "clean_averaged_data.txt" file in current working directory.
