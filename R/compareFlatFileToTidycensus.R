#
# match GA flat file PUMS to tidycensus

# read the tidycensus GA data for 2019 5 year
source("./R/read2019PUMSTidycensus.R")

# read the flat file GA files for 2019 5 year 
source("./R/readPUMS2019Georgia.R")

# confirm unique Household IDs - flat file
serialNumbers <- unique(household$SERIALNO)
serialNumbers_tidycensus <- unique(ga_pums_person$SERIALNO)
length(serialNumbers) - length(serialNumbers_tidycensus)
mismatches <- serialNumbers[!(serialNumbers %in% serialNumbers_tidycensus)]

mismatched_households <- household[household$SERIALNO %in% mismatches, ]

# verify that they're all vacant buildings
table(mismatched_households$NP)

table(mismatched_households$BLD)

# weights in vacant buildings
sum(mismatched_households$WGTP)

# difference betweeen weights in original file vs. tidycensus ile
sum(household$WGTP) - sum(ga_pums_household$WGTP)