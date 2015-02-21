---
title: "Codebook - runanalysis.R
author: "Simon Stainsby" aka FunOnTheUpfield
date: "20/02/2015"
output: html_document
---

The output files of run_analysis.R have the following values:

**Participant_ID** (Factor) A unique identifier between 1 and 30. This code number identifies the participants in the Anguita et.al. (2012) study.

**Physicial_Activity** (Factor) A descriptor of the participant's physical activity at the time of measurement.  It has one of six possible values: ( WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

**PhoneMeasurement**  These are the values collected by the UCI HAR team and comprise data collected from the Samsung Galaxy 3 phones.  Descriptions of the values and the signal pre-processing undertaken to create these results from raw phone accelometer and gyroscope readings is described in the file 'UCI HAR Dataset/features_info.txt'

**av** 
In the file "phonemeasures-mean-std_dev-step2.txt"
This value is the average (mean) of ALL observations for a given value of PhoneMeasurement.

In the file "phonemeasures_by_particpant_and_activity.txt-step5.txt"
This value is the average (mean) of PhoneMeasurement observations grouped by participant and activity.

**std_dev**  
In the file "phonemeasures-mean-std_dev-step2.txt"
This value is the average (mean) of ALL observations for a given value of PhoneMeasurement.

In the file "phonemeasures_by_particpant_and_activity.txt-step5.txt"
This value is the average (mean) of PhoneMeasurement observations grouped by participant and activity.



Details of the PhoneMeasurement values 
---
The file features_info.txt provides a brief description of data categories used in the Anguita et.al. (2012) study.

For a full description of the values and what they mean see:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
**Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.**
International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

