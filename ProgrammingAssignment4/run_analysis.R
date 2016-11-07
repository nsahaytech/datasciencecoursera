setwd("/home/nishant/coursera/R/dataCleansing/datasciencecoursera/ProgrammingAssignment4")

require("data.table")

# load the labels for activities
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# load the labels for features
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

#print(activity_labels)
#print(features)

# read data into data frames
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

# add column name for subject files
names(subject_train) <- "subjectID"
names(subject_test) <- "subjectID"

# add column names for measurement files
names(X_train) <- features
names(X_test) <- features

# add column name for label files
names(y_train) <- "activity"
names(y_test) <- "activity"

#1. Merges the training and the test sets to create one data set.
# combine files into one dataset
train_data <- cbind(subject_train, y_train, X_train)
test_data <- cbind(subject_test, y_test, X_test)
total_data <- rbind(train_data, test_data)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.

# we only need to extract mean and std deviation. Extract features has only these specific labels
extract_features <- grepl(".*mean*|.*std*", names(total_data))
#print(extract_features)
#need to retain subject id and activiy column names
extract_features[1:2] <- TRUE

# remove unnecessary columns
total_data <- total_data[, extract_features]



# 3. Use descriptive activity names to name the activities in the data set

activities <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE,colClasses="character")


colnames(activities)  <- c('activity','activityType');

# Merge the finalData set with the acitivityType table to include descriptive activity names
final_data = merge(total_data,activities,by='activity',all.x=TRUE);

#print(final_data[2,])
#4. Appropriately labels the data set with descriptive activity names.

names(final_data)<-gsub("Acc", "Accelerometer", names(final_data))
names(final_data)<-gsub("Gyro", "Gyroscope", names(final_data))
names(final_data)<-gsub("BodyBody", "Body", names(final_data))
names(final_data)<-gsub("Mag", "Magnitude", names(final_data))
names(final_data)<-gsub("^t", "Time", names(final_data))
names(final_data)<-gsub("^f", "Frequency", names(final_data))
names(final_data)<-gsub("tBody", "TimeBody", names(final_data))
names(final_data)<-gsub("-mean()", "Mean", names(final_data), ignore.case = TRUE)
names(final_data)<-gsub("-std()", "STD", names(final_data), ignore.case = TRUE)
names(final_data)<-gsub("-freq()", "Frequency", names(final_data), ignore.case = TRUE)
names(final_data)<-gsub("angle", "Angle", names(final_data))
names(final_data)<-gsub("gravity", "Gravity", names(final_data))

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Exclude activity type in a new data table as other are numeric except it
final_data_filtered  = final_data[,names(final_data) != 'activityType'];

tidyData <- aggregate(final_data_filtered[,names(final_data_filtered) != c('activity','subjectID')],by=list(activity=final_data_filtered$activity,subjectID = final_data_filtered$subjectID),mean);
# Merging the tidyData with activityType to include descriptive acitvity names
tidyData    = merge(tidyData,activities,by='activity',all.x=TRUE);


#print(tidyData[2,])
write.table(tidyData, file = "./tidyData.txt", row.name=FALSE)




 


