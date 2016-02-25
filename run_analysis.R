## Import & Clean: "final.data"
# Import library
library("dplyr")
library("tidyr")
library(shiny)
library(DT)

#Working Directory
fp.sphone <- "/Users/Evan/Desktop/R/sliderule/Proj1/smartphone"
if(getwd() == fp.sphone){setwd(paste(getwd()))} else {setwd(paste(fp.sphone))}
rm(fp.sphone)

# Data Set
data <- rbind(tbl_df(read.table("test/X_test.txt", header = FALSE)),tbl_df(read.table("train/X_train.txt", header = FALSE)))

# ID Set
id.activity <- rbind(tbl_df(I(read.table("test/y_test.txt"))), tbl_df(I(read.table("train/y_train.txt"))))
id.subject <- rbind(tbl_df(I(read.table("test/subject_test.txt"))), tbl_df(I(read.table("train/subject_train.txt"))))
id <- cbind(id.subject,id.activity)
remove(id.activity)
remove(id.subject)

# Labels
label.cl <- tbl_df(read.table("features.txt", stringsAsFactors = FALSE))
id.activity.label <- tbl_df(read.table("activity_labels.txt", stringsAsFactors = FALSE))

#Column Names
colnames(data) <- make.names(c(label.cl$V2), unique = TRUE)
colnames(id) <- c("SubjectID","ActivityLabel")
id[,"ActivityName"] <- factor(id$ActivityLabel, levels = c(id.activity.label$V1), labels = c(id.activity.label$V2))

#Bind data & ID
final.data <- cbind(id,data)
remove(data)
remove(id)

## Create final data objects
data.head <- data.frame(select(final.data,SubjectID:ActivityName),select(final.data,contains("mean")),select(final.data,contains("std")))
tidydata.head <- subset %>% group_by(SubjectID,ActivityLabel,ActivityName) %>% summarise_each(funs(mean))

## Export tidy dataset
write.table(tidydata.head, "/Users/Evan/Desktop/R/sliderule/Proj1")

# remove variables
remove(id.activity.label)
remove(label.cl)
remove(subset)



