#
# 07-compareObjects.R

# save to tibble to compare objects
# flat file version
person %>%
  group_by(PUMA,SEX) %>%
  summarise(total_pop = sum(PWGTP),
            mean_age = weighted.mean(AGEP, PWGTP)
  ) -> wgt_mean_person

# tidycensus version
ga_pums_person %>%
  mutate(SEX = as.numeric(SEX)) %>% 
  group_by(PUMA,SEX) %>%
  summarise(total_pop = sum(PWGTP),
            mean_age = weighted.mean(AGEP, PWGTP)
  ) -> wgt_mean_person_tidycensus

identical(wgt_mean_person,wgt_mean_person_tidycensus)

