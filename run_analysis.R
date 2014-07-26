##load required packages
require(reshape2)

##Skip download and upzip steps if the dataset is already downloaded and unzipped
        ##download the dataset
        url <- ("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
        download.file(url, "HAR.zip")
        dateDownloaded<-date()

        ##unzip the dataset
        unzip("HAR.zip")

##re-set working directory to unzipped file
setwd("~/UCI HAR Dataset")

##Load the files
features<-read.table("features.txt")
activitylabels<-read.table("activity_labels.txt")
xtrain<-read.table("train/x_train.txt")
ytrain<-read.table("train/y_train.txt")
subjecttrain<-read.table("train/subject_train.txt")
xtest<-read.table("test/X_test.txt")
ytest<-read.table("test/y_test.txt")
subjecttest<-read.table("test/subject_test.txt")

##Link names to variables
colnames(xtrain)<-features$V2
colnames(xtest)<-features$V2
colnames(ytrain)<-c("Activity")
colnames(ytest)<-c("Activity")
colnames(subjecttrain)<-c("Subject")
colnames(subjecttest)<-c("Subject")

##Merge the training and test sets to create one data set
train<-cbind(ytrain, subjecttrain, xtrain)
test<-cbind(ytest, subjecttest, xtest)
data<-rbind(train, test)

##Identify columns with means or standard deviations, ignoring mean frequencies and angles, and including columns with subject and activity data
mstd<-grep("Activity|Subject|mean\\(\\)|std\\(\\)", names(data))

##Subset to include only the mean and standard deviations for each measurement
fdata<-data[, mstd]

##Rename items in the activity column to make them more descriptive
fdata$Activity<-gsub("1", "walking", fdata$Activity)
fdata$Activity<-gsub("2", "walkingupstairs", fdata$Activity)
fdata$Activity<-gsub("3", "walkingdownstairs", fdata$Activity)
fdata$Activity<-gsub("4", "sitting", fdata$Activity)
fdata$Activity<-gsub("5", "standing", fdata$Activity)
fdata$Activity<-gsub("6", "laying", fdata$Activity)

##Rename the variables to make them more descriptive
names(fdata)<-gsub("^t", "TimeSignals", names(fdata),)
names(fdata)<-gsub("Acc", "Acceleration", names(fdata),)
names(fdata)<-gsub("Gyro", "Velocity", names(fdata),)
names(fdata)<-gsub("Mag", "Magnitude", names(fdata),)
names(fdata)<-gsub("-X", "Xaxis", names(fdata),)
names(fdata)<-gsub("-Y", "Yaxis", names(fdata),)
names(fdata)<-gsub("-Z", "Zaxis", names(fdata),)
names(fdata)<-gsub("^f", "FrequencySignals", names(fdata),)
names(fdata)<-gsub("-mean\\(\\)", "Mean", names(fdata),)
names(fdata)<-gsub("-std\\(\\)", "StandardDeviation", names(fdata),)
names(fdata)<-gsub("BodyBody", "Body", names(fdata),)

##Create a separate data set with the average of each variable for each activity and each subject
summarydata<-aggregate(fdata[3:68], by=list(fdata$Subject, fdata$Activity), FUN=mean, na.rm=TRUE)

##Rename variables in the tidy data set
names(summarydata)<-sub("Group.1", "Subject", names(summarydata),)
names(summarydata)<-sub("Group.2", "Activity", names(summarydata),)

##Reorder tidy data set by subject and activity
tidydata<-summarydata[with(summarydata, order(Subject, Activity)),]
row.names(tidydata)<-seq(nrow(tidydata))

##Write tidy data to a .txt file
write.table(tidydata, "tidydata.txt")
