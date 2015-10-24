library(dplyr)

# -- set the working directory to the dataset initial folder
setwd("~/R/GettingCleaningData/UCI_HAR_Dataset")

# -- Read column names for later
colNames_file <- file ("features.txt")
colNames <- read.table(colNames_file, colClasses = "character")

# -- Read the relation btw activity codes (1:6) and Activity names for later converting to factors
activity_labels <- read.table("activity_labels.txt", col.names = c("level", "label"))


# --- TEST ---
# -- Open connections to the Test files
X_test_file <- file("test/X_test.txt")
subj_test_file <- file("test/subject_test.txt")
activity_test_file <- file("test/y_test.txt")

#-- Read in the Values setting the column names as defined in features.txt (see above)
X_test <- read.table(X_test_file, col.names = colNames$V2)
# -- Keep only those columns that have -mean() or -std() in their names
X_test <- select(X_test, matches("\\.mean\\.\\.|\\.std\\.\\."))

# -- Read in the subjects column, naming it "Subject"
subj_test <- read.table(subj_test_file, col.names = "Subject")

# -- Read in the activities column, naming it Activity
activity_test <- read.table(activity_test_file, col.names = "Activity")
# -- Convert the levels (1:6) in the activity column to actual names (as factors)
activity_test <- factor(activity_test$Activity, levels=1:6, labels = activity_labels$label)

# -- Add the new columns (subjects and activities) to X_test
X_test$Activity <- activity_test
X_test$Subject <- subj_test$Subject


# --- TRAIN ---
# -- Open connections to the Train files
X_train_file <- file("train/X_train.txt")
subj_train_file <- file("train/subject_train.txt")
activity_train_file <- file("train/y_train.txt")

#-- Read in the Values setting the column names as defined in features.txt (see above)
X_train <- read.table(X_train_file, col.names = colNames$V2)
# -- Keep only those columns that have -mean() or -std() in their names
X_train <- select(X_train, matches("\\.mean\\.\\.|\\.std\\.\\."))

# -- Read in the subjects column, naming it "Subject"
subj_train <- read.table(subj_train_file, col.names = "Subject")

# -- Read in the activities column, naming it Activity
activity_train  <- read.table(activity_train_file, col.names = "Activity")
# -- Convert the levels (1:6) in the activity column to actual names (as factors)
activity_train <- factor(activity_train$Activity, levels=1:6, labels = activity_labels$label)

# -- Add the new columns (subjects and activities) to X_test
X_train$Activity <- activity_train
X_train$Subject <- subj_train$Subject

# --- MERGING ---
# -- Merge Train and Test rows to form X
X <- rbind(X_train, X_test)


# --- STATS ---
# -- Build a data.frame from X containing the mean of each column grouped by Subject and Activity
X_stats <- aggregate.data.frame(X, by=list(X$Subject, X$Activity), FUN = mean)
# - Remove the (old) Subject and Activity columns
X_stats$Subject <- NULL
X_stats$Activity <- NULL
# - Correctly name the two (new) Subject and Activity columns
names(X_stats)[1] <- "Subject"
names(X_stats)[2] <- "Activity"

# -- Write the table to disk for submission
write.table(X_stats, file = "X_stats.txt", row.name=FALSE)
