#
# 06-analyzePersonFile.R

person %>%
  group_by(PUMA,SEX) %>%
  summarise(total_pop = sum(PWGTP),
            mean_age = weighted.mean(AGEP, PWGTP)
  )


