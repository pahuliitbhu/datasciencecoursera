##read features
features <- read.table("~/datasciencecoursera/UCI HAR Dataset/features.txt", quote="\"", comment.char="")

##Read test data
X_test <- read.table("~/datasciencecoursera/UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char="")
subject_test <- read.table("~/datasciencecoursera/UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char="")
activity_test <- read.table("~/datasciencecoursera/UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char="")

##change column names 
colnames(X_test) <- t(features[2])
colnames(subject_test) <- "subject"
colnames(activity_test) <- "activity"

##read training data
X_train <- read.table("~/datasciencecoursera/UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char="")
subject_train <- read.table("~/datasciencecoursera/UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char="")
activity_train <- read.table("~/datasciencecoursera/UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char="")

##change col names
colnames(X_train) <- t(features[2])
colnames(subject_train) <- "subject"
colnames(activity_train) <- "activity"

##Merge the data
dat1 <- cbind(subject_test,activity_test, X_test)
dat2 <- cbind(subject_train,activity_train,X_train)
maindata <- rbind(dat1, dat2)

##extract measurements with only the mean and standard deviation
vec <- grep("mean|std", colnames(maindata))
extractdata <- maindata[,c(1,2,vec)]

##naming activity in data set
activity_labels <- read.table("~/datasciencecoursera/UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char="")
extractdata[["activity"]] <- factor(extractdata[,"activity"], levels = activity_labels$V1, labels = activity_labels$V2)


##Creating independent tidy data set with the average of each variable for each activity and each subject.

td <- melt(extractdata, id = c("subject", "activity"))
tidydata <- dcast(td, subject + activity~variable , mean)

##storing tidy data file as txt file
write.csv(tidydata, "~/datasciencecoursera/tidydata.txt")