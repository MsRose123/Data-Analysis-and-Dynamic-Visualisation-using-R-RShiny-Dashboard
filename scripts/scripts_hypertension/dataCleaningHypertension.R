#---
# title: "Data Cleaning - Hypertension"
# author: 'StduentNo : 2332635'
#---
  
# loading libraries
library(dplyr)
library(tidyr)

wd <- getwd()
setwd(wd)
 
# read csv file - BPX_D.csv
bpx <- read.csv("rawData/BPX_D.csv", header = TRUE)

# read data - DEMO_D.csv
demo <- read.csv("rawData/DEMO_D.csv", header = TRUE)

# converting column names to lowercase
names(bpx) <- tolower(names(bpx))
names(demo) <- tolower(names(demo))

# merging data based on respondent sequence number & subsetting required columns
data1 <- merge(bpx,demo, by = "seqn") %>%
  transmute(participantId = seqn, bp_systolic1 = bpxsy1, bp_diastolic1 = bpxdi1, 
            bp_systolic2 = bpxsy2, bp_diastolic2 = bpxdi2, bp_systolic3 = bpxsy3, 
            bp_diastolic3 = bpxdi3, 
            gender = riagendr,age = round(ridagemn/12))

# center to 0 and 1
# 0 - male
# 1 - female
data1 <- data1 %>%
  mutate(gender = ifelse(gender == 1, 0, 1))

# subset for age above 18 ( for adults only)
data1 <- data1 %>% 
  filter(age >= 18)

# addressing outliers and missing observations

#number of rows with missing values
sum(is.na(data1$bp_systolic1))
sum(is.na(data1$bp_systolic2))
sum(is.na(data1$bp_systolic3))

sum(is.na(data1$bp_diastolic1))
sum(is.na(data1$bp_diastolic2))
sum(is.na(data1$bp_diastolic3))


sum(is.na(data1$participantId))
sum(is.na(data1$gender))
sum(is.na(data1$age))

#dump the rows with missing values
data1 <- data1 %>% drop_na(bp_systolic1)
data1 <- data1 %>% drop_na(bp_systolic2)
data1 <- data1 %>% drop_na(bp_systolic3)
data1 <- data1 %>% drop_na(bp_diastolic1)
data1 <- data1 %>% drop_na(bp_diastolic2)
data1 <- data1 %>% drop_na(bp_diastolic3)

data1 <- data1 %>% drop_na(gender)
data1 <- data1 %>% drop_na(age)


# removing outliers

# systolic blood pressure cannot be greater than 300 mm Hg
data1 <- data1 %>% filter(bp_systolic1 <=300)
data1 <- data1 %>% filter(bp_systolic2 <=300)
data1 <- data1 %>% filter(bp_systolic3 <=300)

# systolic and diastolic blood pressure must be even numbers
data1 <- data1 %>% filter(bp_systolic1 %% 2 == 0)
data1 <- data1 %>% filter(bp_systolic2 %% 2 == 0)
data1 <- data1 %>% filter(bp_systolic3 %% 2 == 0)

data1 <- data1 %>% filter(bp_diastolic1 %% 2 == 0)
data1 <- data1 %>% filter(bp_diastolic2 %% 2 == 0)
data1 <- data1 %>% filter(bp_diastolic3 %% 2 == 0)

# systolic bp must be greater than diastolic bp
data1 <- data1 %>% filter(bp_systolic1 > bp_diastolic1)
data1 <- data1 %>% filter(bp_systolic2 > bp_diastolic2)
data1 <- data1 %>% filter(bp_systolic3 > bp_diastolic3)

# check if any of the systolic bood pressure is 0
data1 <- data1 %>% filter(bp_systolic1 != 0)
data1 <- data1 %>% filter(bp_systolic2 != 0)
data1 <- data1 %>% filter(bp_systolic3 != 0)

# writing cleaned data
write.csv(data1, file = "cleanData/hypertensionData.csv", row.names = FALSE)
