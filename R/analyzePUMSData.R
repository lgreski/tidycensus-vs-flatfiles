#
#
# analyzing the PUMS data

# count people by PUMA by SEX in Georgia 

ga_pums_person %>%
  count(PUMA,SEX,wt = PWGTP) -> tidyCounts

person %>% 
  count(PUMA,SEX,wt = PWGTP) -> flatFileCounts

differences <- flatFileCounts$n - tidyCounts$n
sum(differences)

# Calculate % with a bachelor's degree or above 

ga_pums_person %>% 
  mutate(ba_above = SCHL %in% c("21", "22", "23", "24")) %>% 
  group_by(PUMA, SEX) %>% 
  summarize(
    total_pop = sum(PWGTP),
    mean_age = weighted.mean(AGEP, PWGTP),
    ba_above = sum(PWGTP[ba_above == TRUE & AGEP >= 25]),
    ba_above_pct = ba_above / sum(PWGTP[AGEP >= 25]) 
  ) -> tidyCalcs

person %>% 
  mutate(ba_above = SCHL %in% c("21", "22", "23", "24")) %>% 
  group_by(PUMA, SEX) %>% 
  summarize(
    total_pop = sum(PWGTP),
    mean_age = weighted.mean(AGEP, PWGTP),
    ba_above = sum(PWGTP[ba_above == TRUE & AGEP >= 25]),
    ba_above_pct = ba_above / sum(PWGTP[AGEP >= 25]) 
  ) -> flatFileCalcs

# convert to survey design 

library(srvyr, warn.conflicts = FALSE)
ga_survey_design <- to_survey(person)
ga_survey_design %>% 
  survey_count(PUMA, SEX) -> flatFileSE

# read person level data, with weights this time 
# runs in about 95 seconds because the API makes two calls that 
# extract over 100mb each 

system.time(ga_pums_person <- get_pums(
  variables = c("SEX", "AGEP","PUMA","SCHL"),
  state = "GA",
  survey = "acs5",
  year = 2019,
  recode = TRUE,
  rep_weights = "person"
))
ga_survey_design_tidy <- to_survey(ga_pums_person)
ga_survey_design_tidy %>% 
  survey_count(PUMA, SEX) -> tidySE
