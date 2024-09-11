#### Practice Problem: Loading and manipulating a data frame ####
# Don't forget: Comment anywhere the code isn't obvious to you!

# Load the readxl and dplyr packages
library(readxl) # from the tidyverse, for reading Excel files, could also use GUI
library(dplyr) # for filtering data


# Use the read_excel function to load the class survey data - don't forget quotes
icebreaker_answers <- read_excel("data/icebreaker_answers.xlsx")

# Take a peek! Checking how the data look
icebreaker_answers
head(icebreaker_answers)
tail(icebreaker_answers)

# Create a travel_speed column in your data frame using vector operations and 
#   assignment - used t to stand for time, d for distance, then wrote equation for MPH
# dollar sign indicates column within table
t <- icebreaker_answers$travel_time
d <- icebreaker_answers$travel_distance
icebreaker_answers$travel_speed <-d/t*60

# Another way to compute the travel speed
icebreaker_answers$travel_speed <- (icebreaker_answers$travel_distance /
                                      icebreaker_answers$travel_time * 60)

# Look at a summary of the new variable--seem reasonable?
summary(icebreaker_answers$travel_speed)

boxplot(icebreaker_answers$travel_speed ~ icebreaker_answers$travel_mode) #quick plot, use tilde
hist(icebreaker_answers$travel_speed) #quick boxplot

# Choose a travel mode, and use a pipe to filter the data by your travel mode
bus_answers <- icebreaker_answers |>
  filter(
    travel_mode == "car"
  )

# Note the frequency of the mode (# of rows returned)
# 8

# Repeat the above, but this time assign the result to a new data frame
# data frame is a table of results from my operation
car_answers <- icebreaker_answers |>
  filter(
    travel_mode =="car")

# Look at a summary of the speed variable for just your travel mode--seem 
#   reasonable?
summary(car_answers)

# Filter the data by some arbitrary time, distance, or speed threshold
icebreaker_answers |>
  filter(
    travel_speed > 30
  )

# Stretch yourself: Repeat the above, but this time filter the data by two 
#   travel modes (Hint: %in%) - don't forget the C
icebreaker_answers |>
  filter(
    travel_mode %in% c("bus", "car")
  )

icebreaker_answers |> filter(travel_mode == "bus" | travel_mode == "car")


