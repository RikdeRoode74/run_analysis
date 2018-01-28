Run_Analysis <- function()
{
  library ("dplyr")
  #download the dataset en unpack it in a working directory
  setwd("E:\\R work")
  if(!file.exists("PhoneData")){
    dir.create("PhoneData")
  }
  setwd("E:\\R work\\PhoneData")
  
  filename <- "Dataset.zip"
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile=filename)
  dateDownloaded <- date()
  
  unzip(filename)
  # get headers from features.txt
  headers <- read.csv("UCI HAR Dataset\\features.txt", sep=" ", stringsAsFactors=FALSE, header = FALSE)[,2]
  # find all headers with either mean() of std() in the name
  relevantHeaders <- grepl("mean()|std()", headers)
  relevantHeaderNames <- headers[relevantHeaders]
  
  # read datasets, apply headers and filter on relevant headers
  trainx <- read.fwf("UCI HAR Dataset\\train\\X_train.txt", widths = rep(16, 561), col.names = headers)[,relevantHeaders]
  colnames(trainx) <- relevantHeaderNames
  testx <- read.fwf("UCI HAR Dataset\\test\\X_test.txt", widths = rep(16, 561), col.names = headers)[,relevantHeaders]
  colnames(testx) <- relevantHeaderNames

  # combine train en test sets
  allx <- bind_rows(trainx, testx)
  
  # read and combine subject sets
  trainsubject <- read.csv("UCI HAR Dataset\\train\\subject_train.txt", header = FALSE)[[1]]
  testsubject <- read.csv("UCI HAR Dataset\\test\\subject_test.txt", header = FALSE)[[1]]
  subject <- c(trainsubject, testsubject)
  # and add it as first row to the dataframe
  allx <- cbind(subject, allx)

  # read and combine  train en test activity sets
  trainy <- read.fwf("UCI HAR Dataset\\train\\y_train.txt", widths = rep(1, 1))[[1]]
  testy <- read.fwf("UCI HAR Dataset\\test\\y_test.txt", widths = rep(1, 1))[[1]]
  ally <- c(trainy, testy)
  #transform integers into activities
  activities <- read.csv("UCI HAR Dataset\\activity_labels.txt", sep=" ", header = FALSE)
  translationVector <- activities[[2]]
  names(translationVector) <- activities[[1]]
  activity <- translationVector[ally]
  # and add it as first row to the dataframe
  allx <- cbind(activity, allx)
  
  # group by activity and subject and then take means
  result <- allx %>%
    group_by(activity, subject) %>%
    summarise_all(mean)
  
  # write it all to 1 txt
  write.table(result, row.name=FALSE, file = "tidyPhoneData.txt")
}