# libraries
library(tidyverse)
library(janitor)

# read
elec <- read_csv('data/UK-GE2024-Constituency.csv')
age <- read_csv('data/EW-PC2024-AgeGroup.csv')
eco <- read_csv('data/EW-PC2024-EconomicStatus.csv')
eth <- read_csv('data/EW-PC2024-EthnicGroup.csv')

# election results
elec <- elec |>
  janitor::clean_names() |>
  filter(country_name == 'Wales' | country_name == 'England') |>
  select(1, 3, 5, 13, 15, 16, 19, 20, 21)
names(elec) <- c('constituency_code','constituency_name', 
                 'region_name', 'winning_party', 'eligible_voters', 'valid_votes',
                 'conservative_votes', 'labour_votes', 'libdem_votes')
elec <- elec |>
  mutate(conservative_vote_share = conservative_votes/valid_votes,
         labour_vote_share = labour_votes/valid_votes,
         libdem_vote_share = libdem_votes/valid_votes)

# update parties
elec <- elec |>
  mutate(winning_party = if_else(winning_party == 'Con' | winning_party == 'Lab' | winning_party == 'LD', winning_party, 'Other'))
write_csv(elec, 'data/EW-GE2024-Results.csv')

# age variable - pivot
names(age)[1:2] <- c('constituency_code','constituency_name')
age <- age |>
  janitor::clean_names() |>
  pivot_wider(id_cols = c('constituency_code', 'constituency_name'),
              names_from = 'age_5_categories', values_from = 'observation') |>
  janitor::clean_names()

# age variable - proportion
age <- age |>
  rowwise() |>
  mutate(pc_pop = sum(across(3:7))) |>
  mutate(across(3:7, ~./pc_pop)) |>
  select(-pc_pop)

# eco variable - pivot
names(eco)[1:2] <- c('constituency_code','constituency_name')
eco <- eco |>
  janitor::clean_names() |>
  pivot_wider(id_cols = c('constituency_code', 'constituency_name'),
              names_from = 'economic_activity_status_4_categories', values_from = 'observation') |>
  janitor::clean_names()
names(eco)[3:6] <- c('eco_not_applicable', 'eco_active_employed', 'eco_active_unemployed', 'eco_inactive')

# eco variable - proportion
eco <- eco |>
  rowwise() |>
  mutate(pc_pop = sum(across(3:6))) |>
  mutate(across(3:6, ~./pc_pop)) |>
  select(-pc_pop, -constituency_name)

# eth variable - pivot
names(eth)[1:2] <- c('constituency_code','constituency_name')
eth <- eth |>
  janitor::clean_names() |>
  pivot_wider(id_cols = c('constituency_code', 'constituency_name'),
              names_from = 'ethnic_group_6_categories', values_from = 'observation') |>
  janitor::clean_names()
names(eth)[3:8] <- c('eth_na', 'eth_asian', 'eth_black', 'eth_mixed', 'eth_white', 'eth_other')

# eth variable - proportion
eth <- eth |>
  rowwise() |>
  mutate(pc_pop = sum(across(3:8))) |>
  mutate(across(3:8, ~./pc_pop)) |>
  select(-pc_pop, -eth_na, -constituency_name)

# join
att <- age |>
  left_join(eco, by = 'constituency_code') |>
  left_join(eth, by = 'constituency_code')

# add categorical variable
att <- att |>
  mutate(pop_50plus_40percent = if_else(aged_50_years_and_over >= 0.4, 'yes','no'),
         pop_white_90percent = if_else(eth_white >= 0.9, 'yes', 'no'))
write_csv(att, 'data/EW-GE2024-Demographics.csv')

# join
elec_att <- elec |>
  left_join(att[,c(1,3:18)], by = 'constituency_code')
write_csv(elec_att, 'data/EW-GE2024-Constituency-Vars.csv')
