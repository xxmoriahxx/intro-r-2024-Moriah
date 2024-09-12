####Aggregating and Summarizing Data ####
# start code by calling up needed libraries

#Load packages ----
library(readxl)
library(dplyr)
library(ggplot2)

#Read in the Excel file ----
df <- read_excel("data/icebreaker_answers.xlsx")
df
summary(df)



# Custom summaries of an entire data frame----
df |> summarize(
  avg_dist = mean(travel_distance),
  sd_dist = sd(travel_distance),
  pct60_dist = quantile(travel_distance, prob = 0.6),
  avg_time = mean(travel_time)
  )

# an aside: if you want an integer value, you must specify
df <- mutate (travel_time = as.integer(travel_time))

#assign the summary if you want to save
# View ()   uses capital letter!
df |> summarize(
  avg_dist = mean(travel_distance),
  sd_dist = sd(travel_distance),
  pct60_dist = quantile(travel_distance, prob = 0.6),
  avg_time = mean(travel_time)
)

View(df_summ) #same as clicking df_summ in Environment window



#saving this as an object, it will appear as a table in the global env window
df_summ <- df |> summarize(
  avg_dist = mean(travel_distance),
  sd_dist = sd(travel_distance),
  pct60_dist = quantile(travel_distance, prob = 0.6),
  avg_time = mean(travel_time)
)

# Aggregating and summarizing subsets ----
# of a data frame

df <- df |>
  mutate(travel_speed = travel_distance / travel_time * 60)
df |>
  summarize(avg_speed = mean (travel_speed))

# average speed by mode
df |> group_by(travel_mode) |>
  summarize(avg_speed = mean (travel_speed))

# sort results by avg speed instead
df |> group_by(travel_mode) |>
  summarize(avg_speed = mean (travel_speed)) |>
  arrange(desc(avg_speed))


# grouped data frame
df_mode_grp <-df |> group_by(travel_mode)

# str shows structure of object
str(df_mode_grp)

# grouping by multiple variables
# by default, summarize will leave data grouped by next higher level
df_mode_comma_grp <- df |> group_by (travel_mode, serial_comma) |>
  summarize (avg_speed = mean (travel_speed))

# have to explicitly ungroup(), do this after you have created new table from grouped data
df_mode_comma_ungrp <- df |> group_by(travel_mode, serial_comma) |>
  summarize (avg_speed = mean(travel_speed)) |>
  ungroup()
df_mode_comma_ungrp

# Frequencies ----
# so common there are shortcuts
# count up frequencies for group
df |> group_by(serial_comma) |>
  summarize(n = n())

#quicker version
df |> group_by (serial_comma) |>
  tally()

df |> count(serial_comma)
# can arrange this within, where T equals true, so yeses are on top here
df |> count(serial_comma, sort=T)

#calculate mode split (% each mode)
df |> count(travel_mode) # just checking the n per group

df |> group_by(travel_mode) |>
  summarize(split = n() / nrow(df) * 100) |>
  arrange(desc(split))  # this was splitting into group, divide by total, make it %, sort by popularity
  


