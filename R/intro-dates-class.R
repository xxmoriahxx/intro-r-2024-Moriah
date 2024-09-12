library(dplyr)
library(ggplot2)
library(lubridate)

stations <- read.csv("data/portal_stations.csv", stringsAsFactors = F)
detectors <- read.csv("data/portal_detectors.csv", stringsAsFactors = F)
data <- read.csv("data/agg_data.csv", stringsAsFactors = F)

str(detectors)
head(detectors$start_date) #first six rows of this one column, shows that last digits are offset from UTC

#convert from character class to date of time stamp
detectors$start_date <- ymd_hms(detectors$start_date) |> 
  with_tz ("US/Pacific") #lubridate is handling this yearmonthdate_hoursminsecs
head(detectors$start_date)

OlsonNames() #list of acceptable names for time zones

#convert detectors$end_date to date/time format
detectors$end_date <- ymd_hms(detectors$end_date) |>
  with_tz("US/Pacific")

#write filter for selecting for detectors that don't have end dates
open_det <- detectors |>
  filter(is.na(end_date))

#find closed detectors
closed_det <- detectors |>
  filter(!is.na(end_date))

#I want the total daily volume and average volume and average speed/static
data_stid <- data |>
  left_join(open_det, by = c("detector_id" = "detectorid")) |>
  select(detector_id, starttime, volume, speed, countreadings, stationid)

#convert starttime to datetime format
data_stid$starttime <- ymd_hms(data_stid$starttime) |>
  with_tz("US/Pacific")

daily_data <- data_stid |>
  mutate(date = floor_date(starttime, unit = "day")) |>
  group_by(stationid,
           date) |>
  summarize(
    daily_volume = sum(volume),
    daily_obs = sum(countreadings),
    mean_speed = mean(speed)
  ) |>
  as.data.frame()

# plot data to check it out
daily_volume_fig <- daily_data |>
  ggplot(aes(x = date, y = daily_volume)) +
  geom_line() +
  geom_point()+
  facet_grid(stationid  ~ ., scales = "free")
daily_volume_fig #need to add this line to get it to show you the figure

#install plotly from packages tab in window on right
library(plotly)
ggplotly(daily_volume_fig)

#how many stations do I have?
length(unique(daily_data$stationid))

#create new data frame

stids <- unique(daily_data$stationid)

start_date <- ymd("2023-03-01")
end_date <- ymd("2023-03-31")
date_df <- data.frame(
  date_seq = rep(seq(start_date, end_date, by = "1 day")),
  station_id  = rep(stids, each = 31)
)

data_with_gaps <- date_df |>
  left_join(daily_data, by = c("date_seq" = "date",
                               "station_id" = "stationid")
  )

#how to save data frame
write.csv(data_with_gaps, "data/data_with_gaps.csv", row.names = F) #now.names would number each row
saveRDS(data_with_gaps, "data/data_with_gaps.rds") #retains information about class structure - what types of variables etc, compresses file

mod_date_fig <- data_with_gaps|>
  filter(station_id %in% c(1056, 1057, 1059)) |>
  ggplot(aes(x = date_seq, y = daily_volume)) +
  geom_line(aes(color = "blue")) +
  geom_point(aes(color = "skyblue")) +
  facet_grid(station_id ~ .)
mod_date_fig

mod_date_fig2 <- mod_date_fig +
  scale_x_date(date_breaks = "1 day") + #this throws the erros for as date class
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
mod_date_fig2

mod_date_fig <- data_with_gaps |>
  filter(station_id %in% c(1056, 1057, 1059)) |>
  ggplot(aes(x = as.Date(date_seq), y = daily_volume)) +
  geom_line() +
  geom_point() +
  facet_grid(station_id ~ .) +
  scale_x_date(date_breaks = "1 day") + fixed to as.date
theme(axis.text.x = element_text(angle = 45, hjiust = 1)) +
  geom_hline(yintercept = mean(daily_data$daily_volume))
mod_date_fig




