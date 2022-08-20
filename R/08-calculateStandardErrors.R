#
# 08-calculateStandardErrors.R

system.time(ga_pums_rep_weights <- get_pums(
  variables = c("PUMA", "SEX", "AGEP", "SCHL"),
  state = "GA",
  survey = "acs5",
  year = 2019,
  recode = TRUE,
  rep_weights = "person"))

format(object.size(ga_pums_rep_weights),unit="Mb")

saveRDS(ga_pums_rep_weights,"./data/Georgia/ga_pums_person_rep_weights.rds")

library(survey)
library(srvyr)

ga_survey_design <- to_survey(ga_pums_rep_weights)

ga_survey_design %>% 
  mutate(SEX_label = factor(SEX,labels = c("Male","Female"),ordered=TRUE)) %>% 
  survey_count(PUMA, SEX_label) -> ga_counts_se
head(ga_counts_se)

# now replicate process w/ flat file
system.time(if(!file.exists("./data/Georgia/psam_p13.csv")){
  download.file("https://www2.census.gov/programs-surveys/acs/data/pums/2019/5-Year/csv_pga.zip",
                "./data/csv_pga.zip",
                method="curl",
                mode="wb")
  unzip("./data/csv_pga.zip",exdir="./data/Georgia")
})
library(readr)
system.time(ga_pums_rep_weights_file  <- 
              read_csv("./data/Georgia/psam_p13.csv",col_names = TRUE)
)
format(object.size(ga_pums_rep_weights_file),unit="Mb")

ga_survey_design_file <- to_survey(ga_pums_rep_weights_file)

ga_survey_design_file %>% 
  mutate(SEX_label = factor(SEX,labels = c("Male","Female"),ordered=TRUE)) %>% 
  survey_count(PUMA, SEX_label) -> ga_counts_se_file
head(ga_counts_se_file)

identical(ga_counts_se,ga_counts_se_file)
