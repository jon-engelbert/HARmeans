#generates a set of nicely formatted column headers (features)
generateFeaturesVectorPretty = function(featuresWithHeaderTrans) {
    featuresTrans <- featuresWithHeaderTrans[, 2]
    features <- t(featuresTrans)
    features = as.vector(features)
    for (i in 1: length(features)) {
        feature = features[i]
        feature = gsub("\\(", "", feature )
        feature = gsub("\\)", "", feature )
        feature = gsub("-", ".", feature)
        features[i] = feature
    }
    as.vector(features)
}

# replace activity numbers with labels
nameActivities = function(activities, activityLabels) {
    for (i in 1: nrow(activityLabels)) {
        for (j in 1: nrow(activities)) {
            activity = sub(activityLabels[i, 1], activityLabels[i, 2], activities[j,1])
            activities[j,1] = activity
        }
    }    
    as.data.frame(activities)
}

#You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# 0. load in training set and test set
#library(data.table)
#setwd("~./Rprog/Get_Clean_Project")

# 1. Merges the training and the test sets to create one data set.
harDataTest <- read.table("./UCI HAR Dataset/test/X_test.txt", header= FALSE)
harDataTrain <- read.table("./UCI HAR Dataset/train/X_train.txt", header= FALSE)
harDataAll <- rbind(harDataTest, harDataTrain)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#   2a. insert the column names
featuresWithHeaderTrans <- read.table("./UCI HAR Dataset/features.txt", header= FALSE)
features = generateFeaturesVectorPretty(featuresWithHeaderTrans)
colnames(harDataAll) <- features


#   2b. Extract only the measurements on the mean and standard deviation (need to use regex?)
featuresMeanStdVar = features[grepl("(mean|std|meanFreq)[^a-zA-z]", features)]  # all features with mean or std in string, but not followed by a character, to rule out meanFreq
featuresMeanStdVar <- as.vector(featuresMeanStdVar)
harMeanStdVar <- harDataAll[, featuresMeanStdVar]
    

#   **. Load and Merge the subjects also
#   This step MUST take place after the features are added as labels, otherwise the column headers will be mismatched.
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt", header= FALSE)
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt", header= FALSE)
subjectAll <- rbind(subjectTest, subjectTrain)
harMeanStdVar <- cbind(subjectAll, harMeanStdVar)
colnames(harMeanStdVar)[1] <- "subject"

# 3. Uses descriptive activity names to name the activities in the data set
activitiesTest <- read.table("./UCI HAR Dataset/test/Y_test.txt", header= FALSE)
activitiesTrain <- read.table("./UCI HAR Dataset/train/Y_train.txt", header= FALSE)
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt", header= FALSE)
activities <- rbind(activitiesTest, activitiesTrain)

#   3a. replace numbers with strings, then merge activities into the HAR dataset.
activities = nameActivities(activities, activityLabels)
har = cbind(activities, harMeanStdVar)
colnames(har)[1] <- "activity"
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject, and generate output file 

library(plyr)
activitySubjectData <- ddply(har, c("activity", "subject"), numcolwise(mean))
write.csv(activitySubjectData, file="MeansByActivityAndSubject.csv")
