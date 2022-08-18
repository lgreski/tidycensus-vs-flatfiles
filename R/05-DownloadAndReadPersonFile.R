#
# 05-downloadAndReadPersonFile.R

# download & extract Georgia person file if necessary 
system.time(if(!file.exists("./data/Georgia/psam_p13.csv")){
  download.file("https://www2.census.gov/programs-surveys/acs/data/pums/2019/5-Year/csv_pga.zip",
                "./data/csv_pga.zip",
                method="curl",
                mode="wb")
  unzip("./data/csv_pga.zip",exdir="./data/Georgia")
})
library(readr)
system.time(person <- read_csv("./data/Georgia/psam_p13.csv",col_names = TRUE))
