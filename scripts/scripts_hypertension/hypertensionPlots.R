#---
#title: "hypertension_plots"
#author: 'StduentNo : 2332635'
#---
  
# load library  
library("tidyverse") 

# read data
data_hypertension_all <- read.csv("intermediates/data/hypertensionProbData.csv")
data_hypertension_male <- read.csv("intermediates/data/hypertensionMaleProbData.csv")
data_hypertension_female <- read.csv("intermediates/data/hypertensionFemaleProbData.csv") 

# plot for all participants in each age
fig_all <- ggplot(data_hypertension_all, aes(x=age,y=hypertension_probability))+geom_line()+
  xlab("age in years") + 
  ylab("Hypertension Probability")

fig_all %>% ggsave(filename="results/hypertension_results/fig-all.png", plot=.)

#probability of people with hypertension in each age - male only (gender = 0)
fig_male <- ggplot(data_hypertension_male, aes(x=age,y=male_hypertension_probability))+geom_line()+
  xlab("age in years") + 
  ylab("Hypertension Probability in Males")


fig_male %>% ggsave(filename="results/hypertension_results/fig-male.png", plot=.)

#probability of people with hypertension in each age - female only (gender = 1)
fig_female <- ggplot(data_hypertension_female, aes(x=age,y=female_hypertension_probability))+geom_line()+
  xlab("age in years") + 
  ylab("Hypertension Probability in Females")

fig_female %>% ggsave(filename="results/hypertension_results/fig-female.png", plot=.)

#probability of people (male and female) with hypertension in each age
fig_both <- ggplot()+
  geom_line(data = data_hypertension_male, aes(x=age,y=male_hypertension_probability),col="blue")+
  geom_line(data = data_hypertension_female, aes(x=age,y=female_hypertension_probability),col="red")+
  xlab("age in years") + 
  ylab("Hypertension Probability")

fig_both %>% ggsave(filename="results/hypertension_results/fig-both.png", plot=.)