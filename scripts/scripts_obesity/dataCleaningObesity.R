#---
#title: "Data Cleaning - Obesity"
#author: 'StduentNo : 2332635'
#---

# loading libraries
library(dplyr)
library(tidyr)

wd <- getwd()
setwd(wd)

# read csv file - BMX_D.csv
bmx <- read.csv("rawData/BMX_D.csv", header = TRUE)

# read data - DEMO_D.csv
demo <- read.csv("rawData/DEMO_D.csv", header = TRUE)

# converting column names to lowercase
names(bmx) <- tolower(names(bmx))
names(demo) <- tolower(names(demo))

# merging data based on respondent sequence number & subsetting required columns
data0 <- merge(bmx,demo, by = "seqn") %>%
  transmute(participantId = seqn,bodyMassIndex = bmxbmi,gender = riagendr,age = round(ridagemn/12),pregnant_women = ridexprg)

# center to 0 and 1
# 0 - male
# 1 - female
data0 <- data0 %>%
  mutate(gender = ifelse(gender == 1, 0, 1))

# center to 0 and 1
# 0 - not pregnant
# 1 - pregnant

data0 <- data0 %>% 
  mutate(pregnant_women = ifelse(pregnant_women == 1 && gender ==1,1,0))
#if pregnant remove from the data
data0 <- data0 %>% filter(pregnant_women == 0) 

# subsetting data
data0 <- data0 %>% select(participantId,bodyMassIndex,gender,age)

# subset for age above 18 ( for adults only)
data0 <- data0 %>%
  filter(age >= 18)

# addressing outliers and missing observations

#number of rows with missing values
sum(is.na(data0$bodyMassIndex))
sum(is.na(data0$participantId))
sum(is.na(data0$gender))
sum(is.na(data0$age))

#dump the rows with missing values
data0 <- data0 %>% drop_na(bodyMassIndex)
data0 <- data0 %>% drop_na(participantId)
data0 <- data0 %>% drop_na(gender)
data0 <- data0 %>% drop_na(age)



# removing outliers
quantile(data0$bodyMassIndex)
q1 <-  quantile(data0$bodyMassIndex, probs = c(0.25))

q3 <-  quantile(data0$bodyMassIndex, probs = c(0.75))

iqr <- IQR(data0$bodyMassIndex)

bmi_min <- q1 - (3 * iqr)


bmi_max <- q3 + (3 * iqr)

data0 <- data0 %>%
  filter(bodyMassIndex <= bmi_max & bodyMassIndex >= bmi_min)

# writing cleaned data
write.csv(data0, file = "cleanData/obesityData.csv", row.names = FALSE)
