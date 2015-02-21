# run_analysis.R
# Getting and Cleaning Data
# https://class.coursera.org/getdata-007
# Course Project
# By Simon Stainsby 
# GitHub: @FunOnTheUpfield
# ----------------------------

# A program to read UCI HAR Dataset and produce summary files
# For installation instructions see ReadMe.md file in this directory.


# This script creates tidy data with the following qualities;


# Tidy data qualities
# - Each row is a observation, a value derived from smartphone measurements (as calculated by Anguita et.al. (2012)) 
# - Each variable has its own column
# - All the values form the same type of observational unit
# - Factor data (the activity labels) have human readable values, rather than code numbers. 
#   (Note that ParticpantId is also a factor value, but this remains a number code to preserve subject privacy.)

# The 'long format' (4 columns many rows) was selected because its looks better on screen.
# Wide format (480 columns) as qualifies as tidy but doesn't look as good.



# Data acknowledgements:
#  UCI HAR Dataset developed by:
#  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
#  Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
#  International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


# ----------------------------
# On simon's machine this file is located at:
#  /home/simon/Documents/git/getdata-courseproject/run_analysis.R

# ----------------------------

print("This script assumes you have downloaded, decompresed and saved the directory UCI HAR Dataset in your current working directory")
print("This script takes about 15 minutes to run.  You may want to make a cup of tea while you wait.")



# Data has been downloaded and manually unzipped.
  features <- read.table("./UCI HAR Dataset/features.txt")
  activity <- read.table("./UCI HAR Dataset/activity_labels.txt")

  testsubject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  testlabels <- read.table("./UCI HAR Dataset/test/y_test.txt")
  testmeasurements <- read.table("./UCI HAR Dataset/test/X_test.txt")
  
  trainsubject <- read.table("./UCI HAR Dataset/train/subject_train.txt" )
  trainlabels <- read.table("./UCI HAR Dataset/train/y_train.txt")
  trainmeasurements <- read.table("./UCI HAR Dataset/train/X_train.txt") 
  


# --------------------------------------------------------------------------------------------

# 1b.  Merge data into wide tidy dataset
#  Table format 
#  ParticipantID | Activity |  .... (477 Columns of PhoneMeasurement data values)
#  (10299 rows of measurements)
#


# Join the test and train versions of ParticipantID 
subjects <- rbind(testsubject, trainsubject)
names(subjects)[1] <- 'ParticipantID'
      
# Join and the test and train versions of Activity Codes
# Then replace Replace activity code numbers with Activity Labels

ActivityCode <- rbind(testlabels, trainlabels)
factivity <- factor(ActivityCode[, 1])
Activity <- factor(factivity, labels=activity$V2)

# Join the test and train versions of the phone data
# Label the columns using 'features'
# Then remove columns with duplicate column names
PhoneMeasurement <- rbind(testmeasurements, trainmeasurements)
colnames(PhoneMeasurement) <- features$V2
PhoneMeasurement <- PhoneMeasurement[, !duplicated(colnames(PhoneMeasurement))]

widetidy <- cbind (subjects,Activity,PhoneMeasurement)


# 1c. Clean up memory.
rm(testsubject, trainsubject, testlabels, trainlabels, activity, features, factivity, testmeasurements, trainmeasurements, ActivityCode)

#print(head(widetidy),1)
# --------------------------------------------------------------------------------------------
# STEP 2: Create a long tidy data set, soemthing a bit more readable.
# Each observation (including each observation in PhoneMeasurements) has its own row.

# Table format:
# ParticipantID | Activity | PhoneMeasurement | Value
# 10299 Rows 4 Columns

longtidy <-data.frame()

# This nested loop is very slow (perhaps 15min) 
#- TODO: find a vectorised (possibly using one of the "apply" functions) to do this. 

for (row in 1:nrow(PhoneMeasurement)) {
  longtidy[row,1] <- subjects$ParticipantID[row]
  longtidy[row,2] <- Activity[row]
  for (col in 1:ncol(PhoneMeasurement)) {
    longtidy[row,3] <- colnames(PhoneMeasurement[col])
    longtidy[row,4] <- PhoneMeasurement[row,col]
    }
  }

colnames(longtidy) <- c("ParticipantID", "Activity", "PhoneMeasurement", "Value")

#print(head(longtidy))

# --------------------------------------------------------------------------------------------
# STEP 3: Create mean and standard dev by phone value table (Task 2 of the assignment)
# --------------------------------------------------------------------------------------------
library(dplyr)
tbl_df(longtidy)

#phonemeasures_mean_stdev <- longtidy %>%
#  group_by(PhoneMeasurement) %>%
#  summarise(av = mean(Value), std_dev = sd(Value)) 

# Export into a tab deliniated text file  file
#write.table(phonemeasures_mean_stdev, "phonemeasures-mean-std_dev-step2.txt", sep="\t")

# --------------------------------------------------------------------------------------------
# STEP 4: Break it down by participant and activity  (Task 5 of the assignment)
# --------------------------------------------------------------------------------------------

phonemeasures_by_particpant_and_activity <- longtidy %>%
  group_by(ParticipantID, Activity) %>% 
  summarise(av = mean(Value), std_dev = sd(Value)) 

# Step 4.a: Export to tab deliniated text file.
write.table(phonemeasures_by_particpant_and_activity, "phonemeasures_by_particpant_and_activity.txt-step5.txt", sep="\t", row.names = FALSE)
