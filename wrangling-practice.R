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
  
  