# run_analysis.R

# --------------------------------------------------------------------------------------------

# STEP 1 Merge the training and the test sets to create one data set.

# --------------------------------------------------------------------------------------------

# 1.a Download the data
fileurl <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip' 
temp<- tempfile()
  
download.file(fileurl,
              temp, 
              method = "wget",
              mode = "wb")
  
features <- read.table(unz(temp, "UCI HAR Dataset/features.txt"))
activity <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"))

testsubject <- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt" ))
testlabels <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))
testset <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
  
trainsubject <- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt" ))
trainlabels <- read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))
trainset <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt" )) 
  
unlink(temp)


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
PhoneMeasurement <- rbind(testset, trainset)
colnames(PhoneMeasurement) <- features$V2

widetidy <- cbind (subjects,Activity,PhoneMeasurement)



# --------------------------------------------------------------------------------------------

# STEP 2 Extract only the measurements on the mean and standard deviation for each measurement.

# --------------------------------------------------------------------------------------------
# i.e. find and keep only the columns containing  "-mean()" or "-std()"

GoodMeasurements <- PhoneMeasurement[, grepl("-mean()", features$V2)|grepl("-std()", features$V2)]
widetidy <- cbind (subjects,Activity,GoodMeasurements)

# Clean up memory

rm(ActivityCode,GoodMeasurements,PhoneMeasurement,
   activity,features,subjects,testlabels,testset,trainset,testsubject,trainsubject)


# --------------------------------------------------------------------------------------------

# STEPS 3 & 4 Convert Data Lables to something human readable.

# --------------------------------------------------------------------------------------------

time <- gsub('^t', 'time.', names(widetidy))
fft <- gsub('^f', 'frequency.domain.signal.', time)
bodybody <- gsub('BodyBody', 'Body', fft)
body <- gsub('Body', 'body.', bodybody)
accelerometer <- gsub('Acc', 'accelerometer.', body)
gyroscope <- gsub('Gyro', 'gyroscope.', accelerometer)
gravity <- gsub('Gravity', 'gravity.', gyroscope)
jerk <- gsub('Jerk', 'jerk.', gravity)
mag <- gsub('Mag','magnitude.',jerk)
freq <- gsub('Freq\\(\\)', 'frequency.', mag)
mean <- gsub('-mean\\(\\)', 'mean.', freq)
std <- gsub('-std\\(\\)', 'standard.deviation.', mean)
x_axis <-gsub('-X', 'x.axis', std)
y_axis <-gsub('-Y', 'y.axis', x_axis)
human_readable <-gsub('-Z', 'z.axis', y_axis)

names(widetidy) <- human_readable

write.table(widetidy, "get_clean_data_course_project_widetidy.txt", sep="\t", row.names = FALSE)

rm(time,fft,bodybody,body,accelerometer,gyroscope,gravity,jerk,mag,freq,mean,std,x_axis,y_axis)

# --------------------------------------------------------------------------------------------

# STEPS 5 From the data set in step 4, creates a second, independent tidy data set 
#         with the average of each variable for each activity and each subject..

# --------------------------------------------------------------------------------------------
sortedoutput <- aggregate(widetidy[3:length(widetidy)], 
                          by = widetidy[c("ParticipantID", "Activity")],
                          FUN = mean)

# Update the human readable names from widetidy add 'average' to all the phonedata values.
names(sortedoutput)[3:length(sortedoutput)] <- paste("average", 
                                                     names(sortedoutput)[3:length(sortedoutput)],
                                                     sep=".")

write.table(sortedoutput, "get_clean_data_course_project_output.txt", sep="\t", row.names = FALSE)
