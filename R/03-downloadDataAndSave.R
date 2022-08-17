#
#
# 03-downloadDataAndSave.R


# read person level data 
system.time(ga_pums_person <- get_pums(
  variables = c("SEX", "AGEP","PUMA","SCHL"),
  state = "GA",
  survey = "acs5",
  year = 2019,
  recode = TRUE 
))

# save person data
# create data directories if needed
if(!dir.exists("./data")) dir.create("./data")
if(!dir.exists("./data/Georgia")) dir.create("./data/Georgia")

saveRDS(ga_pums_person,"./data/Georgia/ga_pums_person.rds")

