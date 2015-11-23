X_test <- fread("./UCI HAR Dataset/test/X_test.txt") 
X_train <- fread("./UCI HAR Dataset/train/X_train.txt")
subject_test <- fread("./UCI HAR Dataset/test/subject_test.txt") 
subject_train <- fread("./UCI HAR Dataset/train/subject_train.txt")
y_test <- fread("./UCI HAR Dataset/test/y_test.txt") 
y_train <- fread("./UCI HAR Dataset/train/y_train.txt")
features <- fread("./UCI HAR Dataset/features.txt") 
activity_labels <- fread("./UCI HAR Dataset/activity_lables.txt")
test_data <- cbind(subject_test, y_test, X_test)
train_data <- cbind(subject_train, y_train, X_train)

## Merges the training and the test sets to create one data set.
proj_data <- rbind(test_data, train_data) 

## Appropriately labels the data set with descriptive variable names.
colnames(proj_data) <- c("Subject", "Label", features$V2) 

## Extracts only the measurements on the mean and standard deviation for each measurement. 
proj_tab <- select(proj_data, Subject, Label, contains("mean"), contains("std")) 

## Uses descriptive activity names to name the activities in the data set
proj_tab_walking <- proj_tab %>% filter(Lable == 1) %>% mutate(Activity = activity_labels$V2[1])
proj_tab_walking_upstairs <- proj_tab %>% filter(Lable == 2) %>% mutate(Activity = activity_labels$V2[2])
proj_tab_walking_downstairs <- proj_tab %>% filter(Lable == 3) %>% mutate(Activity = activity_labels$V2[3])
proj_tab_sitting <- proj_tab %>% filter(Lable == 4) %>% mutate(Activity = activity_labels$V2[4])
proj_tab_standing <- proj_tab %>% filter(Lable == 5) %>% mutate(Activity = activity_labels$V2[5])
proj_tab_laying<- proj_tab %>% filter(Lable == 6) %>% mutate(Activity = activity_labels$V2[6])
proj_table <- rbind(proj_tab_walking, proj_tab_walking_upstairs, proj_tab_walking_downstairs, proj_tab_sitting, proj_tab_standing, proj_tab_laying)

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
proj_group <- group_by(proj_table, Subject, Activity)
proj_group_means <- summarize_each(proj_group, funs(mean))