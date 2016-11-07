setwd("/Users/aha/Documents/DSU")
unzip("getdata%2Fprojectfiles%2FUCI HAR Dataset.zip")
setwd("/Users/aha/Documents/DSU/UCI HAR Dataset")

## Reading the features file in. Filtering out everything that doesn't contain "mean" or "std"
features      = read.table("/Users/aha/Documents/DSU/UCI\ HAR\ Dataset/features.txt")
meanFeatures  = features[grep("mean", features$V2), ]
stdFeatures   = features[grep("std", features$V2), ]
meansStdFeatures = rbind(meanFeatures, stdFeatures)

## Reading the X files in, subsetting them using the array in column 1 of meansStdFeatures. Combining files and assigning column names
trainX        = read.table("/Users/aha/Documents/DSU/UCI\ HAR\ Dataset/train/X_train.txt", header = FALSE)[meansStdFeatures$V1]
testX         = read.table("/Users/aha/Documents/DSU/UCI\ HAR\ Dataset/test/X_test.txt", header = FALSE)[meansStdFeatures$V1]
allX = rbind(trainX, testX)
colnames(allX) = t(meansStdFeatures$V2)

## Reading the subject files in and combining them
trainSubject  = read.table("/Users/aha/Documents/DSU/UCI\ HAR\ Dataset/train/subject_train.txt", header = FALSE)
testSubject   = read.table("/Users/aha/Documents/DSU/UCI\ HAR\ Dataset/test/subject_test.txt", header = FALSE)
allSubject = rbind(trainSubject, testSubject)

## Reading the Y files in and combining them
testY         = read.table("/Users/aha/Documents/DSU/UCI\ HAR\ Dataset/test/y_test.txt", header = FALSE)
trainY        = read.table("/Users/aha/Documents/DSU/UCI\ HAR\ Dataset/train/y_train.txt", header = FALSE)
allY = rbind(trainY,testY)

## Combining all files
combinedData = cbind(allSubject, allY, allX)
colnames(combinedData)[1] = "Subject"
colnames(combinedData)[2] = "Y"


## Reading in activities file
activities    = read.table("/Users/aha/Documents/DSU/UCI\ HAR\ Dataset/activity_labels.txt")

## Replacing 1-6 with their respective activities
combinedData$Y <- factor(combinedData$Y, levels = activities[,1], labels = activities[,2])

## Tidying up dataset and reassigning names
tidy = aggregate(combinedData[, 3:81], list(combinedData$Subject, combinedData$Y), mean)
colnames(tidy)[1] = "Subject"
colnames(tidy)[2] = "Activity"
