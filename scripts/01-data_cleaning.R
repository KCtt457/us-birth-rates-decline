#### Preamble ####
# Purpose: Clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Kimlin Chin
# Date: 18 February 2022
# Contact: kimlin.chin@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
# Use R Projects, not setwd().
library(haven)
library(tidyverse)
# Read in the raw data. 
raw_data <- readr::read_csv("inputs/data/raw_data.csv"
                     )
# Just keep some variables that may be of interest (change 
# this depending on your interests)
names(raw_data)

reduced_data <- 
  raw_data %>% 
  select(first_col, 
         second_col)
rm(raw_data)
         

#### What's next? ####



         