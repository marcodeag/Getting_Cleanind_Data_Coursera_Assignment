print(paste(Sys.time(),"Start the run_analysis.R Script---------"))
print(paste(Sys.time(),"Checking preconditions------------------"))
## Preconditions check: error message printed if any required file 
## cannot be found
RequiredFilesList <- c(
        ".//UCI HAR Dataset//test//X_test.txt",
        ".//UCI HAR Dataset//train//X_train.txt",
        ".//UCI HAR Dataset//features.txt",
        ".//UCI HAR Dataset//test//y_test.txt",
        ".//UCI HAR Dataset//train//y_train.txt",
        ".//UCI HAR Dataset//activity_labels.txt",
        ".//UCI HAR Dataset//test//subject_test.txt",
        ".//UCI HAR Dataset//train//subject_train.txt"
        )
checkFileList <- !file.exists(RequiredFilesList)
RequiredFilesCheckMatrix <- cbind (RequiredFilesList,checkFileList)
RequiredFilesCheckMatrix <- RequiredFilesCheckMatrix[checkFileList,1]
## Only if all required files are available data elaboration will be perfomed
if (length(RequiredFilesCheckMatrix) > 0)
{       print(paste(Sys.time(),"Precondition check failes------------------")) 
        stop(paste("\nFile or directory not found:",sep = " ",RequiredFilesCheckMatrix))
} else {         
        print(paste(Sys.time(),"Preconditions verified------------------"))
        
        print(paste(Sys.time(),"Merge of training and test measures datasets---------"))
        ## Reading of the test and training datasets and loading into
        ## two different temporary dataframes named "Test_Data_DF" and "Train_Data_DF"
        ## Merging of the test and training dataset by means of "rbind" function
        ## into the new data frame "Data_DF", only if column numbers of the two
        ## datasets match. Final deletion of temporary dataframes
        Test_Data_DF <- read.table(".//UCI HAR Dataset//test//X_test.txt")
        Train_Data_DF <- read.table(".//UCI HAR Dataset//train//X_train.txt")
        if (ncol(Test_Data_DF) == ncol(Train_Data_DF)){
                Data_DF <- rbind(Test_Data_DF,Train_Data_DF)
                rm(Test_Data_DF,Train_Data_DF)
                print(paste(Sys.time(),"Merge of training and test measures datasets completed---"))} else {
                stop ("Error: X test and training dimensions are not the same")        
        }
        
        print (paste(Sys.time(),"Obtaining the variables names of raw measures data-------------"))
        ## Reading of variable descriptive labels from features.txt file
        ## and setting columns names
        Features_DF <- read.table(".//UCI HAR Dataset//features.txt")
        colnames(Features_DF) <- c("Feature_code","Feature_Desc")
        print (paste(Sys.time(),"Obtaining the variables names of raw measures data completed---"))
        
        print (paste(Sys.time(),"Adding variables names to the raw measures dataframe-------------"))
        ## Renaming default variables of the dataframe containg test and training
        ## merged datasets using labels read from features.txt file, only if
        ## Features_DF rows and Data_DF columns numbers match
        if (nrow (Features_DF) == ncol(Data_DF)){
                colnames(Data_DF) <- Features_DF[,2]
                } else {
                stop ("Error: measurements and features numbers don't match")        
        }
        print (paste(Sys.time(),"Adding variables names to the raw measures dataframe completed---"))
        
        print (paste(Sys.time(),"Subsetting the raw measures data frame--------------------------"))
        ## Subsetting of dataframe containg all datasets (test and traing) 
        ## and all measurements to select only variables whose names 
        ## contain the sub-strings "mean()" or "std()" 
        Data_DF <- Data_DF[,grepl("mean()",names(Data_DF),fixed = TRUE) 
                           | grepl("std()",names(Data_DF), fixed = TRUE)]
        print (paste(Sys.time(),"Subsetting the raw measures data frame completed----------------"))
                
        print (paste(Sys.time(),"Getting and merging activity codes for raw data observations----"))
        ## Reading of activity names related to test and traing observations 
        ## from "y_test.txt" and "y_train.txt" files and merge of obtained data 
        ## in one sigle data fame named "Act_DF"
        Test_Act_DF <- read.table(".//UCI HAR Dataset//test//y_test.txt")
        Train_Act_DF <- read.table(".//UCI HAR Dataset//train//y_train.txt")
        if (ncol(Test_Act_DF) == ncol(Train_Act_DF)){
                Act_DF <- rbind(Test_Act_DF,Train_Act_DF)
                rm(Test_Act_DF,Train_Act_DF)
                colnames(Act_DF) <- c("Act_Code")} else {
                        stop ("Error: y test and training dimensions are not the same")        
        }
        print (paste(Sys.time(),"Getting and merging activity codes for raw data observations completed-"))
        
        print (paste(Sys.time(),"Getting activity codes and activity names redefinition-----"))
        ## Reading of "activity code" and "original activity names" provided by
        ## Samsung from "activity_labels.txt" file, inserting data into 
        ## Act_Desc dataframe
        ## Creation of a new vector containg "extended descriptions" of the activities
        ## Enrichment of Act_Desc dataframe with activities extended descriptions 
        Act_Desc <- read.table(".//UCI HAR Dataset//activity_labels.txt")
        colnames(Act_Desc) <- c("Act_Code","Act_Original_Desc")
        Act_Ext_Description <- c(
                "Walking",
                "Walking Upstairs", 
                "Walking Downstairs",
                "Sitting",
                "Standing",
                "Laying")
        Act_Desc <- cbind(Act_Desc, Act_Ext_Description)
        rm(Act_Ext_Description)
        print (paste(Sys.time(),"Getting activity codes and activity names redefinition completed--"))
        
        print (paste(Sys.time(),"Getting activity descriptive names for raw observations-------"))
        ## Transformation of Act_DF (initially containg the activity codes associated to all
        ## the observations) into a "new dataframe" containg the full extended activity names
        ## The transformation is perfomed joining (join function of plyr package) Act_DF and Act_Desc
        ## dataframes on the common Act_Code column, 
        library(plyr);
        Act_DF <- join(Act_DF, Act_Desc, by = "Act_Code") 
        print (paste(Sys.time(),"Getting activity descriptive names for raw observations completed-"))
        
        print (paste(Sys.time(),"Getting subjects for raw observations -------------------------"))
        ## Reading of subject performing the measured activities
        ## related to test and traing observations from "subject_test.txt"
        ## and "subject_train.txt" files and and merge of obtained data in one sigle data fame
        ## named "Sbj_DF"
        Sbj_Test_DF <- read.table(".//UCI HAR Dataset//test//subject_test.txt")
        Sbj_Train_DF <- read.table(".//UCI HAR Dataset//train//subject_train.txt")
        if (ncol(Sbj_Test_DF) == ncol(Sbj_Train_DF)){
                Sbj_DF <- rbind(Sbj_Test_DF,Sbj_Train_DF)
                rm(Sbj_Test_DF,Sbj_Train_DF)
                colnames(Sbj_DF) <- c("Sbj")} else {
                        stop ("Error: subject test and training dimensions are not the same")        
        }
        print (paste(Sys.time(),"Getting subjects for raw observations completed----------------"))
        
        print (paste(Sys.time(),"Adding subjects and activities to the selected varibles raw observation dataframe"))
        ## Enrichment of Data_DF containg all the observations but only mean()
        ## and std() variables with the new columns Sbj and Act_Desc, only
        ## if the three dataframes contain the same number of rows
        ## Data are added as first columns.
        if ((nrow (Data_DF) == nrow (Sbj_DF)) && (nrow (Data_DF) == nrow (Act_DF))){
                Data_DF <- cbind(Sbj_DF,Act_DF[,3],Data_DF)
                ## Overwriting of default Act_Desc name
                names(Data_DF)[2] <- "Act_Desc" 
                } else {
                stop ("Error: subjects, features and measurements observations doesn't match")
        }
        print (paste(Sys.time(),"Adding subjects and activities to the selected varibles raw observation dataframe completed"))
        
        print(paste(Sys.time(),"Computing the tidy dataset of means along subjects and activities of mean() and std() variables"))
        ## Creation of a second, independent tidy data set 
        ## with the average of each variable for each activity and each subject
        ## by means of ddply function of plyr package
        ## Renaming of the variables on which the mean has been calculated
        
        Data_DF_Mean <-ddply(Data_DF, .(Sbj,Act_Desc), numcolwise(mean))
        newNames <- c(colnames(Data_DF_Mean[,1:2]),
                      paste("MeanOnSA_",colnames(Data_DF_Mean[,3:ncol(Data_DF_Mean)]),sep=""))
        newNames <- gsub("-","_",newNames)
        newNames <- gsub("BodyBody","Body",newNames)
        newNames <- gsub("\\(|\\)","",newNames)
        colnames(Data_DF_Mean) <- newNames
        print(paste(Sys.time(),"Computing the tidy dataset of means along subjects and activities of mean() and std() variables completed"))
        
        print(paste(Sys.time(),"Writing Data_Mean.txt output file--------------"))
        ## Creation of Data_Mean.txt containg the required calculated averages
        ## for the submission of Q1 answer of the Getting and Cleaning 
        ## data course prj assignment. The output is tab delimeted formatted
        write.table(Data_DF_Mean,file = "Data_Mean.txt",sep="\t",row.names=FALSE)
        print(paste(Sys.time(),"Writing Data_Mean.txt output file completed-----"))
        print(paste(Sys.time(),"End of run_analysis.R Script--------------------"))
}