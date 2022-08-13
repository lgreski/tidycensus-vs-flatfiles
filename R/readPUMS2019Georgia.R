#
# read Georgia 2019 ACS data

# create data directories if needed
if(!dir.exists("./data")) dir.create("./data")
if(!dir.exists("./data/Georgia")) dir.create("./data/Georgia")

# download & extract Georgia household file if necessary 
system.time(if(!file.exists("./data/Georgia/psam_h13.csv")){
  download.file("https://www2.census.gov/programs-surveys/acs/data/pums/2019/5-Year/csv_hga.zip",
                "./data/csv_hga.zip",
                method="curl",
                mode="wb")
  unzip("./data/Georgia.zip",exdir="./data/Georgia")
})
# download & extract Georgia person file if necessary 
system.time(if(!file.exists("./data/Georgia/psam_p13.csv")){
  download.file("https://www2.census.gov/programs-surveys/acs/data/pums/2019/5-Year/csv_pga.zip",
                "./data/csv_pga.zip",
                method="curl",
                mode="wb")
  unzip("./data/csv_pga.zip",exdir="./data/Georgia")
})

# download record layout if necessary
if(!file.exists("./data/5-year-PUMS-dictionary.csv")) {
  download.file("https://www2.census.gov/programs-surveys/acs/tech_docs/pums/data_dict/PUMS_Data_Dictionary_2015-2019.csv",
                "./data/5-year-PUMS-dictionary.csv",
                method="curl",
                mode="w")
}

# read the file 
library(readr)
system.time(household <- read_csv("./data/Georgia/psam_h13.csv",col_names = TRUE))
system.time(person <- read_csv("./data/Georgia/psam_p13.csv",col_names = TRUE))

table(person$AGEP,person$SEX)