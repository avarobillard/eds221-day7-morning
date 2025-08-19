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

# Practice lubridate within a data frame
urchin_counts <- tribble(
  ~date, ~species, ~size_mm,
  "10/3/2020", "purple", 55,
  "10/4/2020", "red", 48,
  "11/17/2020", "red", 67
)

urchin_counts %>% 
  mutate(date = lubridate::mdy(date)) %>% 
  mutate(year = lubridate::year(date),
         month = lubridate::month(date),
         day = lubridate::day(date))

day_1 <- lubridate::ymd("2020-01-06")
day_2 <- lubridate::ymd("2020-05-18")
day_3 <- lubridate::ymd("2020-05-19")

# create a time interval
time_interval <- interval(day_1, day_2)
time_length(time_interval, "week")
time_length(time_interval, "year")

# Practice with stringr

# str_detect() to detect string patters
# returns TRUE/FALSE depending on whether the pattern is detected

my_string <- "Teddy loves eating salmon and socks."

# does the pattern "love" exist within the string?
my_string %>% 
  str_detect("love")

my_string <- c("burrito", "fish taco", "taco salad")

# does the vector element contain the pattern "fish"?- checks each
my_string %>% 
  str_detect("fish")

# powerful when combined with dplyr functions
# str_detect()
starwars %>% 
  filter(str_detect(name, "Skywalker"))

# str_replace()
firewalkers <- starwars %>% 
  mutate(name = str_replace(name, pattern = "Sky", replacement = "Fire"))
# can also get rid of tiny issues/spelling errors

# cleaning up white space- str_squish() & str_trim()
feedback <- c(" I ate    some  nachos", "Wednesday morning  ")

# remove the leading, trailing, and duplicate spaces
str_squish(feedback)

# remove just the leading and trailing spaces
str_trim(feedback)

# convert cases- helps with case matching
str_to_lower(feedback)

str_to_upper(feedback)

str_to_tile(feedback)

# count matches in a string
str_count(feedback, pattern = 'nachos')