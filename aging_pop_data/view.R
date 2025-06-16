library(readr)
library(tidyverse)
library(modelsummary)

dat <- read_csv("test_pop/clean_pop.csv")

head(dat)

unique(dat$year)

dat |> 
  select(pop, year, prefecture) |> 
  filter(grepl(c("東京|北海道|京都"), prefecture))

dat <- dat |> 
  mutate(pop = gsub(",", "", pop),   # Remove commas
         pop = gsub("\\s+", "", pop), # Remove spaces
         pop = as.numeric(pop)) 

clean <- dat |>
  select(prefecture, year, pop) |> 
  mutate(year = case_when(
    year == "2015年" ~ 2015,
    year == "2016年" ~ 2016, 
    year == "2017年" ~ 2017, 
    year == "2018年" ~ 2018, 
    year == "2019年" ~ 2019, 
    year == "2022年" ~ 2022)) |>
  na.omit() |> 
  as.data.frame()

head(clean)

clean <- clean  |>
  pivot_wider(
    names_from = year,
    values_from = pop
      ) |> 
  select(prefecture, `2015`, `2022`) |> 
  arrange(prefecture) |> 
  mutate(change = ((`2022` - `2015`) / `2015`) * 100) |>
  mutate(change = round(change, 2))

clean

test <- clean |>
  filter(grepl("県$|都$|府$|道$", prefecture))

test |>
  arrange(desc(change)) |>
  print(n = 47)

head(test)

nrow(test)

unique(test$prefecture)
