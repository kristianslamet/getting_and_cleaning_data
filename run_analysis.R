# Step 1 - Merge training and test data sets to create one data set.
# setwd("path to unzipped folder root")
trainData <- read.table("train/X_train.txt")
trainLabel <- read.table("train/y_train.txt")
table(trainLabel)
trainSubject <- read.table("train/subject_train.txt")
testData <- read.table("test/X_test.txt")
testLabel <- read.table("test/y_test.txt") 
table(testLabel) 
testSubject <- read.table("test/subject_test.txt")
fullData <- rbind(trainData, testData)
fullLabel <- rbind(trainLabel, testLabel)
fullSubject <- rbind(trainSubject, testSubject)

# Step 2 - Extract only mean and std dev for each measurement. 
features <- read.table("features.txt")
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
fullData <- fullData[, meanStdIndices]
names(fullData) <- gsub("\\(\\)", "", features[meanStdIndices, 2]) # remove "()"
names(fullData) <- gsub("mean", "Mean", names(fullData)) # capitalize M
names(fullData) <- gsub("std", "Std", names(fullData)) # capitalize S
names(fullData) <- gsub("-", "", names(fullData)) # remove "-" in column names 

# Step 3 - Use descriptive activity names to name the activities in the data set
activity <- read.table("activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[fullLabel[, 1], 2]
fullLabel[, 1] <- activityLabel
names(fullLabel) <- "activity"

# Step 4 - Label data set with descriptive activity names. 
names(fullSubject) <- "subject"
cleanedData <- cbind(fullSubject, fullLabel, fullData)
dim(cleanedData)
write.table(cleanedData, "merged_clean_data.txt", row.name=FALSE) # this is my merged dataset

# Step 5 - Create second, independent tidy data set with the average of each variable for each activity and each subject. 
subjectLen <- length(table(fullSubject))
activityLen <- dim(activity)[1]
columnLen <- dim(cleanedData)[2]
output <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen) 
output <- as.data.frame(output)
colnames(output) <- colnames(cleanedData)
row <- 1
for(i in 1:subjectLen) {
        for(j in 1:activityLen) {
                output[row, 1] <- sort(unique(fullSubject)[, 1])[i]
                output[row, 2] <- activity[j, 2]
                bool1 <- i == cleanedData$subject
                bool2 <- activity[j, 2] == cleanedData$activity
                output[row, 3:columnLen] <- colMeans(cleanedData[bool1&bool2, 3:columnLen])
                row <- row + 1
        }
}
write.table(output, "clean_averaged_data.txt", row.name=FALSE) # this is my dataset with averages
