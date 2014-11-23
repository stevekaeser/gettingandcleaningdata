# The purpose of this R script is to do the following:
#
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set with the
#    average of each variable for each activity and each subject.

# Read in all of the data and clean up column names
features <- read.table("UCI HAR Dataset/features.txt",header=FALSE)

features[,2] <- gsub("-","",features[,2])
features[,2] = gsub("\\()","",features[,2])
features[,2] = gsub("std","StandardDeviation",features[,2])
features[,2] = gsub("^(t)","time",features[,2])
features[,2] = gsub("^(f)","Freq",features[,2])
features[,2] = gsub("([Gg]ravity)","Gravity",features[,2])
features[,2] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",features[,2])
features[,2] = gsub("[Gg]yro","Gyro",features[,2])
features[,2] = gsub("AccMag","AccMagnitude",features[,2])
features[,2] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",features[,2])
features[,2] = gsub("JerkMag","JerkMagnitude",features[,2])
features[,2] = gsub("GyroMag","GyroMagnitude",features[,2])
features[,2] = gsub("Acc","Accelerometer",features[,2])
features[,2] = gsub("Gyro","Gyroscope",features[,2])
features[,2] = gsub("Freq","frequency",features[,2])
features[,2] <- tolower(features[,2])

activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE)

colnames(activityLabels) <- c("activityid","activitytype")

# Read in, clean and merge the training data
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt",header=FALSE)
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt",header=FALSE)
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt",header=FALSE)

colnames(subjectTrain) <- "subjectid"
colnames(xTrain) <- features[,2]
colnames(yTrain) <- "activityid"

# Combine the training data into one data frame using cbind
completeTrainingData <- cbind(subjectTrain,yTrain,xTrain)

# Read in, clean and merge the test data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt",header=FALSE)
xTest <- read.table("UCI HAR Dataset/test/X_test.txt",header=FALSE)
yTest <- read.table("UCI HAR Dataset/test/y_test.txt",header=FALSE)

colnames(subjectTest) <- "subjectid"
colnames(xTest) <- features[,2]
colnames(yTest) <- "activityid"

# Combine the test data into one data frame using cbind
completeTestData <- cbind(subjectTest,yTest,xTest)

# Use rbind to combine the training data frame and the test data frame
combinedData <- rbind(completeTrainingData,completeTestData)

# Determine which columns are needed and create a logical data frame
finalColumns <- colnames(combinedData)
columnsToKeep <- grepl("activity|subject|mean|standarddeviation",finalColumns)

# Using the logical data frame, subset and merge the data with the activity types for readability
finalDataSetWithActivity <- merge(activityLabels,combinedData[,columnsToKeep],by="activityid",all.x=TRUE)

# Create a copy of the subset of data to make a new data frame containing the averages
averageData <- combinedData[,columnsToKeep]

# Rename the columns for readability
averageDataColumns <- colnames(averageData)
for (i in 1:length(averageDataColumns))
{
    if (!grepl("activity|subject",averageDataColumns[i])) 
    {
        averageDataColumns[i] <- paste("meanof",averageDataColumns[i],sep="")
    }
}
colnames(averageData) <- averageDataColumns

# Aggregate the dataframe on activityid and subjectid, calculating the mean for the rest of the columns
averageData <- aggregate(averageData[,!grepl("activity|subject",colnames(averageData))],
                         by=list(activityid = averageData$activityid,subjectid = averageData$subjectid),
                         mean)

# Merge the resulting average data frame with the activity types for readability
averageDataWithActivity <- merge(activityLabels,averageData,by="activityid",all.x=TRUE)

# Write the data out for submission
write.table(averageDataWithActivity,"tidyData.txt",row.name=FALSE)
