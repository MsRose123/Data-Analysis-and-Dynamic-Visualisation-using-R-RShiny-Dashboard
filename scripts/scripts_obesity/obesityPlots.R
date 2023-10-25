#---
# title: "obesity_plots"
# author: 'StduentNo : 2332635'
#---

# load library  
library("tidyverse")

# read data
data_obesity_all <- read.csv("intermediates/data/obeseProbData.csv")
data_obesity_male <- read.csv("intermediates/data/obeseMaleProbData.csv")
data_obesity_female <- read.csv("intermediates/data/obeseFemaleProbData.csv")

# plot for all participants in each age
fig_all <- ggplot(data_obesity_all, aes(x=age,y=obesity_probability))+geom_line()+
  xlab("age in years") + 
  ylab("Obesity Probability")

fig_all %>% ggsave(filename="results/obesity_results/fig-all.png", plot=.)

#probability of obese people in each age - male only (gender = 0)
fig_male <- ggplot(data_obesity_male, aes(x=age,y=male_obesity_probability))+geom_line()+
  xlab("age in years") + 
  ylab("Obesity Probability in Males")

fig_male %>% ggsave(filename="results/obesity_results/fig-male.png", plot=.)

#probability of obese people in each age - female only (gender = 1)
fig_female <- ggplot(data_obesity_female, aes(x=age,y=female_obesity_probability))+geom_line()+
  xlab("age in years") + 
  ylab("Obesity Probability in females")

fig_female %>% ggsave(filename="results/obesity_results/fig-female.png", plot=.)

#probability of obese people (male and female) in each age
fig_both <- ggplot()+
  geom_line(data = data_obesity_male, aes(x=age,y=male_obesity_probability),col="blue")+
  geom_line(data = data_obesity_female, aes(x=age,y=female_obesity_probability),col="red")+
  xlab("age in years") + 
  ylab("Obesity Probability")

fig_both %>% ggsave(filename="results/obesity_results/fig-both.png", plot=.)
