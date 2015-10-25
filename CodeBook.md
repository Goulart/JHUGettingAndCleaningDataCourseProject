#Code Book
This is the course project for Getting and Cleaning Data by Goulart (me)

## Original Data

The original data came from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

For details, please read the README.txt file contained in the subfolder "UCI HAR Dataset" after unziping the above zip file.

Simple summary of the original data:
- there are two sets: train and test
- the total number of subjects (train + test) is 30
- there are 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) - activity_labels.txt
- there are a total of 561 variables - features.txt
- in each set {test or train},
  - the subjects column is in subject_{test|train}.txt
  - the activity column is in y_{test|train}.txt
  - the statistics computed over the signals are in X_{test|train}.txt

## Performed Transformations

1. Unzip the data, creates a subfolder "UCI HAR Dataset". `setwd()` to this folder;
2. Read in the values from **test/X_test.txt** and **train/X_train.txt**, assign the column names from **features.txt** to two data frames;
3. Select (keep) only the variables (columns) containing *-std()* or *-mean()*;
4. Bind the columns containing the subjects **test/subject_test.txt** and **train/subject_train.txt** to each of the data frames;
5. Convert the activity column (from **test/y_test.txt** and **train/y_train.txt**) to factors and bind to each of the data frames;
6. Merge the rows from both train and test data frames, resulting in X data frame;
7. Apply the `mean()` to X aggregated by Subject and Activity, producing *X_stats*;
8. Write *X_stats* to **X_stats.txt**.



Aknowledgements concerning the original data:

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
