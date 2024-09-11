# Read in csv file using base R
sta_meta <- read.csv("data/portal_stations.csv", stringsAsFactors = F)

str(sta_meta) # structure of data

head(sta_meta) # first 6 rows of data
tail(sta_meta)  # last 6 rows of data

nrow(sta_meta) # how many rows of data

summary(sta_meta) # see if min max out of range, if you have unexpected NAs

# Using Data Import shortcut to read in xlsx and copy/paste code
> library(readxl)
> icebreaker_answers <- read_excel("data/icebreaker_answers.xlsx")
> View(icebreaker_answers)