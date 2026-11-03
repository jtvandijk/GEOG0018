# w10 start of session (chapter 5, DRAFT, about 4 minutes)
#
# topics
# - crime records without coordinates
# - one borough's crime rate calculated by hand
#
# what students should take away
# - not every record in a table can be put on a map: count what is left out
# - a crime rate is the number of crimes divided by the population, scaled to
#   per 10,000 residents, and you can check it with a calculator
#
# before you start
# - open the GEOG0018 RStudio project, so that the working directory is the
#   folder that contains data/
# - the demo uses R only, so QGIS does not need to be open

# 1. the crime records
library(tidyverse)
crime <- read_csv('data/London-Crime-2021.csv')
nrow(crime)
head(crime)
# point out: one row per crime, with a month, a longitude, a latitude and a crime type

# 2. records without coordinates
# how many rows have no longitude or latitude?
sum(is.na(crime$Longitude))
# as a percentage of all records
mean(is.na(crime$Longitude)) * 100
# point out: 1,214 of 38,229 records (3.2%) have no location
# these records cannot be drawn as points
# keep only the records with coordinates
crime_mapped <- crime |>
  filter(!is.na(Longitude) & !is.na(Latitude))
nrow(crime_mapped)
# students should notice: 37,015 records remain
# the prepared layer data/London-Crime-2021-BNG.gpkg has the same number of
# features, so the counts per borough in the tutorial are based on 37,015
# crimes, not 38,229
# in QGIS: right-click the points layer and choose Show Feature Count

# 3. a crime rate worked out by hand
# values for Kingston upon Thames, from the attribute table of
# data/London-Borough-Crime.gpkg: 428 thefts and 168,061 residents
428 / 168061 * 10000
# point out: 25.47 thefts per 10,000 residents
# students should notice: the same number as the crime-rate column in QGIS
# the rate is the count divided by the population, times 10,000
