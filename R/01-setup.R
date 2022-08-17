#
# setup script for tidycensus-vs-flatfiles
# ./R/01-setup.R

library(tidycensus)
library(tidyverse)

# install census API key, if needed 
census_api_key("REDACTED",install = TRUE)

# when installing key, run the following line to access the key from the
# R Environment 
readRenviron("~/.Renviron")


