---
title: "Codebook - runanalysis.R
author: "Simon Stainsby" aka FunOnTheUpfield
date: "20/02/2015"
output: html_document
---

The output files of run_analysis.R have the following values:

**Particpant_ID** (Factor) A unique identifier between 1 and 30. 

**Physicial_Activity** (Factor) A descriptor of the participant's physical activity at the time of measurement.  It has one of six possible values: ( WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

**PhoneMeasurement**  These are the values collected by the UCI HAR team and comprise data collected from the Samsung Galaxy 3 phones.  Descriptions of the values and the signal pre-processing undertaken to create these results from raw phone accelometer and gyroscope readings is described in the file 'UCI HAR Dataset/features_info.txt'

**Value** The calculated values from the UCI HAR team range from -1 to +1




More info about the Phone Data Values


** Body accelerometer signals - mean of measurements in x,y and z axis**

tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z

** Body accelerometer signals - Standard deviation of measurements in x,y and z axis**

tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z

** Body accelerometer signals - Median absolute deviation of measurements in x,y and z axis**

tBodyAcc-mad()-X
tBodyAcc-mad()-Y
tBodyAcc-mad()-Z

** Body accelerometer signals - Largest value in array x,y and z axis**

tBodyAcc-max()-X
tBodyAcc-max()-Y
tBodyAcc-max()-Z

** Body accelerometer signals - Smallest value in array x,y and z axis**

tBodyAcc-min()-X
tBodyAcc-min()-Y
tBodyAcc-min()-Z

** Body accelerometer signals Signal magnitude area**

tBodyAcc-sma()

** Body accelerometer signals Energy measure. Sum of the squares divided by the number of values in x, y and z axis**

tBodyAcc-energy()-X
tBodyAcc-energy()-Y
tBodyAcc-energy()-Z

** Body accelerometer signals Interquartile range in x,y,z axis** 

tBodyAcc-iqr()-X
tBodyAcc-iqr()-Y
tBodyAcc-iqr()-Z

** Body accelerometer signals Signal entropy in x,y,z axis**

tBodyAcc-entropy()-X
tBodyAcc-entropy()-Y
tBodyAcc-entropy()-Z

** Body accelerometer signals Autorregresion coefficients with Burg order equal to 4 in x,y,z axis**

tBodyAcc-arCoeff()-X,1
tBodyAcc-arCoeff()-X,2
tBodyAcc-arCoeff()-X,3
tBodyAcc-arCoeff()-X,4

tBodyAcc-arCoeff()-Y,1
tBodyAcc-arCoeff()-Y,2
tBodyAcc-arCoeff()-Y,3
tBodyAcc-arCoeff()-Y,4

tBodyAcc-arCoeff()-Z,1
tBodyAcc-arCoeff()-Z,2
tBodyAcc-arCoeff()-Z,3
tBodyAcc-arCoeff()-Z,4

** Body accelerometer signals correlation coefficient between two signals**
tBodyAcc-correlation()-X,Y
tBodyAcc-correlation()-X,Z
tBodyAcc-correlation()-Y,Z


** Gravity accelerometer signals**

* tGravityAcc-X
* tGravityAcc-Y
* tGravityAcc-Z

** Body accelerometer Jerk signals ** 

* tBodyAccJerk-X
* tBodyAccJerk-Y
* tBodyAccJerk-Z

** Body gyroscope signals**

* tBodyGyro-X
* tBodyGyro-Y
* tBodyGyro-Z

** Body gyroscope Jerk signals ** 

* tBodyGyroJerk-X
* tBodyGyroJerk-Y
* tBodyGyroJerk-Z

** Three Dimensional signal using Euclidean norm **

* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag

** Fast Fourier Transform (FFT) **

* fBodyAcc-X
* fBodyAcc-Y
* fBodyAcc-Z

* fBodyAccJerk-X
* fBodyAccJerk-Y
* fBodyAccJerk-Z

* fBodyGyro-X
* fBodyGyro-Y
* fBodyGyro-Z

* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag
