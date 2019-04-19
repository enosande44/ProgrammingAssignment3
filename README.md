# Coursera Programming Assignment 3 - Tidy Data
## Author Enos Sande

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Step 1: 
* Downloads the files from the link provided. 
* Loads the required packages.
* Pulls the data into r data frames.
### Step 2: 
* Loads the *activity_labels.txt, and the features.txt* files.
* Selects only required features from the features data frame and creates a character vector of these features called measurements.
### Step 3:
* Loads 3 files from the train folder *X_train, Y_train, and subject_train*.
* Filters only required features from the *X_train* file and merges them to create the train data frame.
### Step 4:
* Repeats step 3 above for the test folder.
### Step 5:
* Merges train data frame with test data frame by rows and rearranges them.
### Step 6:
* Final data frame is prepared by first unlisting the variables.
* Variables are spread again while also calculating the mean of each by the subject ID and activity label.
### Step 7:
* Finally a text file is created using the write.table function.

