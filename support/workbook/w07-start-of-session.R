# w07 start of session
# run line by line from the GEOG0018 project

# scientific notation
0.05
0.0001
1e-4
5e-5
2.2e-16
format(2.2e-16, scientific = FALSE)
2.2e-16 < 0.05

# prepare data
library(tidyverse)
library(janitor)
lsoa_age <- read_csv('data/London-LSOA-AgeGroup.csv') |>
  clean_names()
lsoa_children <- lsoa_age |>
  filter(age_5_categories == 'Aged 15 years and under') |>
  mutate(borough_name = substr(lower_layer_super_output_areas, 1, nchar(lower_layer_super_output_areas) - 5))

# t-test with two boroughs
two_boroughs <- lsoa_children |>
  filter(borough_name %in% c('Camden', 'Newham'))
t_result <- t.test(observation ~ borough_name, data = two_boroughs)
t_result
t_result$p.value

# error with three boroughs
three_boroughs <- lsoa_children |>
  filter(borough_name %in% c('Camden', 'Newham', 'Sutton'))
t.test(observation ~ borough_name, data = three_boroughs)
table(three_boroughs$borough_name)

# anova for three groups
summary(aov(observation ~ borough_name, data = three_boroughs))
