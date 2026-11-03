# w08 start of session
# run line by line from the GEOG0018 project

# load data and run model
library(tidyverse)
elec_vars <- read_csv('data/EW-GE2024-Constituency-Vars.csv')
lm_voteshare <- lm(conservative_vote_share ~ aged_50_years_and_over, data = elec_vars)
coef(lm_voteshare)

# prediction by hand: 30% aged 50 or over
-0.039 + 0.740 * 0.30

# prediction by R
predict(lm_voteshare, newdata = data.frame(aged_50_years_and_over = 0.30))

# one percentage point more
predict(lm_voteshare, newdata = data.frame(aged_50_years_and_over = 0.31))
-0.039 + 0.740 * 0.31 - (-0.039 + 0.740 * 0.30)

# error
lm(conservative_vote_share ~ aged_50, data = elec_vars)
names(elec_vars)
elec_vars |> select(starts_with('aged')) |> names()

# optional: chi-square warning
chisq.test(matrix(c(2, 3, 4, 1), nrow = 2))
