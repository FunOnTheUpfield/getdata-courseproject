# run_analysis.R
# Getting and Cleaning Data
# https://class.coursera.org/getdata-007
# Course Project
# By Simon Stainsby 
# GitHub: @FunOnTheUpfield
# ----------------------------

# For installation instructions see ReadMe.md file

# Script takes the results from UCI HAR Dataset 
#(motion measurements from 30 subjects wearing Sumsung smart phones)
# and creates:
# A summary file listing the mean and standard deviation of each of the 477 data categories collected
# A summary by participant and activity file with mean and standard deviation values.

# ----------------------------

print("This script takes about 15 minutes to run.  Go make a cup of tea.")

# 1a.  Get the data

if(!file.exists("data")){
  # Create a data directory to store the raw data if required.
  dir.create("data")
}


if(!file.exists("./data/UCI HAR Dataset")){     
  # Download data there is if no local copy
  
  fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip' 
  temp<- tempfile()
  
  download.file(fileurl, 
                method = "wget",
                destfile="data/UCI_HAR_Dataset.zip",
                mode = "wb")
  
  # Unzip the files and read into R.  
  unzip("data/UCI_HAR_Dataset.zip")


  features <- read.table(unz(temp, "./data/UCI HAR Dataset/features.txt"))
  activitylabels <- read.table(unz(temp, "./data/UCI HAR Dataset/activity_labels.txt"))
  
  testsubject <- read.table(unz(temp, "./data/UCI HAR Dataset/test/subject_test.txt" ))
  testlabels <- read.table(unz(temp, "./data/UCI HAR Dataset/test/y_test.txt"))
  testset <- read.table(unz(temp, "./data/UCI HAR Dataset/test/X_test.txt"))
  
  trainsubject <- read.table(unz(temp, "./data/UCI HAR Dataset/train/subject_train.txt" ))
  trainlabels <- read.table(unz(temp, "./data/UCI HAR Dataset/train/y_train.txt"))
  trainset <- read.table(unz(temp, "./data/UCI HAR Dataset/train/X_train.txt" )) 
  
  unlink(temp)
  
}else{
  # Data has been downloaded and manually unzipped.
  features <- read.table("./data/UCI HAR Dataset/features.txt")
  activitylabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
  
  testsubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
  testlabels <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
  testmeasurements <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
  
  trainsubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt" )
  trainlabels <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
  trainmeasurements <- read.table("./data/UCI HAR Dataset/train/X_train.txt") 
  
}

# Data acknowledgements:
#  UCI HAR Dataset developed by:
#  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
#  Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
#  International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012


# --------------------------------------------------------------------------------------------

# 1b.  Merge data into tidy dataset

# Join the test and train versions of ParticipantID 
subjects <- rbind(testsubject, trainsubject)
#factor(subjects)
names(subjects)[1] <- 'ParticipantID'
      
# Join and the test and train versions of Activity Codes
# Then replace Replace activity code numbers with Activity Labels

ActivityCode <- rbind(testlabels, trainlabels)
factivity <- factor(ActivityCode[, 1])
Activity <- factor(factivity, labels=activitylabels$V2)

# Join the test and train versions of the phone data
# Label the columns using 'features'
# Then remove columns with duplicate column names
PhoneMeasurement <- rbind(testmeasurements, trainmeasurements)
colnames(PhoneMeasurement) <- features$V2
PhoneMeasurement <- PhoneMeasurement[, !duplicated(colnames(PhoneMeasurement))]

# Create Wide Tidy dataset
#  Table format 
#  ParticipantID | Activity |  .... (477 Columns of PhoneMeasurement data values)
#  (10299 rows of measurements)
#

widetidy <- cbind (subjects,Activity,PhoneMeasurement)


# 1c. Clean up memory.
rm(testsubject, trainsubject, testlabels, trainlabels, activitylabels, features, factivity, testmeasurements, trainmeasurements, ActivityCode)


# --------------------------------------------------------------------------------------------
# STEP 2: Create a summary table showing the mean and standard deviation
#         for each of the PhoneMeasurement columns

average <- sapply(widetidy[,3:ncol(widetidy)],mean)
sigma <- (sapply(widetidy[,3:ncol(widetidy)],sd))
datasummary <- data.frame(average, sigma)

# Export into a csv file
write.table(datasummary, "output/phonemeasures-mean-sd.txt", sep="\t")

# --------------------------------------------------------------------------------------------
# STEP 3: Create a summary table sorted first by participant, then by activity
#         showing the mean and standard deviation for each of the values in PhoneMeasurement

# 3.a Create 'Long' tidy data frame

# Each observation (including each observation in PhoneMeasurements) has its own row.

# Table format:
# ParticipantID | Activity | PhoneMeasurement | Value
# 10299 Rows 4 Columns

longtidy <-data.frame()

# This nexted loop is very slow (perhaps 15min) 
#- perhaps there's an "apply" way of doing this.

for (row in 1:nrow(PhoneMeasurement)) {
  longtidy[row,1] <- subjects$ParticipantID[row]
  longtidy[row,2] <- Activity[row]
  for (col in 1:ncol(PhoneMeasurement)) {
    longtidy[row,3] <- colnames(PhoneMeasurement[col])
    longtidy[row,4] <- PhoneMeasurement[row,col]
    }
  }

colnames(longtidy) <- c("ParticipantID", "Activity", "PhoneMeasurement", "Value")

print(head(longtidy))

# --------------------------------------------------------------------------------------------
# STEP 4: Create summary by mean, summary by st_dev 
#         showing the mean and standard deviation for each of the values in PhoneMeasurement


phonemeasures_by_particpant_and_activity %>%
  group_by(ParticipantID, Activity) %>% 
  summarise(av = mean(Value), std_dev = sd(Value))

# Step 4.a: Export to tab deliniated text file.
write.table(datasummary, "output/phonemeasures_by_particpant_and_activity.txt", sep="\t")


# Tidy data qualities
# - Each row is a observation, a value calculated by Anguita et.al. (2012) 
# - Each variable has its own column
# - All the values form the same type of observational unit
# - Factor data (the activity labels) have human readable values, rather than code numbers. 
#   (Note that ParticpantId is also a factor value, but this remains a number code to preserve subject privacy.)

# The long (4 columns) is also printable on screen and paper printable
# Wide (480 columns) qualifies as tidy for processing, but doesn't look as good.
