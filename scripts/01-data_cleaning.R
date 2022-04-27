#### Preamble ####
# Purpose: Prepare 2017 Canada International Travel Survey (ITS) dataset
# Author: Xuetong Tang
# Data: 27 April 2022
# Contact: louise.tang@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the csv document of 2017 International Travel Survey (ITS) dastaset by Statistics Canada


#### Workspace setup ####
# Use R Projects not setwd().
library(tidyverse)
library(kableExtra)
library(lmtest)
library(ggplot2)

# read raw data
data <- read.csv("~/Desktop/Canada-tourism/inputs/data/ITS-3152-E-2017-VIS_F1.csv")

# data cleaning
## rename variables and select variable of interest
clean_data<-data %>% 
  rename(number_people=VTPSZE,trip_reason=VRSN6C, entry_place=VRTEN, total_days=VTOTDAYS, total_spending=VGLTOTSP, visitor_id=VPUMFID)%>%
  mutate(carrier_class=case_when(VCFARE1==1~"First class",
                                 VCFARE2==1~"Business class",
                                 VCFARE3==1~"Economy class",
                                 VCFARE4==1~"Charter",
                                 VCFARE5==1~"Travel reward program"))%>%
  select(visitor_id,number_people,trip_reason,entry_place,total_days,total_spending,carrier_class)%>%
  mutate(entry_place=case_when(entry_place==1~"United States",
                               entry_place==2~"Country not United States",
                               entry_place==3~"Other country via United States"))%>%
  filter(!is.na(carrier_class))%>% # move out missing values
  mutate(trip_reason=as.factor(trip_reason), entry_place=as.factor(entry_place)) # mutate variable to be dummy variable



         