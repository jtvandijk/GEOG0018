# w07 start of session (chapter 2, about 4 minutes)
#
# topics
# - p-values in scientific notation, such as 2.2e-16
# - the error 'grouping factor must have exactly 2 levels'
#
# what students should take away
# - 2.2e-16 is a very small number (0.00000000000000022): the p-value is far
#   below 0.05, so report it as p < 0.001
# - a t-test compares exactly two groups: with three groups the error tells you
#   to use another test (ANOVA, which is next in the tutorial)
#
# before you start
# - open the GEOG0018 RStudio project, so that the working directory is the
#   folder that contains data/
# - run the script line by line (Cmd + Return or Ctrl + Enter), not all at once:
#   the error in step 4 stops a run-all

# 1. scientific notation
# type these in the console one by one
0.05
0.0001
# point out: R prints 0.0001 as 1e-04, because it switches to scientific notation
# when that is shorter
1e-4
5e-5
2.2e-16
# point out: e-4 means move the decimal point four places to the left, so 1e-04 is 0.0001
# 2.2e-16 is 0.00000000000000022, a decimal point followed by fifteen zeros and then 22
format(2.2e-16, scientific = FALSE)
# is it smaller than the usual cut-off of 0.05?
2.2e-16 < 0.05

# 2. prepare some real data (run this block in one go, no need to explain it)
library(tidyverse)
library(janitor)
lsoa_age <- read_csv('data/London-LSOA-AgeGroup.csv') |>
  clean_names()
lsoa_children <- lsoa_age |>
  filter(age_5_categories == 'Aged 15 years and under') |>
  mutate(borough_name = substr(lower_layer_super_output_areas, 1, nchar(lower_layer_super_output_areas) - 5))

# 3. a t-test with a tiny p-value
# compare the number of children per LSOA in Camden and Newham
two_boroughs <- lsoa_children |>
  filter(borough_name %in% c('Camden', 'Newham'))
t_result <- t.test(observation ~ borough_name, data = two_boroughs)
t_result
# point out: the p-value is printed as 'p-value < 2.2e-16'
# R does not print anything smaller than 2.2e-16, so read it as 'smaller than'
# the exact value is stored in the result
t_result$p.value
# students should notice: it is a very small number, not 2.2 and not zero
# report it as p < 0.001

# 4. the error
# add a third borough and run the same test
three_boroughs <- lsoa_children |>
  filter(borough_name %in% c('Camden', 'Newham', 'Sutton'))
t.test(observation ~ borough_name, data = three_boroughs)
# point out: 'grouping factor must have exactly 2 levels'
# the grouping factor is borough_name, and it now has three levels
table(three_boroughs$borough_name)
# students should notice: a t-test compares two groups
# for three or more groups use an ANOVA
summary(aov(observation ~ borough_name, data = three_boroughs))
# the ANOVA prints its p-value as <2e-16, which is the same idea
