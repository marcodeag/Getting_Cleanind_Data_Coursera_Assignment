---
title: "CodeBook for Getting and Cleaning Data Coursera Project Assignment"
author: "Marco De Agostini"
date: "Wednesday, August 20, 2014"
output: html_document
---

###Introduction###
This file is oriented to describe all variables of the output dataset of the script "run_analysis.R", which has been implemented as final deliverable for the "Getting and Cleaning Data Coursera" course project assignment.

The file must be consider as a part of a code package composed by:

* run_analysis.R file
* Readme.md file
* CodeBook.md file

###The structure of the run_analysis.R script output tidy dataset###
The output dataset of the "run_analysis.R" consists into a tidy dataset in wide form and it is obtained computing raw data collected by "Smartlab - Non Linear Complex Systems Laboratory" in an experiment of "Human Activity Recognition Using Smartphones Data Set".

The output dataset contains for each couple [Subject performing the activity, Activity performed] the means of all collected samples of all the measures and preprocessed accelarometer and gyroscope signals coming from raw datasets (test and traing datasets) whose names contain the substrings "mean()" or "std()".

The tidy wide dataset is characterised by:

* 68 variables (Subject, Activity Descriptive names and 66 features)
* As many rows as the number of observations that can be obtained grouping raw provided data per Subject and Activity Descriptive Names; if any subject performs all the activities, the observation units will be = 30 sbj x 6 activities = 180 observation units.

A detailed description of each variable in the tidy dataset will be provided into the "Variables description" paragraph.

###The source data###
The original data have been provided by "Smartlab - Non Linear Complex Systems Laboratory" and they consists into full set of observations collected from the accelerometers from the Samsung Galaxy S smartphone, on 30 individuals while performing 6 different types of activities (i.e. "Walking Upstairs", "Standing"...)

The original data can be obtained uncompressing the "getdata-projectfiles-UCI HAR Dataset.zip", available at the following link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Among the files inside the zip file, the transformation process applied by the "run_analysis.R" uses:

* //UCI HAR Dataset//test//X_test.txt
* //UCI HAR Dataset//train//X_train.txt
* //UCI HAR Dataset//features.txt
* //UCI HAR Dataset//test//y_test.txt
* //UCI HAR Dataset//train//y_train.txt
* //UCI HAR Dataset//activity_labels.txt
* //UCI HAR Dataset//test//subject_test.txt
* //UCI HAR Dataset//train//subject_train.txt

A detailed description of the sourcing files can be found browsing the original website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

###The applied transformation process###
The transformation process applied by the run_analysis.R can be summarised in the following steps

Step |  Step Name | Output | Relevant Notes
:----: | :------ |:-----| :------------------------------
01| Merge of training and test measures datasets | A dataframe named "Data_DF" with all the training and test raw measures | Merge can be perfomed only if test and traing data have the same column numbers (561 columns)
02| Obtaining the variables names of raw measures data | A dataframe named "Features_DF" with all the variables names of the raw measures | -                      
03| Adding variables names to the raw measures dataframe | Updated "Data_DF" dataframe with all raw measures data and relative original variable names | Variable names can be added only if feature names data and raw measures dataframe have the same column numbers (561 columns)
04| Subsetting the raw measures data frame| Updated "Data_DF" with all raw measures data, all relative original variable names but only "mean()" and "std()" variables| Only features with 'mean()' or 'std()' in their name are extracted, features that contain only the substring 'mean' (without brackets '()') in their name are excluded under the assumption that the measurements were not really means 
05| Getting and merging activity codes for raw data observations|A dataframe named "Act_DF" with all activity codes associated to the training and test raw measures| Merge can be perfomed only if test and traing data have the same column numbers
06| Getting activity codes and activity names redefinition | A dataframe with activity codes and new activity descriptive names| Activity original names are converted in a more readable and friendly format (converting uppercase, removing underscore characters ecc.)
07| Getting activity descriptive names for raw observations| Updated "Act_DF" dataframe with all activity codes associated to the training and test raw measures and new activity descriptive names are available|-
08| Getting subjects for raw observations|A dataframe named "Sbj_DF" with all the subject identifiers associated to the training and test raw observations|Merge can be perfomed only if test and traing data have the same column numbers
09| Adding subjects and activities to the selected varibles raw observation dataframe|Updated "Data_DF" dataframe with all "mean() and std()" selected variables, the activity descriptive names, the identifiers of the subject performing the activities and one raw for each observation in the sourcing measure training and test datasets|Subjects, activities and measure dataset can be binded only if each dataframe contains the same rows number
10| Computing the tidy dataset of means along subjects and activities of "mean() and std()" variables|One tidy wide-form dataframe named "Data_DF_Mean" containing the means along the couples [subject identifier, activity descriptive name]s for each selected "mean() and std()" variables|The "plyr" R-package is used to group data and to calculate mean values. To obtain a tidy dataset, variables have been renamed: adding "MeanOnSA prefix", replacing "-" with "_" character, removing wrong duplicated substrings such as "BodyBody" and eliminating brackets "(" / ")"

For a deeper description of each step (precondition, postcondition, description and assumptions) please refere to the "Readme.md" file "The script algorithm and the transformation process from raw to tidy dataset" paragraph.

###Variables description###
Below the detailed list of variables in the tidy dataset generated by "run_analysis.R" script; to make easy the reading, variables have been grouped into:

* **Grouping varibles**: variables used to group data to calculate average values of features
* **Time domain variables**: variables in the time domain
* **Frequency domain variables**: variables in the frequency domain, obtained applying FFT

The sintax adopted for the descrption of each variable is

* *[Variable name]*
    - Position
    - [Type]
    - [Description]
    - [Values or Range Values]


####Grouping varibles####

* *Sbj*
    - 01/68
    - Numeric
    - Numeric value identifying the subject who performed the activity. 
    - Its range is from 1 to 30
    
---------------------------------------------------------------------
    
* *Act_Desc*
    - 02/68
    - Characters  
    - Descriptive name of the activity performed by the subject.
    - The list of its values is "Walking","Walking Upstairs","Waliking Downstairs","Sitting","Standing","Laying"

####Time domain variables####
    
* *MeanOnSA_tBodyAcc_mean_X*
    - 03/68
    - Numeric
    - Mean of all the mean measures of the body acceleration along X-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------
    
* *MeanOnSA_tBodyAcc_mean_Y*
    - 04/68
    - Numeric
    - Mean of all the mean measures of the body acceleration along Y-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range        

---------------------------------------------------------------------

* *MeanOnSA_tBodyAcc_mean_Z*
    - 05/68
    - Numeric
    - Mean of all the mean measures of the body acceleration along Z-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range 

---------------------------------------------------------------------

* *MeanOnSA_tBodyAcc_std_X*
    - 06/68
    - Numeric
    - Mean of all the standard deviations of the measured body accelerations along X-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range 
    
---------------------------------------------------------------------

* *MeanOnSA_tBodyAcc_std_Y*
    - 07/68
    - Numeric
    - Mean of all the standard deviations of the measured body accelerations along Y-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_tBodyAcc_std_Z*
    - 08/68
    - Numeric
    - Mean of all the standard deviations of the measured body accelerations along Z-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tGravityAcc_mean_X*
    - 09/68
    - Numeric
    - Mean of all the mean measures of the gravity acceleration along X-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tGravityAcc_mean_Y*
    - 10/68
    - Numeric
    - Mean of all the mean measures of the gravity acceleration along Y-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_tGravityAcc_mean_Z*
    - 11/68
    - Numeric
    - Mean of all the mean measures of the gravity acceleration along Z-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_tGravityAcc_std_X*
    - 12/68
    - Numeric
    - Mean of all the standard deviations of the measured gravity accelerations along X-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tGravityAcc_std_Y*
    - 13/68
    - Numeric
    - Mean of all the standard deviations of the measured gravity accelerations along Y-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tGravityAcc_std_Z*
    - 14/68
    - Numeric
    - Mean of all the standard deviations of the measured gravity accelerations along Y-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyAccJerk_mean_X*
    - 15/68
    - Numeric
    - Mean along Activity and Subject of all the mean measures of the calculated Jerk signal deriving the body linear X-axis accelaration component in time 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_tBodyAccJerk_mean_Y*
    - 16/68
    - Numeric
    - Mean along Activity and Subject of all the mean measures of the calculated Jerk signal deriving the body linear Y-axis accelation component in time 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyAccJerk_mean_Z*
    - 17/68
    - Numeric
    - Mean along Activity and Subject of all the mean measures of the calculated Jerk signal deriving the body linear Z-axis accelation component in time 
    - Values included in the [-1,1] range   
    
---------------------------------------------------------------------

* *MeanOnSA_tBodyAccJerk_std_X*
    - 18/68
    - Numeric
    - Mean along Activity and Subject of all the standard deviations of the calculated Jerk signal deriving the body linear X-axis accelation component in time 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_tBodyAccJerk_std_Y*
    - 19/68
    - Numeric
    - Mean along Activity and Subject of all the standard deviations of the calculated Jerk signal deriving the body linear Y-axis accelation component in time 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyAccJerk_std_Z*
    - 20/68
    - Numeric
    - Mean along Activity and Subject of all the standard deviations of the calculated Jerk signal deriving the body linear Z-axis accelation component in time 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyro_mean_X*
    - 21/68
    - Numeric
    - Mean of all the mean measures of the body angular velocity around X-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj) 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_tBodyGyro_mean_Y*
    - 22/68
    - Numeric
    - Mean of all the mean measures of the body angular velocity around Y-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj) 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyro_mean_Z*
    - 23/68
    - Numeric
    - Mean of all the mean measures of the body angular velocity around Z-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj) 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyro_std_X*
    - 24/68
    - Numeric
    - Mean of all the standard deviations of the measured body angular velocities around X-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj) 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyro_std_Y*
    - 25/68
    - Numeric
    - Mean of all the standard deviations of the measured body angular velocities around Y-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj) 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyro_std_Z*
    - 26/68
    - Numeric
    - Mean of all the standard deviations of the measured body angular velocities around Z-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj) 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyroJerk_mean_X*
    - 27/68
    - Numeric
    - Mean along Activity and Subject of all the mean measures of the calculated Jerk signal deriving the body angular velocity around X-axis in time 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyroJerk_mean_Y*
    - 28/68
    - Numeric
    - Mean along Activity and Subject of all the mean measures of the calculated Jerk signal deriving the body angular velocity around Y-axis in time 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyroJerk_mean_Z*
    - 29/68
    - Numeric
    - Mean along Activity and Subject of all the mean measures of the calculated Jerk signal deriving the body angular velocity around Z-axis in time 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyroJerk_std_X*
    - 30/68
    - Numeric
    - Mean along Activity and Subject of all the standard deviations of the calculated Jerk signal deriving the body angular velocity around X-axis in time 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyroJerk_std_Y*
    - 31/68
    - Numeric
    - Mean along Activity and Subject of all the standard deviations of the calculated Jerk signal deriving the body angular velocity around Y-axis in time 
    - Values included in the [-1,1] range    

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyroJerk_std_Z*
    - 32/68
    - Numeric
    - Mean along Activity and Subject of all the standard deviations of the calculated Jerk signal deriving the body angular velocity around Z-axis in time 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyAccMag_mean*
    - 33/68
    - Numeric
    - Mean along Activity and Subject of all the body acceleration magnitudes means 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyAccMag_std*
    - 34/68
    - Numeric
    - Mean along Activity and Subject of all the body acceltarion magnitudes standard deviations
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tGravityAccMag_mean*
    - 35/68
    - Numeric
    - Mean along Activity and Subject of all the gravity acceleration magnitudes means 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tGravityAccMag_std*
    - 36/68
    - Numeric
    - Mean along Activity and Subject of all the gravity acceleration magnitudes standard deviations 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyAccJerkMag_mean*
    - 37/68
    - Numeric
    - Mean along Activity and Subject of all the Jerck body acceleration magnitude signal means 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_tBodyAccJerkMag_std*
    - 38/68
    - Numeric
    - Mean along Activity and Subject of all the Jerck body acceleration magnitude signal standard deviations 
    - Values included in the [-1,1] range    

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyroMag_mean*
    - 39/68
    - Numeric
    - Mean along Activity and Subject of all the body angular velocity magnitude means 
    - Values included in the [-1,1] range 
    
---------------------------------------------------------------------

* *MeanOnSA_tBodyGyroMag_std*
    - 40/68
    - Numeric
    - Mean along Activity and Subject of all the body angular velocity magnitude standard deviations
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyroJerkMag_mean*
    - 41/68
    - Numeric
    - Mean along Activity and Subject of all the Jerck body angular velocity magnitude signal means 
    - Values included in the [-1,1] range 

---------------------------------------------------------------------

* *MeanOnSA_tBodyGyroJerkMag_std*
    - 42/68
    - Numeric
    - Mean along Activity and Subject of all the Jerck body angular velocity magnitude signal standard deviations 
    - Values included in the [-1,1] range

####Frequency domain variables####

* *MeanOnSA_fBodyAcc_mean_X*
    - 43/68
    - Numeric
    - Mean of all the mean FFT measures of the body acceleration along X-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyAcc_mean_Y*
    - 44/68
    - Numeric
    - Mean of all the mean FFT measures of the body acceleration along Y-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range        

---------------------------------------------------------------------

* *MeanOnSA_fBodyAcc_mean_Z*
    - 45/68
    - Numeric
    - Mean of all the mean FFT measures of the body acceleration along Z-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range 

---------------------------------------------------------------------

* *MeanOnSA_fBodyAcc_std_X*
    - 46/68
    - Numeric
    - Mean of all the standard deviations of the FFT measured body accelerations along X-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range 
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyAcc_std_Y*
    - 47/68
    - Numeric
    - Mean of all the standard deviations of the FFT measured body accelerations along Y-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyAcc_std_Z*
    - 48/68
    - Numeric
    - Mean of all the standard deviations of the FFT measured body accelerations along Z-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj)
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_fBodyAccJerk_mean_X*
    - 49/68
    - Numeric
    - Mean along Activity and Subject of all the mean FFT measures of the calculated Jerk signal deriving the body linear X-axis accelaration component in time 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyAccJerk_mean_Y*
    - 50/68
    - Numeric
    - Mean along Activity and Subject of all the mean FFT measures of the calculated Jerk signal deriving the body linear Y-axis accelaration component in time 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyAccJerk_mean_Z*
    - 51/68
    - Numeric
    - Mean along Activity and Subject of all the mean FFT measures of the calculated Jerk signal deriving the body linear Z-axis accelaration component in time 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyAccJerk_std_X*
    - 52/68
    - Numeric
    - Mean along Activity and Subject of all the FFT standard deviations of the calculated Jerk signal deriving the body linear X-axis accelation component in time 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyAccJerk_std_Y*
    - 53/68
    - Numeric
    - Mean along Activity and Subject of all the FFT standard deviations of the calculated Jerk signal deriving the body linear Y-axis accelation component in time 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyAccJerk_std_Z*
    - 54/68
    - Numeric
    - Mean along Activity and Subject of all the FFT standard deviations of the calculated Jerk signal deriving the body linear Z-axis acceleration component in time 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyGyro_mean_X*
    - 55/68
    - Numeric
    - Mean of all the mean measures of the FFT body angular velocity around X-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj) 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyGyro_mean_Y*
    - 56/68
    - Numeric
    - Mean of all the mean measures of the FFT body angular velocity around Y-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj) 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyGyro_mean_Z*
    - 57/68
    - Numeric
    - Mean of all the mean measures of the FFT body angular velocity around Z-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj) 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyGyro_std_X*
    - 58/68
    - Numeric
    - Mean of all the FFT standard deviations of the measured body angular velocities around X-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj) 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_fBodyGyro_std_Y*
    - 59/68
    - Numeric
    - Mean of all the FFT standard deviations of the measured body angular velocities around Y-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj) 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_fBodyGyro_std_Z*
    - 60/68
    - Numeric
    - Mean of all the FFT standard deviations of the measured body angular velocities around Z-axis due to the specific activity (Act_Desc) performed by the specific subject (Sbj) 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_fBodyAccMag_mean*
    - 61/68
    - Numeric
    - Mean along Activity and Subject of all the FFT body acceleration magnitudes means 
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_fBodyAccMag_std*
    - 62/68
    - Numeric
    - Mean along Activity and Subject of all the FFT body acceltarion magnitudes standard deviations
    - Values included in the [-1,1] range

---------------------------------------------------------------------

* *MeanOnSA_fBodyAccJerkMag_mean*
    - 63/68
    - Numeric
    - Mean along Activity and Subject of all the Jerck FFT body acceleration magnitude signal means 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyAccJerkMag_std*
    - 64/68
    - Numeric
    - Mean along Activity and Subject of all the Jerck FFT body acceleration magnitude signal standard deviations 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyGyroMag_mean*
    - 65/68
    - Numeric
    - Mean along Activity and Subject of all the FFT angular velocity magnitude means 
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyGyroMag_std*
    - 66/68
    - Numeric
    - Mean along Activity and Subject of all the FFT angular velocity magnitude standard deviations
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyGyroJerkMag_mean*
    - 67/68
    - Numeric
    - Mean along Activity and Subject of all the FFT applied to Jerck signal of the angular velocity magnitude means
    - Values included in the [-1,1] range
    
---------------------------------------------------------------------

* *MeanOnSA_fBodyGyroJerkMag_std*
    - 68/68
    - Numeric
    - Mean along Activity and Subject of all the FFT applied to Jerck signal of the angular velocity magnitude standard deviations
    - Values included in the [-1,1] range


                
 
    
    
    
