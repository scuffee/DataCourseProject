#no inputs requried with this function
#Please verify the library packages below are installed before running the script

run_analysis <- function()
{
 
  library(httr)
  library(utils)
  library(data.table)
  library(plyr)
  library(dplyr)
  library (tidyr)
  library(stringr)
  library(reshape2)
#-------------------------------------------------------------------------------------------------------  

#Check to see if requred directory exists, if not create it.  
  
  if(!file.exists("C:/Users/Owner/Documents/specdata"))
  {
    dir.create("C:/Users/Owner/Documents/specdata")
  }
  
#----------------------------------------------------------------------------------------------------------------------
#Select file to be downloaded
 #fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#Download the file to the console
  #download.file(fileUrl, destfile = "C:/Users/Owner/Documents/specdata/2FUCI%20HAR%20Dataset.zip", method = "libcurl")
#Record the date and time the file was downloaded
  #dateDownLoaded <- date()
  print("Date the files were downloaded:")
  #print(dateDownLoaded)
  #print(list.files("C:/Users/Owner/Documents/specdata"))
#Uzip the file
  #unzip("C:/Users/Owner/Documents/specdata/2FUCI%20HAR%20Dataset.zip")
  
#----------------------------------------------------------------------------------------------------------------------
#Read the data files
  tableActivityLabels <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/activity_labels.txt")
  tableFeatures <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/features.txt")
  tableTest_X <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/test/x_test.txt")
  tableTestLabels<- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/test/y_test.txt")
  tableTrain_X <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/train/x_train.txt")
  tableTrainLabels <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/train/y_train.txt")
  tableSubjectTest <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/test/subject_test.txt")
  tableSubjectTrain <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/train/subject_train.txt")
#------------------------------------------------------------------------------------------------------------------
#Merge the training and the test data to create one data set.
  tableCombineX <- rbind(tableTest_X, tableTrain_X) # combine the train and test data by
  tableCombineLabels <- rbind(tableTestLabels, tableTrainLabels) # combine train and test Activities by row
  tableCombineSubjectID <- rbind(tableSubjectTest, tableSubjectTrain)# Combine test subject ID
  tableCombineLabelsRename <- rename(tableCombineLabels, c("V1" = "Activity")) #rename column with Test Subject Activity
  tableCombineSubjectIDRename <- rename(tableCombineSubjectID, c("V1" = "TestSubjectID"))#rename   coulm with Test Subject ID number
  tableData <- cbind(tableCombineX, tableCombineLabelsRename, tableCombineSubjectIDRename) #data combined in one dataset
 
#--------------------------------------------------------------------------------------------------
#Extract the measurements on the mean and standard deviation for each measurement from the new dataset.

   tableDataScrub <- select(tableData, c(TestSubjectID, Activity, 1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266:271, 
                                        345:350, 424:429, 503, 504, 516, 517, 529, 530, 542, 543))
 
  #Rename the Activity and Features columns for clarification
  
  tableDataScrubTwo <- rename(tableDataScrub, c("V1" = "tBodyAcc-meanX", "V2" = "tBodyAcc-meanY", "V3" = "tBodyAcc-meanZ",
                                                "V4" = "tBodyAcc-stdX", "V5" = "tBodyAcc-stdY", "V6" = "tBodyAcc-stdZ",
                                                "V41" = "41 tGravityAcc-meanX", "V42" = "tGravityAcc-meanY", "V43" = "tGravityAcc-meanZ",
                                                "V44" = "tGravityAcc-stdX", "V45" = "41 tGravityAcc-stdY", "V46" = "tGravityAcc-stdZ",
                                                "V81" = "tBodyAccJerk-meanX", "V82" = "tBodyAccJerk-meanY", "V83" = "tBodyAccJerk-meanZ",
                                                "V84" = "tBodyAccJerk-stdX", "V85" = "tBodyAccJerk-stdY", "V86" = "tBodyAccJerk-stdZ",
                                                "V121" = "tBodyGyro-meanX", "V122" = "tBodyGyro-meanY", "V123" = "tBodyGyro-meanZ",
                                                "V124" = "tBodyGyro-stdX","V125" = "tBodyGyro-stdY", "V126" = "tBodyGyro-stdZ",
                                                "V161" = "tBodyGyroJerk-meanX", "V162" = "tBodyGyroJerk-meanY", "V163" = "tBodyGyroJerk-meanZ",
                                                "V164" = "tBodyGyroJerk-stdX", "V165" = "tBodyGyroJerk-stdY", "V166" = "tBodyGyroJerk-stdZ",
                                                "V201" = " tBodyAccMagmean", "V202" = " tBodyAccMagstd", "V214" = "tGravityAccMagmean", "V215" = "tGravityAccMagstd",
                                                "V227" = "tBodyAccJerkMag-mean", "V228" = "tBodyAccJerkMag-std", "V240" = "tBodyGyroMag-mean", "V241" = "tBodyGyroMag-std",
                                                "V253" = "tBodyGyroJerkMag-mean", "V254" = "tBodyGyroJerkMag-std", "V266" = "fBodyAcc-meanX", "V267" = "fBodyAcc-meanY",
                                                "V268" = "fBodyAcc-meanZ", "V269" = "fBodyAcc-stdX", "V270"= "fBodyAcc-stdY", "V271"= "fBodyAcc-stdZ",
                                                "V345" = "fBodyAccJerk-meanX", "V346" = "fBodyAccJerk-meanY", "V347" = "fBodyAccJerk-meanZ",
                                                "V348" = "fBodyAccJerk-stdX", "V349" = "fBodyAccJerk-stdY", "V350" ="fBodyAccJerk-stdZ",
                                                "V424" = "fBodyGyro-meanX", "V425" = "fBodyGyro-meanY", "V426" = "fBodyGyro-meanZ", "V427" = "fBodyGyro-stdX",
                                                "V428" = "fBodyGyro-stdY", "V429" = "fBodyGyro-stdZ", "V503" = "fBodyAccMag-mean", "V504" = "fBodyAccMag-std",
                                                "V516" = "fBodyBodyAccJerkMag-mean", "V517" = "fBodyBodyAccJerkMag-std", "V529" = "fBodyBodyGyroMag-mean",
                                                "V530" = "fBodyBodyGyroMag-std", "V542" = "fBodyBodyGyroJerkMag-mean", "V543" = "fBodyBodyGyroJerkMag-std"))
  
  
  tableDataScrubTwo$TestSubjectID
  
   
    
#----------------------------------------------------------------------------------------------------
  
#Independent tidy data set with the average of each variable for each activity and each subject
  
  
  
  
}