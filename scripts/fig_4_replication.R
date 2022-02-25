#### Preamble ####
# Purpose: Clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: Kimlin Chin
# Date: 22 February 2022
# Contact: kimlin.chin@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
# Use R Projects, not setwd().
library(haven)
library(tidyverse)
# Read in the raw data. 
raw_data <- read_dta("inputs/data/longdiff-RHS-0408.dta")
raw_data2 <- read_dta("inputs/data/longdiff-RHS-1519.dta")


#### What's next? ####