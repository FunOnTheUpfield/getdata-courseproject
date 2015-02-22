# getdata-courseproject

About the script run_analysis.R
---

This script produces summary values from data collected by Anguita et.al. (2012)
This data is available from  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

This this data is a series of pre-processed gyroscope and accelorometer readings collected from 30 people wearing Samsung Galaxy 3 smart phones. 


The script returns the files:
*get_clean_data_course_project_widetidy.txt* the full UCI HAR dataset in one table.

*get_clean_data_course_project_output.txt*  a table providing a suppmary of the data by Participant and Activity, an average value for each of the datapoints collected by  Anguita et.al. 


How use the script *run_analyis.R*
---

STEP 1: Clone a copy of *run_analysis.R* from github using the command:

```
git clone https://github.com/FunOnTheUpfield/getdata-courseproject.git
```

STEP 2  With a working internet connection
Execute run_analysis.R using RStudio.R
Use the setwd() command to run the script from the directory where you saved the decompressed version of 'UCI HAR Dataset'


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


About the experiment and experiment results "raw" data set
---

The Human Activity Recognition Using Smartphones Data Set 
located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
stores the results of an experiment involving 30 subjects wearing a Samsung Galaxy 3 smartphone.

Data acknowledgements:
  UCI HAR Dataset developed by:
  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
  Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
  International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

Additional information about the formatting of the raw data set
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The phone accelorometer and gyroscope recorded movement in x,y,z axis.
The raw accelorometer and gyroscope x,y,z values has been pre-processed both to minimise the influence of movements caused by gravity, and has been filtered to extract 'noise' values.
For more information about this pre-processing see the file 'UCI HAR Dataset/features_info.txt'

