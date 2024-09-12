library(tidycensus) #acts as gateway for Census API for ACS and decennial Census data
# for more info: https://walker-data.com/tidycensus

library(dplyr)
library(tidyr)
library(ggplot2)

#### Run on 1st use if not already in R
census_api_key("DELETEDKEYTHATIADDED", install=T) #installs into R user environment, for privacy I deleted my key that I loaded
readRenviron("~/.Renviron")
####

#### User functions

####

# get a searchable census variable table
v19 <- load_variables(2019, "acs5")

v19 |> filter(grepl("^B08006_", name)) |> #grep is search for text string, caret is beginning
print(n=25)

# get the data for transit, work from home, and total workers ----
comm_19_raw <- get_acs(geography = "tract",
                            variables = c(wfh = "B08006_017", 
                                          transit = "B08006_008",
                                          tot = "B08006_001"),
                            county = "Multnomah", 
                            state = "OR",
                            year = 2019,
                            survey = "acs5",
                            geometry = FALSE) #can retrieve library(sf) spatial geometries pre-joined
 
comm_19_raw

# table has multiple observations for individual Census tracts, so we want to use "pivot and wider"

comm_19 <- comm_19_raw |>
  pivot_wider(id_cols = GEOID, 
              names_from = variable,
              values_from = estimate:moe)
comm_19  #tidied up and put all the variables for one tract into one row
# alternatively, can have multiple ID columns, e.g., GEOID:NAME)
