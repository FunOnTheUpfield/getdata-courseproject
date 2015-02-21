# getdata-courseproject

About the script run_analysis.R
---

This script produces summary values from data collected by Anguita et.al. (2012)
and available for download from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

Data acknowledgements:
  UCI HAR Dataset developed by:
  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
  Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
  International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This this data is a series of pre-processed gyroscope and accelorometer readings collected from 30 people wearing Samsung Galaxy 3 smart phones. 


The script returns two files:
*phonemeasures-mean-std_dev-step2.txt* a table listing the mean and standard devation of 477 Phone measurements  collected by Anguita et.al. (2012) and:

*phonemeasures_by_particpant_and_activity.txt-step5.txt* a table providing more detailed results showing the mean and standard deviation of phone measurements collected by Anguita et.al. (2012) with a breakdown by each of the 30 participants and each of the 7 activity types.



How use the script *run_analyis.R*
---

STEP 1: Clone a copy of *run_analysis.R* from github using the command:

```
git clone https://github.com/FunOnTheUpfield/getdata-courseproject.git
```

Manually download the UCI HAR dataset from: 
*https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip*

Manually unzip the file the file UCI_HAR_Dataset.zip
Save the decompressed folder 'UCI HAR Dataset' 


STEP 3  Execute run_analysis.R using RStudio.R
Use the setwd() command to run the script from the directory where you saved the decompressed version of 'UCI HAR Dataset'

STEP 4 Go make a cup of tea.  This script takes about 15 minutes to complete execution.



Clean Data
---
The output files of *run_analyis.R* qualify as tidy data because:

- Each row is a observation, series of data points collected when a specific participant engaged in a specific activity
- Each variable has its own column - Particpant_ID, Physical_Activity or a calculated value derived from phone measurement
- All the values form the same type of observational unit namely a value recorded from a phone sensor
- Factor data (the activity labels) have human readable values, rather than code numbers. Note that particpant_id is also a factor value, but this remains a number code to preserve subject privacy.


Development Environment Details
---
The script run_analyis.R was developed on a gnu-linux (Ubuntu 14.14) machine running
R version 3.1.2 (Pumpkin Helmet)


Improving the code 
---
The slowest step the code block that converts the data from a wide tidy data set (477 columns wide) to a narrow (4 columns wide) by checking each cell using a nexted loop.

The code is following code block ....

```

for (row in 1:nrow(PhoneMeasurement)) {
  longtidy[row,1] <- subjects$ParticipantID[row]
  longtidy[row,2] <- Activity[row]
  for (col in 1:ncol(PhoneMeasurement)) {
    longtidy[row,3] <- colnames(PhoneMeasurement[col])
    longtidy[row,4] <- PhoneMeasurement[row,col]
    }
  }

```

Any tips on using lapply or similar to speed up this operation would be greatly appreciated.


About the experiment and experiment results "raw" data set
---

The Human Activity Recognition Using Smartphones Data Set 
located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
stores the results of an experiment involving 30 subjects wearing a Samsung Galaxy 3 smartphone.

Details of the experiment design and discussion of results are available from:

*Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012*

Additional information about the formatting of the raw data set
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The phone accelorometer and gyroscope recorded movement in x,y,z axis.
The raw accelorometer and gyroscope x,y,z values has been pre-processed both to minimise the influence of movements caused by gravity, and has been filtered to extract 'noise' values.
For more information about this pre-processing see the file 'UCI HAR Dataset/features_info.txt'

