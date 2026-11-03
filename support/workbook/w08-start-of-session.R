# w08 start of session (chapter 3, about 4 minutes)
#
# topics
# - a regression prediction worked out by hand
# - the error 'object 'aged_50' not found'
#
# what students should take away
# - a regression coefficient is a number you can use: multiply, add, and compare
#   with predict() to check that you understand the output
# - 0.740 is a slope: one more percentage point of people aged 50 or over goes
#   with 0.74 more percentage points of Conservative vote share
# - variable names are long, and R needs them exactly right
#
# before you start
# - open the GEOG0018 RStudio project, so that the working directory is the
#   folder that contains data/
# - run the script line by line (Cmd + Return or Ctrl + Enter), not all at once:
#   the error in step 3 stops a run-all

# 1. load the data and run the model from the tutorial
library(tidyverse)
elec_vars <- read_csv('data/EW-GE2024-Constituency-Vars.csv')
lm_voteshare <- lm(conservative_vote_share ~ aged_50_years_and_over, data = elec_vars)
coef(lm_voteshare)
# point out: the intercept is -0.039 and the slope is 0.740
# both variables are proportions between 0 and 1, so 0.30 means 30%

# 2. a prediction worked out by hand
# a constituency in which 30% of the population is aged 50 or over
# intercept + slope * 0.30
-0.039 + 0.740 * 0.30
# the same prediction by R
predict(lm_voteshare, newdata = data.frame(aged_50_years_and_over = 0.30))
# students should notice: the two numbers agree (apart from rounding)
# the model predicts a Conservative vote share of about 18%

# one percentage point more: 31% instead of 30%
predict(lm_voteshare, newdata = data.frame(aged_50_years_and_over = 0.31))
# the difference between the two predictions is the slope times 0.01
-0.039 + 0.740 * 0.31 - (-0.039 + 0.740 * 0.30)
# point out: about 0.0074, which is 0.74 percentage points
# this is what 0.740 means in this model

# 3. the error
# mistype the name of the independent variable on purpose
lm(conservative_vote_share ~ aged_50, data = elec_vars)
# point out: R looks for a column called aged_50 and cannot find it
# the message gives the name that R could not find
# find the real name
names(elec_vars)
# or list all names that start with 'aged'
elec_vars |> select(starts_with('aged')) |> names()
# students should notice: copy the name from names() or use Tab completion in
# RStudio (type aged and press Tab), rather than retyping a long name

# optional extra, if there is time: a warning from the chi-square test
# the tutorial notes that the test needs expected counts of at least 5 per cell
# a tiny table breaks that rule
chisq.test(matrix(c(2, 3, 4, 1), nrow = 2))
# point out: 'Chi-squared approximation may be incorrect'
# students should notice: R warns you, and the result should not be trusted
