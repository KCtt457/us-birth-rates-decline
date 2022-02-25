#### Preamble ####
# Purpose: Figure 2a replication
# Author: Kimlin Chin
# Date: 22 February 2022
# Contact: kimlin.chin@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
# Load libraries
library(tidyverse)
library(ggprism)
library(ggthemes)

# Read in the raw data. 
fig_2_data <- read_csv("inputs/data/figs_2a_2b.csv")

# Data wrangling
fig_2a_data <- fig_2_data %>%
  select(-c(brate_whitenh, brate_blacknh, brate_hisp)) %>%
  pivot_longer(-c(year), names_to = "age_group", values_to = "brate")

# Make plot
fig_2a_data %>%
  ggplot(aes(x = year,
             y = brate,
             color = age_group)) +
  geom_line() +
  geom_vline(xintercept = 2007,
             linetype = "dashed",
             color = "darkgrey") +
  scale_x_continuous(
    guide = "prism_minor",
    limits = c(1980, 2020),
    breaks = seq(1980, 2020, by = 5),
    minor_breaks = seq(1980, 2020, by = 1)
  ) +
  scale_y_continuous(limits = c(0, 140), breaks = seq(0, 140, by = 20)) +
  scale_color_tableau(palette = "Color Blind") +
  theme_classic() +
  theme(
    panel.grid.major.y = element_line(),
    axis.ticks.length.x = unit(7, "pt"),
    prism.ticks.length.x = unit(4, "pt"),
    legend.position = "none"
  ) +
  geom_text(
    aes(x = 2007, y = 120),
    nudge_x = 2,
    nudge_y = 7,
    label = "2007",
    color = "#000000"
  ) +
  geom_text(aes(x = 1985, y = 125), label = "Age 25-29", color = "#000000") +
  geom_text(aes(x = 1985, y = 100), label = "Age 20-24", color = "#000000") +
  geom_text(aes(x = 1985, y = 80), label = "Age 30-34", color = "#000000") +
  geom_text(aes(x = 1985, y = 60), label = "Age 15-19", color = "#000000") +
  geom_text(aes(x = 1985, y = 30), label = "Age 35-39", color = "#000000") +
  geom_text(aes(x = 1985, y = 10), label = "Age 40-44", color = "#000000") +
  labs(
    title = "Trends in Birth Rates by Population Subgroup",
    subtitle = "A: Five-year age group",
    x = "",
    y = "Births per 1,000 women in\n relevant population subgroup",
    caption = "Source: Birth rates by age group, race and ethnicity, and marital 
    status are gathered from CDC Vital Statistics Births Reports."
  )

# Save plot
ggsave(
  "outputs/plots/figure2a.png",
  height = 100,
  width = 133.33,
  units = "mm",
  dpi = 900
)
