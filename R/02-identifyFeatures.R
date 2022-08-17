#
# Identify features to be accessed from tidycensus for the 2019
# ACS public use microdata sample, 5 year estimates 
# 
# 02-identifyFeatures.R

library(tidycensus)
library(tidyverse)

pums_vars_2019 <- pums_variables %>% 
  filter(year == 2019, survey == "acs5") %>% 
  distinct(var_code, var_label, data_type, level)

