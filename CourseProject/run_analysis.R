#no inputs requried with this function
#Please verify the library packages below are installed before running the script

run_analysis <- function()
{
 
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
#print("Date the files were downloaded:")
#print(dateDownLoaded)
#print(list.files("C:/Users/Owner/Documents/specdata"))
#Uzip the file
#unzip("C:/Users/Owner/Documents/specdata/2FUCI%20HAR%20Dataset.zip")
  
#----------------------------------------------------------------------------------------------------------------------
#Read the data files
  tableActivityLabels <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/activity_labels.txt")
  tableFeatures <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/features.txt")
  tableTest_X <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/test/x_test.txt")
  tableTestLabels<- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/test/y_test.txt", colClasses = "character")
  tableTrain_X <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/train/x_train.txt")
  tableTrainLabels <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/train/y_train.txt", colClasses = "character")
  tableSubjectTest <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/test/subject_test.txt")
  tableSubjectTrain <- read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/train/subject_train.txt")
#------------------------------------------------------------------------------------------------------------------
#Merge the training and the test data to create one data set.
  tableCombineX <- rbind(tableTest_X, tableTrain_X) # combine the train and test data by
  tableCombineLabels <- rbind(tableTestLabels, tableTrainLabels) # combine train and test Activities by row
  tableCombineLabels <- rename(tableCombineLabels, Activity = V1) #rename column with Test Subject Activity
  tableCombineLabels$Activity <- gsub("1", "                  Walking", tableCombineLabels$Activity) #rename activity 1 walking
  tableCombineLabels$Activity <- gsub("2", "          WalkingUpStairs", tableCombineLabels$Activity) #rename activit 2 walkink up stairs
  tableCombineLabels$Activity <- gsub("3", "        WalkingDownStairs", tableCombineLabels$Activity) # rename activity 3 walkin down stairs
  tableCombineLabels$Activity <- gsub("4", "                  Sitting", tableCombineLabels$Activity) # rename activity 4 sitting
  tableCombineLabels$Activity <- gsub("5", "                 Standing", tableCombineLabels$Activity) # rename activity 5 standing
  tableCombineLabels$Activity <- gsub("6", "                   Laying", tableCombineLabels$Activity) #vvrename activity 6 laying
  tableCombineSubjectID <- rbind(tableSubjectTest, tableSubjectTrain)# Combine test subject ID
  tableCombineSubjectID <- rename(tableCombineSubjectID, TestSubjectID = V1)#rename   coulm with Test Subject ID number
  tableData <- cbind(tableCombineX, tableCombineLabels, tableCombineSubjectID) #data combined in one dataset
  
#--------------------------------------------------------------------------------------------------
#Extract the measurements on the mean and standard deviation for each measurement from the new dataset.

 tableDataScrub <- select(tableData, c(TestSubjectID, Activity, 1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 215, 227, 228, 240, 241,253,254, 266:271, 
                                                                345:350, 424:429, 503, 504, 516, 517, 529, 530, 542, 543))
 
#Rename the Features columns for clarification

  
 tableDataScrub <- rename(tableDataScrub, tBodyAccmeanX = V1, tBodyAccmeanY = V2, tBodyAccmeanZ = V3,
                                          tBodyAccstdX = V4, tBodyAccstdY = V5, tBodyAccstdZ = V6,
                                          tGravityAccmeanX = V41,tGravityAccmeanY = V42, tGravityAccmeanZ = V43,
                                          tGravityAccstdX = V44, tGravityAccstdY = V45, tGravityAccstdZ = V46,
                                          tBodyAccJerkmeanX = V81, tBodyAccJerkmeanY = V82, tBodyAccJerkmeanZ = V83,
                                          tBodyAccJerkstdX = V84, tBodyAccJerkstdY = V85, tBodyAccJerkstdZ = V86,
                                          tBodyGyromeanX = V121, tBodyGyromeanY = V122, tBodyGyromeanZ = V123,
                                          tBodyGyrostdX = V124,tBodyGyrostdY = V125, tBodyGyrostdZ = V126,
                                          tBodyGyroJerkmeanX = V161, tBodyGyroJerkmeanY = V162, tBodyGyroJerkmeanZ = V163,
                                          tBodyGyroJerkstdX = V164, tBodyGyroJerkstdY = V165, tBodyGyroJerkstdZ = V166,
                                          tBodyAccMagmean = V201, tBodyAccMagstd = V202, GravityAccMagmean = V214, tGravityAccMagstd = V215,
                                          tBodyAccJerkMagmean = V227, tBodyAccJerkMagstd = V228, tBodyGyroMagmean = V240, tBodyGyroMagstd = V241,
                                          tBodyGyroJerkMagmean = V253, tBodyGyroJerkMagstd = V254, fBodyAccmeanX = V266,fBodyAccmeanY = V267,
                                          fBodyAccmeanZ = V268, fBodyAccstdX = V269, fBodyAccstdY = V270, fBodyAccstdZ = V271,
                                          fBodyAccJerkmeanX = V345, fBodyAccJerkmeanY = V346, BodyAccJerkmeanZ = V347,
                                          fBodyAccJerkstdX = V348, fBodyAccJerkstdY = V349, fBodyAccJerkstdZ = V350,
                                          fBodyGyromeanX = V424, fBodyGyromeanY = V425, fBodyGyromeanZ = V426, fBodyGyrostdX = V427,
                                          fBodyGyrostdY = V428, fBodyGyrostdZ = V429, fBodyAccMagmean = V503, fBodyAccMagstd = V504,
                                          fBodyBodyAccJerkMagmean = V516, fBodyBodyAccJerkMagstd = V517, fBodyBodyGyroMagmean = V529,
                                          fBodyBodyGyroMagstd = V530, fBodyBodyGyroJerkMagmean = V542, fBodyBodyGyroJerkMagstd = V543)
  
  
 
  
   
    
#----------------------------------------------------------------------------------------------------
  
#Independent tidy data set with the average of each variable for each activity and each subject
  
  
tableDataScrub <- arrange(tableDataScrub, TestSubjectID, Activity) #arrange data by subject Id and actvity
testSubject <- group_by(tableDataScrub, TestSubjectID,Activity) #group the activity by subject ID
tidyData <- summarize(testSubject, ActivityAverage = mean(tBodyAccmeanX : fBodyBodyGyroJerkMagstd))
write.table(tidyData, file = "tidydata.txt",sep = "  ", row.names = FALSE) #print the results to the tidyData.txt file 
}