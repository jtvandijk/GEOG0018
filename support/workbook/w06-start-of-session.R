# w06 start of session (chapter 1, about 3 minutes)
#
# topics
# - the raw csv file before it is loaded into R
# - a live example of a 'file not found' error, and how to fix it
#
# what students should take away
# - a csv file is plain text: one row per line, values separated by commas
# - read_csv() turns that text into a table
# - R can only read a file if it looks in the right place, and the error says
#   where it looked
#
# before you start
# - open the GEOG0018 RStudio project, so that the working directory is the
#   folder that contains data/
# - run the script line by line (Cmd + Return or Ctrl + Enter), not all at once:
#   the error in step 3 stops a run-all

# 1. the raw file
# show the first six lines exactly as they are stored in the file
writeLines(readLines('data/London-LSOA-AgeGroup.csv', n = 6))
# point out: the first line holds the column names, every other line is one row,
# commas separate the values
# nothing here is a table yet, it is only text

# 2. the same file in R
library(tidyverse)
lsoa_age <- read_csv('data/London-LSOA-AgeGroup.csv')
head(lsoa_age)
# point out: the same six values, now in columns
# the Environment pane shows lsoa_age as a dataframe

# 3. a 'file not found' error
# the file extension is misspelled on purpose (cvs instead of csv)
lsoa_age <- read_csv('data/London-LSOA-AgeGroup.cvs')
# point out: the error names the file and the folder where R looked
# 'does not exist in current working directory'
# students should notice that the message describes the problem

# 4. the fix
# where is R looking?
getwd()
# what is in the data folder?
list.files('data')
# the file is called ...csv, so correct the name and run the line again
lsoa_age <- read_csv('data/London-LSOA-AgeGroup.csv')
# students should notice: compare the name in the error with the names in the
# folder, then copy the correct name rather than typing it again
