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