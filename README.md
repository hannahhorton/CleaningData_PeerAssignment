# CleaningData_PeerAssignment

##Project Description

This project is for the Getting and Cleaning Data course within JHU's Data Science Specialization. The goal of this project was to generate a script that could perform the necessary analysis and tranformation of the Human Activity Recognition Using Smartphones dataset from the UCI dataset repository. This script could then create a clean version of the dataset. 

##Files 

run_analysis.R performs the data transformations necessary to generate a tidy dataset. It accomplishes this task in the steps outlined by the course instructions
  1. The testing and training datasets are merged into a single dataset
  2. The mean and standard deviation values for each measurement (feature) are extracted
  3. The activities performed by the subjects are given descriptive titles provided by the activity_labels.txt file.
  4. The feature variables are given descriptive titles.
  5. The aformentioned data processing steps are implimented to create a new, tidy version of the human activity dataset which is then exported into the txt file tidyest_data.txt
  
Codebook is a file that includes a brief description of the project, the variables within the dataset, and the processing steps the data undergoes in order to create the tidy dataset.