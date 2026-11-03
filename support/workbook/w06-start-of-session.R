# w06 start of session
# run line by line from the GEOG0018 project

# raw file
writeLines(readLines('data/London-LSOA-AgeGroup.csv', n = 6))

# load file
library(tidyverse)
lsoa_age <- read_csv('data/London-LSOA-AgeGroup.csv')
head(lsoa_age)

# file not found
lsoa_age <- read_csv('data/London-LSOA-AgeGroup.cvs')

# fix
getwd()
list.files('data')
lsoa_age <- read_csv('data/London-LSOA-AgeGroup.csv')
