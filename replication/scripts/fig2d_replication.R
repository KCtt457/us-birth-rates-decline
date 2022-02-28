#### Preamble ####
# Purpose: Figure 2d replication
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
fig_2_data <- read_csv("inputs/data/figs_1_2_3.csv")

# Data wrangling
fig_2d_data <- fig_2_data %>%
  select(year, brate_hsdropout, brate_hsgrad, brate_somecol, brate_colgrad) %>%
  pivot_longer(-c(year), names_to = "education", values_to = "brate") %>%
  filter(year > 1989)

# Make plot
fig_2d_data %>%
  ggplot(aes(x = year,
             y = brate,
             color = education)) +
  geom_line() +
  geom_vline(xintercept = 2007,
             linetype = "dashed",
             color = "darkgrey") +
  scale_x_continuous(
    guide = "prism_minor",
    limits = c(1990, 2020),
    breaks = seq(1990, 2020, by = 5),
    minor_breaks = seq(1990, 2020, by = 1)
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
  geom_text(aes(x = 1998, y = 120), label = "No highschool degree", color = "#000000") +
  geom_text(aes(x = 1998, y = 85), label = "College graduate", color = "#000000") +
  geom_text(aes(x = 1998, y = 60), label = "High school graduate", color = "#000000") +
  geom_text(aes(x = 1998, y = 40), label = "Some college", color = "#000000") +
  labs(
    title = "Trends in Birth Rates by Population Subgroup",
    subtitle = "B: Mother’s level of education (ages 20-44)",
    x = "",
    y = "Births per 1,000 women in\n relevant population subgroup",
    caption = "Source: Birth rates by age group, race and ethnicity, and marital 
    status are gathered from CDC Vital Statistics Births Reports."
  )

# Save plot
ggsave(
  "replication/plots/figure2d.png",
  height = 100,
  width = 133.33,
  units = "mm",
  dpi = 900
)
