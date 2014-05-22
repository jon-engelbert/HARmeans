# Code Book:
for HARmeans project -- means by activity and subject for the Human Activity Recognition Using Smartphones Dataset
## Variable Sets:
* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The variables with XYZ at the end are actually 3 variable subsets, one for each dimension.  
Each variable set/subset includes many subfeatures, including mean and standard deviation (std) and others.  
The original data set includes 560 variables.
## Output features
We use only 57 of the original features, specifically the mean and standard deviation variables, and also, where available, the “meanFreq”, or the weighted average of the frequency components to obtain a mean frequency.  
The script run_analysis.R calculates the average of each feature, averaged over each distinct subject/activity pair, where the features are described above in the Variable Sets section.  
I.e., a feature is the mean or standard deviation or mean frequency of each of the features.
* For the acceleration signal from the smartphone accelerometer axes, the units are in standard gravity units 'g'.
* For the angular velocity vector measured by the gyroscope  the units are radians/second.

## Instruction List 
First, download the HAR data set and place it into the directory “~./UCI HAR Dataset”
Place the script “run_analysis.R” into the same directory, set that as the working directory, and then you can run run_analysis.R.
The output will be written to the file “MeansByActivityAndSubject.txt”
(see run_analysis.R for the program used to generate the output)

## Extra notes about the “most” original data
(from the readme.txt that comes with the UCI HAR Dataset)
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
The complete list of variables of each feature vector is available in 'features.txt'