the data was retreived from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
The file was downloaded to R studio version 3.2.0ann unzipped to Windows 7 OS directory 
C:/Users/Owner/Documents/specdata and the tables below were read.
read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/activity_labels.txt")
read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/features.txt")
read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/test/x_test.txt")
read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/test/y_test.txt", colClasses = "character")
read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/train/x_train.txt")
read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/train/y_train.txt", colClasses = "character")
read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/test/subject_test.txt")
read.table("C:/Users/Owner/Documents/specdata/UCI HAR Dataset/train/subject_train.txt")

Labels 
tableTestLabels  and tableTextLabels were converted from inter data to character data and combined into one table called tableCombineLabels and consisted of values 1 through 6. tableCombineLabels column V1 was renamed Activity and the values in the column were renamed as listed below:
1=  WALKING
2 =  WALKING_UPSTAIRS
3=  WALKING_DOWNSTAIRS
4=  SITTING
5=  STANDING
6=  LAYING

Feature Selection 
=================
tableTest_X and tableTrain_X were combined in tableCombineX consists the test data of all 30 participants. A 561-feature vector with time and frequency domain variables. The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.  

tableSubjectTrain and tableSubjectTest were combined in tableCombineeSubjectID.  This table consisted of an identifier of the subject who carried out the experiment.  V1 was renamed TestSubjectID.  tablecombineLabels and tableCombineSubjectID were combined to create one data table called tableData.   


A subset of 66 features were selected from tableData and renamed in tableDataScrub:  tBodyAccmeanX = V1, tBodyAccmeanY = V2, tBodyAccmeanZ = V3,
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
  
The data in tableDataScrub was arranged by the subject ID number and activity.  The data was also group by subject ID and activity, summarized using the mean of each activity per subject and written to text file tidydata.txt.

The tidydata.txt file was read as a table and made user friendly viewable in R studio file FinalDataSet.