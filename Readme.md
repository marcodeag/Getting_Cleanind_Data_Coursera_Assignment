---
title: "Readme for the run_analysis.R script"
author: "Marco De Agostini"
date: "Wednesday, August 20, 2014"
output: html_document
---

###Overview###
The file "Readme.md" provides a detailed description of the "run_analysis.R" script, implemented as final deliverable of the "Getting and Cleaning Data" Coursera project assignment.

This file must be consider as a part of a code package composed by:
* run_analysis.R file
* Readme.md file
* CodeBook.md file

The following paragraphs will provide details about:

* The contest and the aim of the script
* The script preconditions and the input files
* The script algorithm and the transformation process from raw to tidy dataset
* The script output file
* Technical notes 
* Examples of output

For an exhaustive description of the tidy dataset provided as output of the script, instead, see the "CodeBook.md" file.

-----------------------------------------------------------------------------------------------------------------

###The contest and the aim of the script###
The "run_analysis.R" script aim consists into prepare a tidy dataset related to measurements of human activities, obtained by means of the computation of raw data collected by "Smartlab - Non Linear Complex Systems Laboratory" in an experiment of "Human Activity Recognition Using Smartphones Data Set".

----------------------------------------------------------------------------------------------------------------

###The script preconditions and the input files###
The "run_analysis.R" script requires the following input files:

* //UCI HAR Dataset//test//X_test.txt
* //UCI HAR Dataset//train//X_train.txt
* //UCI HAR Dataset//features.txt
* //UCI HAR Dataset//test//y_test.txt
* //UCI HAR Dataset//train//y_train.txt
* //UCI HAR Dataset//activity_labels.txt
* //UCI HAR Dataset//test//subject_test.txt
* //UCI HAR Dataset//train//subject_train.txt

All required files are obtained uncompressing the "getdata-projectfiles-UCI HAR Dataset.zip" (available at the following link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) in the R working directory.

The script assumes that all listed files are already available and saved on the local machine into the same working directory in which is placed the "run_analysis.R" script.

Furthermore, the script is based on the hypothesis that the folders structure is compliant with the following tree: 

* *[Working directory]*
    * UCI HAR Dataset
        * test
        * train

----------------------------------------------------------------------------------------------------------------

###The script algorithm and the transformation process from raw to tidy dataset###
The "run_analysis.R" script starting from raw datasets obtained by the source required files produces the tidy dataset of measures required by the Coursera Getting and Cleaning data project assignment.

The transformation processes perfomed by the script is characterised by 12 steps; in the following for each step are provided:

* Code Lines: a reference to the range of code lines ([start line,end line])
* Short description: a brief description of the step
* Preconditions: preconditions assumed for the step execution
* Postconditions: what is gotten after the step execution
* Full description: an exhaustive description of applied transformations and of the assumptions

####Step 0 - Preconditions check####
**Code Lines**: [1,21]

**Short description:** the script verifies that alla the required files are available in the working directory

**Preconditions:** necessary files have been already saved in the local machine according to required folder structure

**Postconditions:** the go/no go confirmation is computed

**Full description:** the script generates a vector of all required files named "RequiredFilesList", then by means of the negation of "file.exists" function creates the logical vector "checkFileList"; each element of the "checkFileList" vector has "TRUE" value if the file does not exists, FALSE otherwise. Finally a matrix "RequiredFilesCheckMatrix" with only the names of the not existing files is generated. If the "RequiredFilesCheckMatrix" contains at least an element, the script is stopped and an error message with the list of not existing files is provided to the user; otherwise the script goes ahead with the next steps

####Step 1 - Merge of training and test measures datasets####
**Code Lines**: [25,38]

**Short description:** the script reads the raw trainig and test measures datasets, merging them after to have checked the match of the columns counts

**Preconditions:** X training and test files are available and step 1 preconditions check is ended up without errors

**Postconditions:** one dataframe "Data_DF" with all the training and test raw measures

**Full description:** the script reads the "X_test.txt" and the "X_train.txt" generating respectively the "Test_Data_DF" and" "Train_Data_DF". The script then checks that "Test_Data_DF" and "Train_Data_DF" have the same number of columns, putting them together in the "Data_DF" dataframe only if the check is correctly ended up.

####Step 2 - Obtaining the variables names of raw measures data####
**Code Lines**: [40,45]

**Short description:** the script reads the original names of the sourcing raw measures 

**Preconditions:** Features.txt file is available and step 1 preconditions check is ended up without errors

**Postconditions:** one dataframe "Features_DF" with all the variables names of the raw measures

**Full description:** the script reads the "features.txt" file, generating the "Features_DF" dataframe

####Step 3 - Adding variables names to the raw measures dataframe####
**Code Lines**: [47,56]

**Short description:** the script assigns the original variable names contained into the "Features_DF" to the columns in the raw measures dataframe "Data_DF" 

**Preconditions:** the "Features_DF" with all original variables names of raw measures and the "Data_DF" with all the raw data are available

**Postconditions:** one dataframe "Data_DF" with all raw measures data and relative original variable names

**Full description:** the script verifies the match between "Data_DF" and "Features_DF" dataframes columns counts, assigning to the "Data_DF" dataframe columns the variables names stored into "Features_DF" only if the check correctly ended up

####Step 4 - Subsetting the raw measures data frame####
**Code Lines**: [58,64]

**Short description:** the script cuts the raw measures data frame "Data_DF" selecting only "mean()" and "std()" variables

**Preconditions:** the "Data_DF" dataframe containg all the raw data with all original variables names is available

**Postconditions:** one dataframe "Data_DF" with all raw measures data, all relative original variable names but only "mean()" and "std()" variables

**Full description:** the script cuts the "Data_DF" extracting only features with 'mean()' or 'std()' in their name. Features that contain only the substring 'mean' (without brackets '()') in their name are excluded under the assumption that the measurements were not really means, but was something entirely different. For example, 'angle(tBodyAccMean,gravity)'.

####Step 5 - Getting and merging activity codes for raw data observations####
**Code Lines**: [66,78]

**Short description:** the script reads and merge the sourcing activity codes associated to test and training observations

**Preconditions:** y_test.txt and y_train.txt files are available and step 1 preconditions check is ended up without errors

**Postconditions:** one dataframe "Act_DF" with all activity codes associated to the training and test raw measures

**Full description:** the script reads the "y_test.txt" and the "y_train.txt" generating respectively the "Test_Act_DF" and" "Train_Act_DF". The script then checks that "Test_Act_DF" and "Train_Act_DF" have the same number of columns, putting them together in the "Act_DF" dataframe only if the check is correctly ended up.


####Step 6 - Getting activity codes and activity names redefinition####
**Code Lines**: [80,97]

**Short description:** the script combines activity codes from sourcing files with new activity descriptive names (embedded in the code) 

**Preconditions:** activity_labels.txt file is available and step 1 preconditions check is ended up without errors

**Postconditions:** one dataframe "Act_Desc" with activity codes and new activity descriptive names

**Full description:** the script reads the "activity_labels.txt" file, generating the "Act_Desc" dataframe. It then creates "Act_Ext_Description", a vector containing all new descriptive activity names. The script finally enriches the "Act_Desc" adding as a new column the new descriptive activity names in the "Act_Ext_Description" vector. Since the number of activities is not too large, a simple "code embedded" redefinition has been preferred to a more complex solution, such as an external configuration file with all new activity names.

####Step 7 - Getting activity descriptive names for raw observations####
**Code Lines**: [99,106]

**Short description:** the script computes the activity descriptive names for raw observations

**Preconditions:** the "Act_DF" dataframe with all activity codes associated to the training and test raw measures and "Act_Desc" with activity codes and new activity descriptive names are available

**Postconditions:** one dataframe "Act_DF" with all activity descriptive names associated to the training and test raw observations 

**Full description:** the script merges "Act_DF" dataframe (containg all activity codes associated to the training and test raw measures) and "Act_Desc" dataframe (containg all the couples activity code and activity descriptive name) on activity code common attribute. The resulting dataframe is used to update the "Act_DF" dataframe.

####Step 8 - Getting subjects for raw observations####
**Code Lines**: [108,121]

**Short description:** the script reads the performing activities subject identifiers 

**Preconditions:** subject_test.txt and subject_train.txt files are available and step 1 preconditions check is ended up without errors

**Postconditions:** one dataframe "Sbj_DF" with all the subject identifiers associated to the training and test raw observations

**Full description:** the script reads the "subject_test.txt" and the "subject_train.txt" generating respectively the "Sbj_Test_DF" and" "Sbj_Train_DF". The script then checks that "Sbj_Test_DF" and "Sbj_Train_DF" have the same number of columns, putting them together in the "Sbj_DF" dataframe only if the check is correctly ended up.

####Step 9 - Adding subjects and activities to the selected varibles raw observation dataframe####
**Code Lines**: [123,135]

**Short description:** the script adds subject identifiers and activity descriptive names to the "Data_DF" dataframe containing "mean() and std()" variables and raw observation data

**Preconditions:** "Data_DF" dataframe (containing "mean() and std()" variables and raw observation data), "Sbj_DF" dataframe (containing all the subject identifiers associated to the training and test raw observations) and "Act_DF" (containing all activity descriptive names associated to the training and test raw observations) are available

**Postconditions:** one dataframe "Data_DF" with all "mean() and std()" selected variables, the activity descriptive names, the identifiers of the subject performing the activities and one raw for each observation in the sourcing measure training and test datasets

**Full description:** the script checks that the "Data_DF" dataframe number of rows is equals to the "Sbj_DF" dataframe number of rows and matching with the number of elements of "Act_DF". If the check is completed with a positive feedback, the three dataframe are binding toghether updating the "Data_DF" dataframe.

####Step 10 - Computing the tidy dataset of means along subjects and activities of "mean() and std()" variables####
**Code Lines**: [137,150]

**Short description:** the script creates a new tidy dataframe containing the means along the couples [subject identifier, activity descriptive name]s for each selected "mean() and std()" variables, coming from the original row data

**Preconditions:** one dataframe "Data_DF" with all "mean() and std()" selected variables, the activity descriptive names, the identifiers of the subject performing the activities and one raw for each observation in the sourcing measure training and test datasets is available.

**Postconditions:** one tidy wide-form dataframe named "Data_DF_Mean" containing the means along the couples [subject identifier, activity descriptive name]s for each selected "mean() and std()" variables

**Full description:** the script by means of "ddply" function belonging to "plyr" R Package computes the mean of all the selected "mean() and std()" variables along the [subject identifier, activity descriptive name] different couples and store the results into the new tidy dataframe named "Data_DF_Mean". 

the "plyr\ddply" function has been preferred to the arrange function because it lets to compute the average without duplications of grouping variables (such as "Sbj" and "Act_Desc").

To obtain a tidy dataset, the script make some updates to the "mean() and std()" "Data_DF_Mean" frame variable names:

* adding the prefix "MeanOnSA" which stands for "Mean along subject and activity name"
* replacing by means of "gsub" function "-" character with "_"
* elimination of some duplication inside names (such as "BodyBody")
* elimination of brackets "(" and ")"

For example the initial variable name "fBodyBodyGyroJerkMag-std()" becomes "MeanOnSA_fBodyGyroJerkMag_std()" 

####Step 11 - Writing Data_Mean.txt output file####
**Code Lines**: [152,158]

**Short description:** the script writes the Data_Mean.txt file filling it with the "Data_DF_Mean" dataframe

**Preconditions:** the "Data_DF_Mean" dataframe is available

**Postconditions:** the "Data_Mean.txt" is available in the working directory

**Full description:** the script writes the "Data_Mean.txt" reading data from the "Data_DF_Mean" dataframe.

-----------------------------------------------------------------------------------------------------------------

###The script output file###
The script output file "Data_Mean.txt" consists into tab-formatted text file, containing one tidy wide-form dataframe with the means along the couples [subject identifier, activity descriptive name]s for each selected "mean() and std()" variables

-----------------------------------------------------------------------------------------------------------------
###Technical notes###
####How the script was generated####
The "run_analysis.R" has been generated using

* R 3.1.0
* R-Studio Version 0.98.994
* Platform i386-w64-mingw32

The implementation of one single script has been preferred to several scripts linked each other to make easy the execution and the elaboration flow.

In the code the "plyr" library version 1.8.1 was referenced to.

####How the script can be executed####
The script can be executed:

* Downloading and uncompressing the "getdata-projectfiles-UCI HAR Dataset.zip", which contains all the required source files
* Opening the run_analysis.R in R Studio
* Pressing the "source" button

The execution can be monitored watching the different messages printed in the "Console" window.

**Example of RStudio Console output after a successful run**

```
[1] "2014-08-22 03:19:48 Start the run_analysis.R Script---------"
[1] "2014-08-22 03:19:48 Checking preconditions------------------"
[1] "2014-08-22 03:19:48 Preconditions verified------------------"
[1] "2014-08-22 03:19:48 Merge of training and test measures datasets---------"
[1] "2014-08-22 03:20:21 Merge of training and test measures datasets completed---"
[1] "2014-08-22 03:20:21 Obtaining the variables names of raw measures data-------------"
[1] "2014-08-22 03:20:21 Obtaining the variables names of raw measures data completed---"
[1] "2014-08-22 03:20:21 Adding variables names to the raw measures dataframe-------------"
[1] "2014-08-22 03:20:21 Adding variables names to the raw measures dataframe completed---"
[1] "2014-08-22 03:20:21 Subsetting the raw measures data frame--------------------------"
[1] "2014-08-22 03:20:21 Subsetting the raw measures data frame completed----------------"
[1] "2014-08-22 03:20:21 Getting and merging activity codes for raw data observations----"
[1] "2014-08-22 03:20:21 Getting and merging activity codes for raw data observations completed-"
[1] "2014-08-22 03:20:21 Getting activity codes and activity names redefinition-----"
[1] "2014-08-22 03:20:21 Getting activity codes and activity names redefinition completed--"
[1] "2014-08-22 03:20:21 Getting activity descriptive names for raw observations-------"
[1] "2014-08-22 03:20:21 Getting activity descriptive names for raw observations completed-"
[1] "2014-08-22 03:20:21 Getting subjects for raw observations -------------------------"
[1] "2014-08-22 03:20:21 Getting subjects for raw observations completed----------------"
[1] "2014-08-22 03:20:21 Adding subjects and activities to the selected varibles raw observation dataframe"
[1] "2014-08-22 03:20:21 Adding subjects and activities to the selected varibles raw observation dataframe completed"
[1] "2014-08-22 03:20:21 Computing the tidy dataset of means along subjects and activities of mean() and std() variables"
[1] "2014-08-22 03:20:21 Computing the tidy dataset of means along subjects and activities of mean() and std() variables completed"
[1] "2014-08-22 03:20:21 Writing Data_Mean.txt output file--------------"
[1] "2014-08-22 03:20:22 Writing Data_Mean.txt output file completed-----"
[1] "2014-08-22 03:20:22 End of run_analysis.R Script--------------------"
```

**Example of RStudio Console output after an unsuccessful run**

```
[1] "2014-08-22 03:57:38 Start the run_analysis.R Script---------"
[1] "2014-08-22 03:57:38 Checking preconditions------------------"
[1] "2014-08-22 03:57:38 Precondition check failes------------------"
File or directory not found: .//UCI HAR Dataset//test//X_test.txt
```
