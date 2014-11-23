# Getting and Cleaning Data Course Project CodeBook #

----------

## Input Data ##


The data used for this project can be found here: [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

A full description of the data can be found at the site where the data was obtained:
[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )

### Data Set Description ###



The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

(Additional information can be found in the README.txt file with data set)

For each record, the following data is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The files used in processing are:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

## Processing ##

Below are the text descriptions of the processing done within run_process.R.

### Step 1 ###

Merge the training and the test sets to create one data set.

- Read in all the files and create of clean up all of the header names
	- features.txt
		- this file is all of the column headers for the data contain in X\_train.txt and X\_test.txt.
		- cleaning the data in this file consists of removing - and () characters, turning abbreviations into readable works, and lowercasing all characters (specific implementation details can be seen in the R script)
	- activity\_labels.txt
		- this file contains the mapping from activity id to activity type
		- once loaded, the columns of the data frame were updated to be more readable using the strings activityid and activitytype
	- train/subject\_train.txt and test/subject_test.txt
		- this file contains all of the subject ids corresponding to the data in X\_train.txt and X\_test.txt.
		- once loaded, the column of the data frame was updated to be more readable using the string subjectid
	- train/X\_train.txt and test/X\_test.txt
		- these files contain all of the results from the training and test sets
		- once loaded, the columns of the data frames was loaded from the second column of the features data frame
	- train/y\_train.txt and test/y\_test.txt
		- these files contain all of the activity ids corresponding to each row of the corresponding file (X\_train.txt or X\_test.txt)
		- once loaded, the column of the data frame was updated to be more reading using the string actvitiyid
- Once all of the data was read in, the training dataset data frames were combined into one data frame and the test dataset data frames where combined into one data frame. 
- Then, both complete train and test data frames were merged together.

### Step 2 ###

Extracts only the measurements on the mean and standard deviation for each measurement.

- Based on the column names of the combined data frame, a logical vector created using the _grepl_ command to select the columns based on the following words
	- activity (allows the selection of the activityid)
	- subject (allows the selection of the subjectid)
	- mean (allows the selection of all columns that use the mean - I interpreted this requirement to include columns that were the mean, or were a calculation using the mean)
	- standarddeviation (allows the select of all columns that use the standarddeviation - when cleaning the feature values std was converted to standarddeviation for readability)
- Once the logical vector was created, it was used stored to be used in the next step when generating the clean, readable data frame

### Step 3 ###

Uses descriptive activity names to name the activities in the data set.

- Using the logical vector created in Step 2, a subset of the columns of the combined data frame is merged with the activity labels to create a final data frame that contains the subset data along with readable activity names

### Step 4 ###

Appropriately labels the data set with descriptive variable names.

- This step was completed during the reading of the data files by modifying the values read in from features.txt and by created readable column names in all the data frames.
	- Here is the list of columns included in the final data set
		- activityid
		- activitytype
		- subjectid
		- timebodyaccelerometermeanx
		- timebodyaccelerometermeany
		- timebodyaccelerometermeanz
		- timebodyaccelerometerstandarddeviationx
		- timebodyaccelerometerstandarddeviationy
		- timebodyaccelerometerstandarddeviationz
		- timegravityaccelerometermeanx
		- timegravityaccelerometermeany
		- timegravityaccelerometermeanz
		- timegravityaccelerometerstandarddeviationx
		- timegravityaccelerometerstandarddeviationy
		- timegravityaccelerometerstandarddeviationz
		- timebodyaccelerometerjerkmeanx
		- timebodyaccelerometerjerkmeany
		- timebodyaccelerometerjerkmeanz
		- timebodyaccelerometerjerkstandarddeviationx
		- timebodyaccelerometerjerkstandarddeviationy
		- timebodyaccelerometerjerkstandarddeviationz
		- timebodygyroscopemeanx
		- timebodygyroscopemeany
		- timebodygyroscopemeanz
		- timebodygyroscopestandarddeviationx
		- timebodygyroscopestandarddeviationy
		- timebodygyroscopestandarddeviationz
		- timebodygyroscopejerkmeanx
		- timebodygyroscopejerkmeany
		- timebodygyroscopejerkmeanz
		- timebodygyroscopejerkstandarddeviationx
		- timebodygyroscopejerkstandarddeviationy
		- timebodygyroscopejerkstandarddeviationz
		- timebodyaccelerometermagnitudemean
		- timebodyaccelerometermagnitudestandarddeviation
		- timegravityaccelerometermagnitudemean
		- timegravityaccelerometermagnitudestandarddeviation
		- timebodyaccelerometerjerkmagnitudemean
		- timebodyaccelerometerjerkmagnitudestandarddeviation
		- timebodygyroscopemagnitudemean
		- timebodygyroscopemagnitudestandarddeviation
		- timebodygyroscopejerkmagnitudemean
		- timebodygyroscopejerkmagnitudestandarddeviation
		- frequencybodyaccelerometermeanx
		- frequencybodyaccelerometermeany
		- frequencybodyaccelerometermeanz
		- frequencybodyaccelerometerstandarddeviationx
		- frequencybodyaccelerometerstandarddeviationy
		- frequencybodyaccelerometerstandarddeviationz
		- frequencybodyaccelerometermeanfrequencyx
		- frequencybodyaccelerometermeanfrequencyy
		- frequencybodyaccelerometermeanfrequencyz
		- frequencybodyaccelerometerjerkmeanx
		- frequencybodyaccelerometerjerkmeany
		- frequencybodyaccelerometerjerkmeanz
		- frequencybodyaccelerometerjerkstandarddeviationx
		- frequencybodyaccelerometerjerkstandarddeviationy
		- frequencybodyaccelerometerjerkstandarddeviationz
		- frequencybodyaccelerometerjerkmeanfrequencyx
		- frequencybodyaccelerometerjerkmeanfrequencyy
		- frequencybodyaccelerometerjerkmeanfrequencyz
		- frequencybodygyroscopemeanx
		- frequencybodygyroscopemeany
		- frequencybodygyroscopemeanz
		- frequencybodygyroscopestandarddeviationx
		- frequencybodygyroscopestandarddeviationy
		- frequencybodygyroscopestandarddeviationz
		- frequencybodygyroscopemeanfrequencyx
		- frequencybodygyroscopemeanfrequencyy
		- frequencybodygyroscopemeanfrequencyz
		- frequencybodyaccelerometermagnitudemean
		- frequencybodyaccelerometermagnitudestandarddeviation
		- frequencybodyaccelerometermagnitudemeanfrequency
		- frequencybodyaccelerometerjerkmagnitudemean
		- frequencybodyaccelerometerjerkmagnitudestandarddeviation
		- frequencybodyaccelerometerjerkmagnitudemeanfrequency
		- frequencybodygyroscopemagnitudemean
		- frequencybodygyroscopemagnitudestandarddeviation
		- frequencybodygyroscopemagnitudemeanfrequency
		- frequencybodygyroscopejerkmagnitudemean
		- frequencybodygyroscopejerkmagnitudestandarddeviation
		- frequencybodygyroscopejerkmagnitudemeanfrequency
		- angle(tbodyaccelerometermean,gravity)
		- angle(tbodyaccelerometerjerkmean),gravitymean)
		- angle(tbodygyroscopemean,gravitymean)
		- angle(tbodygyroscopejerkmean,gravitymean)
		- angle(x,gravitymean)
		- angle(y,gravitymean)
		- angle(z,gravitymean)


### Step 5 
 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

- The data set from Step 4 was copied and the aggregate method was used to aggregate the data by the activityid and subjectid and calculate the mean of the data
	- In order to make the data more readable, the string "meanof" was appended to each column name where the mean was calculated.
	- The resulting data frame was output to a file to be attached to the Coursera project site and it was also included in this repository.
	- Here are the columns that were output in this data set:
		- activityid
		- activitytype
		- subjectid
		- meanoftimebodyaccelerometermeanx
		- meanoftimebodyaccelerometermeany
		- meanoftimebodyaccelerometermeanz
		- meanoftimebodyaccelerometerstandarddeviationx
		- meanoftimebodyaccelerometerstandarddeviationy
		- meanoftimebodyaccelerometerstandarddeviationz
		- meanoftimegravityaccelerometermeanx
		- meanoftimegravityaccelerometermeany
		- meanoftimegravityaccelerometermeanz
		- meanoftimegravityaccelerometerstandarddeviationx
		- meanoftimegravityaccelerometerstandarddeviationy
		- meanoftimegravityaccelerometerstandarddeviationz
		- meanoftimebodyaccelerometerjerkmeanx
		- meanoftimebodyaccelerometerjerkmeany
		- meanoftimebodyaccelerometerjerkmeanz
		- meanoftimebodyaccelerometerjerkstandarddeviationx
		- meanoftimebodyaccelerometerjerkstandarddeviationy
		- meanoftimebodyaccelerometerjerkstandarddeviationz
		- meanoftimebodygyroscopemeanx
		- meanoftimebodygyroscopemeany
		- meanoftimebodygyroscopemeanz
		- meanoftimebodygyroscopestandarddeviationx
		- meanoftimebodygyroscopestandarddeviationy
		- meanoftimebodygyroscopestandarddeviationz
		- meanoftimebodygyroscopejerkmeanx
		- meanoftimebodygyroscopejerkmeany
		- meanoftimebodygyroscopejerkmeanz
		- meanoftimebodygyroscopejerkstandarddeviationx
		- meanoftimebodygyroscopejerkstandarddeviationy
		- meanoftimebodygyroscopejerkstandarddeviationz
		- meanoftimebodyaccelerometermagnitudemean
		- meanoftimebodyaccelerometermagnitudestandarddeviation
		- meanoftimegravityaccelerometermagnitudemean
		- meanoftimegravityaccelerometermagnitudestandarddeviation
		- meanoftimebodyaccelerometerjerkmagnitudemean
		- meanoftimebodyaccelerometerjerkmagnitudestandarddeviation
		- meanoftimebodygyroscopemagnitudemean
		- meanoftimebodygyroscopemagnitudestandarddeviation
		- meanoftimebodygyroscopejerkmagnitudemean
		- meanoftimebodygyroscopejerkmagnitudestandarddeviation
		- meanoffrequencybodyaccelerometermeanx
		- meanoffrequencybodyaccelerometermeany
		- meanoffrequencybodyaccelerometermeanz
		- meanoffrequencybodyaccelerometerstandarddeviationx
		- meanoffrequencybodyaccelerometerstandarddeviationy
		- meanoffrequencybodyaccelerometerstandarddeviationz
		- meanoffrequencybodyaccelerometermeanfrequencyx
		- meanoffrequencybodyaccelerometermeanfrequencyy
		- meanoffrequencybodyaccelerometermeanfrequencyz
		- meanoffrequencybodyaccelerometerjerkmeanx
		- meanoffrequencybodyaccelerometerjerkmeany
		- meanoffrequencybodyaccelerometerjerkmeanz
		- meanoffrequencybodyaccelerometerjerkstandarddeviationx
		- meanoffrequencybodyaccelerometerjerkstandarddeviationy
		- meanoffrequencybodyaccelerometerjerkstandarddeviationz
		- meanoffrequencybodyaccelerometerjerkmeanfrequencyx
		- meanoffrequencybodyaccelerometerjerkmeanfrequencyy
		- meanoffrequencybodyaccelerometerjerkmeanfrequencyz
		- meanoffrequencybodygyroscopemeanx
		- meanoffrequencybodygyroscopemeany
		- meanoffrequencybodygyroscopemeanz
		- meanoffrequencybodygyroscopestandarddeviationx
		- meanoffrequencybodygyroscopestandarddeviationy
		- meanoffrequencybodygyroscopestandarddeviationz
		- meanoffrequencybodygyroscopemeanfrequencyx
		- meanoffrequencybodygyroscopemeanfrequencyy
		- meanoffrequencybodygyroscopemeanfrequencyz
		- meanoffrequencybodyaccelerometermagnitudemean
		- meanoffrequencybodyaccelerometermagnitudestandarddeviation
		- meanoffrequencybodyaccelerometermagnitudemeanfrequency
		- meanoffrequencybodyaccelerometerjerkmagnitudemean
		- meanoffrequencybodyaccelerometerjerkmagnitudestandarddeviation
		- meanoffrequencybodyaccelerometerjerkmagnitudemeanfrequency
		- meanoffrequencybodygyroscopemagnitudemean
		- meanoffrequencybodygyroscopemagnitudestandarddeviation
		- meanoffrequencybodygyroscopemagnitudemeanfrequency
		- meanoffrequencybodygyroscopejerkmagnitudemean
		- meanoffrequencybodygyroscopejerkmagnitudestandarddeviation
		- meanoffrequencybodygyroscopejerkmagnitudemeanfrequency
		- meanofangle(tbodyaccelerometermean,gravity)
		- meanofangle(tbodyaccelerometerjerkmean),gravitymean)
		- meanofangle(tbodygyroscopemean,gravitymean)
		- meanofangle(tbodygyroscopejerkmean,gravitymean)
		- meanofangle(x,gravitymean)
		- meanofangle(y,gravitymean)
		- meanofangle(z,gravitymean)

## Running the Script ##

In order to run the run_process.R script, it is assumed that the script and the directory "UCI HAR Dataset" are in the current working directory.  Assuming that, the script can be run by typing:

    source('run_analysis.R')

Once this is completed, the data frames of interest will be:

- finalDataSetWithActivity: containing the original processed data with readable activity types and header names
- averageDataWithActivy: containing the aggregated averages of the data by activity id and subject id
	- this data will also be found in the current working directory in a file called tidyData.txt
		- to validate this data, you can run the following:

```
data <- read.table("tidyData.txt",header=TRUE)
View(data)
```





 