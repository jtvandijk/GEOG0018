# w09 start of session (chapter 4, DRAFT, about 4 minutes)
#
# topics
# - the raw spreadsheet as downloaded from Nomis, before any cleaning
# - row counts and missing values after an attribute join
#
# what students should take away
# - downloaded data rarely arrives as a clean table: look before you use it
# - a join can quietly leave rows without a match, so count the rows before and
#   after
#
# before you start
# - open the GEOG0018 RStudio project, so that the working directory is the
#   folder that contains data/
# - the demo uses R only, so QGIS does not need to be open
# - data/LSOA2011-population.xlsx is the raw Nomis download
#   (data/LSOA2011-population.csv is the cleaned version from the tutorial)
# - alternative: open data/LSOA2011-population.xlsx in Excel for step 1

# 1. the raw Nomis spreadsheet
library(tidyverse)
library(readxl)
nomis_raw <- read_excel('data/LSOA2011-population.xlsx', col_names = FALSE)
head(nomis_raw, 12)
# point out: the first eight rows are a title, a copyright line and notes, not data
# the area code and name sit together in one cell (E01000001 : City of London 001A)
# the column names are not in the first row
# students should notice: this is why the tutorial cleans the spreadsheet first

# 2. the cleaned tables from the tutorial
pop_2011 <- read_csv('data/LSOA2011-population.csv')
pop_2021 <- read_csv('data/LSOA2021-population.csv')
nrow(pop_2011)
nrow(pop_2021)
# point out: 4,835 areas in 2011 and 4,994 areas in 2021
# the number of areas differs between the two censuses

# 3. join the 2011 population to the 2021 areas and count
pop_joined <- left_join(pop_2021, pop_2011, by = c('lsoa21_code' = 'lsoa11_code'))
nrow(pop_joined)
# the number of rows is the same as before, but are all values filled?
sum(is.na(pop_joined$pop2011))
# point out: 335 areas in 2021 have no 2011 population (NA, shown as NULL in QGIS)
# the reverse also happens: 176 areas from 2011 have no match in 2021
sum(!pop_2011$lsoa11_code %in% pop_2021$lsoa21_code)
# students should notice: the join worked without an error, but not every area
# matched
# the areas were redrawn between the censuses, so some codes exist in only one
# of the two tables

# 4. the same check in QGIS
# after a join, open the attribute table and sort on the joined column:
# NULL values are areas without a match
