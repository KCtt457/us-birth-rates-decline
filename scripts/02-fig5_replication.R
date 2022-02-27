#### Preamble ####
# Purpose: Figure 5 replication
# Author: Kimlin Chin
# Date: 22 February 2022
# Contact: kimlin.chin@mail.utoronto.ca
# License: MIT

# Cannot be replicated :(


#### Workspace setup ####
library(haven)
library(tidyverse)
library(ggthemes)

# Read in the provided aggregated data. 
fig5_birth_data <- read_dta("inputs/data/nchs_cohort_analysis.dta")
fig5_pop_data <- read_dta("inputs/data/agecomp-seer.dta")
# fig5_data_extra <- read_dta("inputs/data/nchs_births_pop_1990_2019.dta")

fig5_pop_data1 <- fig5_pop_data %>%
  select(1:32) %>%
  select(-c(stname)) %>%
  group_by(year) %>%
  summarise(across(everything(),sum)) # https://stackoverflow.com/questions/1660124/how-to-sum-a-variable-by-group

fig5_pop_data1 <- fig5_pop_data1 %>%
  pivot_longer(-c(year), names_to = "mage", values_to = "pop")

fig5_pop_data1 <- fig5_pop_data1 %>%
  mutate(mage = as.numeric(str_replace(mage, "fem", ""))) %>%
  mutate(cohort = year - mage) %>%
  mutate(cohort2 = case_when(cohort >= 1968 & cohort <=1972 ~ 1,
                             cohort >= 1973 & cohort <=1977 ~ 2,
                             cohort >= 1978 & cohort <=1982 ~ 3,
                             cohort >= 1983 & cohort <=1987 ~ 4,
                             cohort >= 1988 & cohort <=1992 ~ 5,
                             cohort >= 1993 & cohort <=1997 ~ 6))

fig5_pop_data1 <- na.omit(fig5_pop_data1)
fig5_pop_data1 <- fig5_pop_data1 %>%
  group_by(cohort2, mage) %>%
  summarise(pop = sum(pop))


# fig5_pop_data1 <- fig5_pop_data %>%
#   select(year, fem1519, fem2034, fem3544) %>%
#   group_by(year) %>%
#   summarise(fem1519 = sum(fem1519), fem2034 = sum(fem2034), fem3544 = sum(fem3544))

# fig5_data <- fig5_data %>%
#   mutate(cbrate = cum_birth/pop, cohort2 = as_factor(cohort2))
# 
# fig5_data %>%
#   ggplot(aes(x = mage,
#              y = cbrate/5,
#              color = cohort2)) +
#   geom_smooth()

# Process data
fig5_data <- right_join(fig5_birth_data, fig5_pop_data1, by=c("mage", "cohort2")) %>%
  mutate(brate=numbirth/pop*1000,
         age_20_24_year = case_when(cohort2 == 1 ~ 1992,
                                    cohort2 == 2 ~ 1997,
                                    cohort2 == 3 ~ 2002,
                                    cohort2 == 4 ~ 2007,
                                    cohort2 == 5 ~ 2012,
                                    cohort2 == 6 ~ 2017),
         cohort2 = as_factor(cohort2))

# fig5_data <- fig5_data %>%
#   group_by(cohort2) %>%
#   summarise(cum_brate = sum(brate)/1000)

fig5_data <- fig5_data %>%
  group_by(cohort2) %>%
  mutate(cum_brate = cumsum(brate)/1000, 
         cohort_years = case_when(cohort2 == 1 ~ "1968-1972",
                                  cohort2 == 2 ~ "1973-1977",
                                  cohort2 == 3 ~ "1978-1982",
                                  cohort2 == 4 ~ "1983-1987",
                                  cohort2 == 5 ~ "1988-1992",
                                  cohort2 == 6 ~ "1993-1997"))

# Make plot
fig5_data %>%
  ggplot(aes(x = mage,
             y = cum_brate,
             color = cohort_years)) +
  geom_line() +
  scale_y_continuous(limits=c(0, 2.5), breaks=seq(0, 2.5, by = .5)) +
  scale_x_continuous(limits=c(15, 44), breaks=seq(15, 44, by = 1)) +
  scale_color_tableau(palette = "Color Blind") +
  theme_classic() +
  theme(panel.grid.major.y = element_line(),
        legend.background = element_blank(),
        legend.box.background = element_rect(), 
        legend.position = c(0.85,0.3)) +
  labs(
    title = "Children Ever Born by Mother’s Age and Birth Cohort",
    x = "Mother's age",
    y = "Children ever born",
    color = "Birth cohorts"
  )

# Save plot
ggsave(
  "outputs/plots/figure5.png",
  height = 100,
  width = 133.33,
  units = "mm",
  dpi = 900
)
