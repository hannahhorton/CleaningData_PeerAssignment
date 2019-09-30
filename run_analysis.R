library(dplyr)

#download and unzip the data

if(!file.exists("./data"))
{dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

unzip(zipfile="./data/Dataset.zip",exdir="./data")

files<-list.files('./data/UCI HAR Dataset', recursive=TRUE)

#assign files to specific variables

subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = FALSE)

#merge training and testing datasets for each variable

subject <- rbind(subject_train, subject_test)
activity<- rbind(y_train, y_test)
features<- rbind(x_train, x_test)
names(subject)<-c("subject")
names(activity)<- c("activity")
feat_names <- read.table(file.path("./data/UCI HAR Dataset" , "features.txt"),head=FALSE)
names(features)<- feat_names$V2

#binding the variables together into a single dataframe

columns <- cbind(subject, activity)
Data <- cbind(features, columns)

#extracting mean and std values for each measurement

sub_names<-feat_names$V2[grep("mean\\(\\)|std\\(\\)", feat_names$V2)]

selected_names<-c(as.character(sub_names), "subject", "activity" )
tidy_data<-subset(Data,select=selected_names)

#giving activities descriptive names

activity_labels <- read.table(file.path("./data/UCI HAR Dataset" , "activity_labels.txt"),header = FALSE)
tidy_data$activity<-factor(tidy_data$activity,labels=activity_labels[,2])

#giving features descriptive names

names(tidy_data)<-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data)<-gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data)<-gsub("^t", "Time", names(tidy_data))
names(tidy_data)<-gsub("^f", "Frequency", names(tidy_data))
names(tidy_data)<-gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data)<-gsub("-mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-freq()", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("angle", "Angle", names(tidy_data))
names(tidy_data)<-gsub("gravity", "Gravity", names(tidy_data))

#creating new, tidy dataset with extracted data and descriptive variable names and writing it into a .txt file

tidyest_data<-aggregate(. ~subject + activity, tidy_data, mean)
tidyest_data<-tidyest_data[order(tidyest_data$subject,tidyest_data$activity),]
write.table(tidyest_data, file = "tidyest_data.txt",row.name=FALSE,quote = FALSE, sep = '\t')
