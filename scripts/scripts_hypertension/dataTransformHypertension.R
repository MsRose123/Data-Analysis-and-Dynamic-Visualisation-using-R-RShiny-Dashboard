#---
# title: "dataTransformHypertension"
# author: 'StduentNo : 2332635'
#---
  
library(dplyr)
library(tidyr)

wd <- getwd()
setwd(wd)

hypertensionData <- read.csv("cleanData/hypertensionData.csv")

# adding column avg_systolic_bp, avg_diastolic_bp  

hypertensionData_1 <- hypertensionData %>% 
  transmute(participantId, avg_systolic_bp = round(((bp_systolic1 + bp_systolic2 + bp_systolic3)/3),2),
            avg_diastolic_bp = round(((bp_diastolic1 + bp_diastolic2 + bp_diastolic3)/3),2), gender, age)


# adding column hypertension
# have hypertension or not
# 0 - no hypertension
# 1 - hypertension
hypertensionData_1 <- hypertensionData_1 %>% 
  mutate(hypertension = ifelse(avg_systolic_bp >= 130 & avg_diastolic_bp >=80,1,0))

# write data
write.csv( hypertensionData_1, file = 'intermediates/data/hypertensionTransformedData.csv', row.names=FALSE)

#probability of people with hypertension in each age
# no  of people with hypertension in each age
hyptCount <- hypertensionData_1 %>% 
  group_by(age) %>%
  filter(hypertension==1) %>%
  count(hypertension)

hyptCount$no_of_hypertension_participants <- hyptCount$n

#total number of people in each age
total_hypertension_age <- hypertensionData_1 %>%
  group_by(age) %>%
  count(age)

total_hypertension_age$no_of_total_participants <- total_hypertension_age$n

hyptProb <- merge(hyptCount,total_hypertension_age, by = "age") %>%
  transmute(age,no_of_hypertension_participants,no_of_total_participants,hypertension_probability = no_of_hypertension_participants/no_of_total_participants )

#write data
write.csv( hyptProb, file = 'intermediates/data/hypertensionProbData.csv', row.names=FALSE)

#probability of people with hypertension in each age - male only (gender = 0)
# no  of people with hypertension in each age
hypertensionCountMale <- hypertensionData_1 %>% 
  group_by(age) %>%
  filter(hypertension==1 & gender==0) %>%
  count(hypertension)

hypertensionCountMale$no_of_hypertension_males <- hypertensionCountMale$n

#total number of males in each age
totalage <- hypertensionData_1 %>%
  filter(gender==0) %>%
  group_by(age) %>%
  count(age)

totalage$no_of_male_participants <- totalage$n

hypertensionMaleProb <- merge(hypertensionCountMale,totalage, by = "age") %>%
  transmute(age,no_of_hypertension_males,no_of_male_participants,male_hypertension_probability = no_of_hypertension_males/no_of_male_participants )

# write data
write.csv( hypertensionMaleProb, file = 'intermediates/data/hypertensionMaleProbData.csv', row.names=FALSE)

#probability of people with hypertension in each age - female only (gender = 1)
# no  of people obese in each age
hypertensionCountFemale <- hypertensionData_1 %>% 
  group_by(age) %>%
  filter(hypertension==1 & gender==1) %>%
  count(hypertension)

hypertensionCountFemale$no_of_hypertension_females <- hypertensionCountFemale$n


#total number of males in each age
totalage <- hypertensionData_1 %>%
  filter(gender==1) %>%
  group_by(age) %>%
  count(age)

totalage$no_of_female_participants <- totalage$n


hypertensionFemaleProb <- merge(hypertensionCountFemale,totalage, by = "age") %>%
  transmute(age,no_of_hypertension_females,no_of_female_participants,female_hypertension_probability = no_of_hypertension_females/no_of_female_participants )

# write data
write.csv( hypertensionFemaleProb, file = 'intermediates/data/hypertensionFemaleProbData.csv', row.names=FALSE)