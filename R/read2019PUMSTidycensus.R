#
# reading PUMS data with tidycensus
#

# read Georgia 2019 5 year data

# read household data 
library(tidycensus)
library(tidyverse)

census_api_key("REDACTED",install = TRUE)

ga_pums <- get_pums(
  variables = c("SEX", "AGEP"),
  state = "GA",
  survey = "acs5",
  year = 2019,
  recode = TRUE
)

ga_pums_household <- get_pums(
  variables = c("ADJHSG", "ADJINC","TYPE"),
  state = "GA",
  survey = "acs5",
  variables_filter = list(SPORDER = 1),
  year = 2019,
  recode = TRUE
)