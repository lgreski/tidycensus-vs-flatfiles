#
# 04-analyzeData.R

ga_pums_person %>%
  group_by(PUMA,SEX) %>%
  summarise(total_pop = sum(PWGTP),
            mean_age = weighted.mean(AGEP, PWGTP)
  )

