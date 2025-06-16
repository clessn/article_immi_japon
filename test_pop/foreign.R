library(readr)
library(tidyverse)
library(readr)
getwd()

dat_original <- read_csv("test_pop/foreign_pop.csv")


dat <- dat_original |>
  select(year, prefecture, total)


head(dat)


dat <- dat |>
  separate(col = year, into = c("year", "month"), sep = "年")

dat |>
  filter(year == 2017)

unique(dat$prefecture)
