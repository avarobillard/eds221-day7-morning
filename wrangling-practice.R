# Clearning environment
rm(list = ls())

# Attach packages
library(tidyverse)
library(palmerpenguins)
library(lubridate) # help us work with dates

# Data wrangling refresher
# 1. only include penguins at Biscoe and Dream islands
# 2. remove year and sex variables
# 3. add a new column called body_mass_kg with penguin mass converted from grams to kg
# 4. rename the island variable to location

penguins %>% 
  filter(island %in% c("Biscoe", "Dream")) %>% 
  select(-year, -sex) %>% 
  mutate("body_mass_kg" = body_mass_g / 1000) %>% 
  rename(location = island)

penguins %>% 
  filter(species == "Adelie") %>% 
  filter(!is.na(flipper_length_mm), !is.na(sex)) %>% 
  group_by(sex) %>% 
  summarize(mean_flipper = mean(flipper_length_mm),
            sd_flipper = sd(flipper_length_mm),
            n_flipper = n())

# Mutating joins

animals <- data.frame(
  stringsAsFactors = FALSE,
          location = c("lagoon", "bluff", "creek", "oaks", "bluff"),
                      species = c("bobcat",
                                  "coyote","fox","squirrel","bobcat"),
                     maturity = c("adult",
                                  "juvenile","adult","juvenile","adult")
           )

sites <- data.frame(
  stringsAsFactors = FALSE,
          location = c("beach", "lagoon", "bluff", "oaks"),
    full_site_name = c("Goleta Beach","UCSB Lagoon",
                       "Ellwood Mesa","Fremont Campground"),
      jurisdiction = c("SB City", "UCSB", "SB City", "USFS")
)

# practice with full_join
# keeps all rows and adds all columns
full_join(animals, sites)

# left join
# adds all columns and rows for matching locations in sites
left_join(animals, sites)

# right join
# adds all columns and rows for matching locations in animals
right_join(animals, sites)

# inner join
# no NAs, full matches 
inner_join(animals, sites)

# Filtering joins

# semi join
# no new variables- just filtering rows
semi_join(animals, sites)

# same as this code:
animals %>% 
  filter(location %in% sites$location)

# anti join
anti_join(animals, sites)

# same as this code:
animals %>% 
  filter(!location %in% sites$location)

# Practice with lubridate
# function depends on date
my_date <- "03-13-1998"
lubridate::mdy(my_date) # fixed date to ISO 8601

# new format for date
my_date <- "08-Jun-1974"
lubridate::dmy(my_date)

my_date <- "19160518"
lubridate::ymd(my_date)

# what happens if we give date that doesn't make sense
lubridate::mdy("1942-08-30")

# know your date structure!
lubridate::dmy("09/12/84")

# working with date-times

time <- "2020-08-12 11:18"
time <- ymd_hm(time)

# convert to PDT
with_tz(time, tz = "America/Los_Angeles")

# extract info from dates
week(time)
year(time)
day(time)

start_time <- Sys.time()

end_time <- Sys.time()

# can print how long script took to run
end_time - start_time
