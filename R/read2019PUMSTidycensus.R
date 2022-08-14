#
# reading PUMS data with tidycensus
#

# read Georgia 2019 5 year data

# read household data 
library(tidycensus)
library(tidyverse)
install.packages(c("survey", "srvyr"))

# install census API key, if needed 
# census_api_key("REDACTED",install = TRUE)
# when installing key, run the following line to access the key from the
# R Environment 
# readRenviron("~/.Renviron")

# read person level data 
system.time(ga_pums_person <- get_pums(
  variables = c("SEX", "AGEP"),
  state = "GA",
  survey = "acs5",
  year = 2019,
  recode = TRUE
))


# household data is accessible by filtering to the first person in the household
# SPORDER = 1, per tidycensus website 
# https://walker-data.com/tidycensus/articles/pums-data.html  

system.time(ga_pums_household <- get_pums(
  variables = c("ADJHSG", "ADJINC","TYPE","WGTP"),
  state = "GA",
  survey = "acs5",
  variables_filter = list(SPORDER = 1),
  year = 2019,
  recode = TRUE
))