#---
# title: "dataTransformObesity"
# author: 'StduentNo : 2332635'
#---

library(dplyr)
library(tidyr)

wd <- getwd()
setwd(wd)

obesityData <- read.csv("cleanData/obesityData.csv")

# adding column obese
# 0 - not obese
# 1 - obese
obesityData <- obesityData %>% 
  mutate(obese = ifelse(bodyMassIndex >= 30,1,0))

# write obeses
write.csv( obesityData, file = 'intermediates/data/obesityTransformedData.csv', row.names=FALSE)

# no  of people obese in each age
obeseCount <- obesityData %>% 
  group_by(age) %>%
  filter(obese==1) %>%
  count(obese)

obeseCount$no_of_obese_participants <- obeseCount$n

#total number of people in each age
totalage <- obesityData %>%
  group_by(age) %>%
  count(age)

totalage$no_of_participants <- totalage$n


obeseProb <- merge(obeseCount,totalage, by = "age") %>%
  transmute(age,no_of_obese_participants,no_of_participants,obesity_probability = no_of_obese_participants/no_of_participants )


write.csv( obeseProb, file = 'intermediates/data/obeseProbData.csv', row.names=FALSE)


#probability of obese people in each age - male only (gender = 0)

# no  of people obese in each age
obeseCountMale <- obesityData %>% 
  group_by(age) %>%
  filter(obese==1 & gender==0) %>%
  count(obese)

obeseCountMale$no_of_obese_males <- obeseCountMale$n

#total number of males in each age
totalage <- obesityData %>%
  filter(gender==0) %>%
  group_by(age) %>%
  count(age)

totalage$no_of_male_participants <- totalage$n

obeseMaleProb <- merge(obeseCountMale,totalage, by = "age") %>%
  transmute(age,no_of_obese_males,no_of_male_participants,male_obesity_probability = no_of_obese_males/no_of_male_participants )


write.csv( obeseMaleProb, file = 'intermediates/data/obeseMaleProbData.csv', row.names=FALSE)


#probability of obese people in each age - female only (gender = 1)

# no  of people obese in each age
obeseCountFemale <- obesityData %>% 
  group_by(age) %>%
  filter(obese==1 & gender==1) %>%
  count(obese)

obeseCountFemale$no_of_obese_females <- obeseCountFemale$n


#total number of males in each age
totalage <- obesityData %>%
  filter(gender==1) %>%
  group_by(age) %>%
  count(age)

totalage$no_of_female_participants <- totalage$n

obeseFemaleProb <- merge(obeseCountFemale,totalage, by = "age") %>%
  transmute(age,no_of_obese_females,no_of_female_participants,female_obesity_probability = no_of_obese_females/no_of_female_participants )

write.csv( obeseFemaleProb, file = 'intermediates/data/obeseFemaleProbData.csv', row.names=FALSE)

