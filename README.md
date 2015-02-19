# getdata-courseproject
Get and clean a UCI HAR data - a dataset collected from 30 people exercising whilst wearing smartphones


How to get and clean the UCI HAR dataset using the script *run_analyis.R*
---

STEP 1: Clone a copy of *run_analysis.R* from github using the command:

```
git clone https://github.com/FunOnTheUpfield/getdata-courseproject.git
```

STEP 2 (Optional on linux machines)

Create a subdirectory called 'data'.
Manually download the UCI HAR dataset from: 
*https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip*

Manually unzip the file the file UCI_HAR_Dataset.zip
Save the decompressed folder 'UCI HAR Dataset' into the 'data' subdirectory.

Alternatively modify the code so it will create data subdirectory, download the UCI_HAR_Dataset.zip file and decomprss it.

If you are running on a Mac or Windows machine you will need to make a minor change to the code. 

Open the file *run_analysis.R* looking for the following code.

```
  download.file(fileurl, 
                method = "wget",
                destfile="data/UCI_HAR_Dataset.zip",
                mode = "wb")
```

If your are executing the code on a Mac change to method = "curl"
If your are executing the code on a Windows machine do not specify method (i.e. delete method = "wget",)

Also if running on a windows machine check to see that you have an application that can decompress zip files.

STEP 3  Execute run_analysis.R using RStudio.R

STEP 4 Go make a cup of tea.  This script takes about 15 minutes to complete execution.

OUTPUT - 

**phonemeasures-mean-sd.txt**
A tab deliniated text file listing 477 data categories collected from the smart phones with mean and standard deviation values for each data category

**phonemeasures-by-user-and-activity.txt**
A tab deliniated text file providing a user and activity breakdown for mean and standard deviation values for each of smart phone data categories.


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


Clean Data
---
The output files of *run_analyis.R* qualify as tidy data because:

- Each row is a observation, series of data points collected when a specific participant engaged in a specific activity
- Each variable has its own column - Particpant_ID, Physical_Activity or a calculated value derived from phone measurement
- All the values form the same type of observational unit namely a value recorded from a phone sensor
- Factor data (the activity labels) have human readable values, rather than code numbers. Note that particpant_id is also a factor value, but this remains a number code to preserve subject privacy.

Environment Details
---
The script run_analyis.R was developed on a gnu-linux (Ubuntu 14.14) machine running
R version 3.1.2 (Pumpkin Helmet)
