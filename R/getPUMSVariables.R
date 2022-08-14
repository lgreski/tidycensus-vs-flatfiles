library(tidycensus)
library(tidyverse)

pums_vars_2019 <- pums_variables %>% 
  filter(year == 2019, survey == "acs5") %>% 
  distinct(var_code, var_label, data_type, level)



