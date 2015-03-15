# Set up the working environment
#--------------------------------------

# Set up directory
dirData <- "./data"
if (!file.exists(dirData)) {dir.create(dirData)}

# Download and store
fileURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile="./data/projectdata.zip")
setwd(dirData)
unzip("projectdata.zip")
setwd("./UCI_HAR_Dataset")

# Merges the training and the test sets to create one data set.
#------------------------------------------------------------

# Read tables
x.train<-read.table("./train/X_train.txt")
x.test<-read.table("./test/X_test.txt")

y.train<-read.table("./train/y_train.txt")
y.test<-read.table("./test/y_test.txt")

sub.train<-read.table("./train/subject_train.txt")
sub.test<-read.table("./test/subject_test.txt")

activity<-read.table("./activity_labels.txt")

features<-read.table("./features.txt")

# Merge training and testing sets and set column names
x.all <-rbind(x.test,x.train)
colnames(x.all) <- (features[,2])

y.all <- rbind(y.test,y.train)
names(y.all) <- "activity"

sub <- rbind(sub.test, sub.train)
names(sub) <- "subject"

# Merge into one data set
dat <- cbind(sub,y.all,x.all)

# Extracts only the measurements on the mean and standard deviation for each measurement. 
#----------------------------------------------------------------------------------------

#Extract mean and standard deviation
dat.avg <- apply(dat[3:563], 2, mean) 
dat.sd <- apply(dat[3:563], 2, sd) 

#Combine into one aggregate
dat.agg <- cbind(dat.avg,dat.sd)

#----------------------------------------------------------------------------------------

# Appropriately labels the data set with descriptive variable names. 
dat$activity[which(dat$activity == 1)] <- 'Walking'
dat$activity[which(dat$activity == 2)] <- 'Walking upstairs'
dat$activity[which(dat$activity == 3)] <- 'Walking downstairs'
dat$activity[which(dat$activity == 4)] <- 'Sitting'
dat$activity[which(dat$activity == 5)] <- 'Standing'
dat$activity[which(dat$activity == 6)] <- 'Laying'

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dat.tidy <- aggregate( dat[,3] ~ subject+activity, data = dat, FUN= "mean" )

for(i in 4:ncol(dat)){
  dat.tidy[,i] <- aggregate( dat[,i] ~ subject+activity, data = dat, FUN= "mean" )[,3]
}

# Copy over colnames
colnames(dat.tidy) <- colnames(dat)

# Write
write.table(dat.tidy, file = "tidy.txt",)


