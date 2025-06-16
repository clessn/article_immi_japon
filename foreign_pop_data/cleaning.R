library(tidyverse)
library(readxl)
library(readr)

test <- read_csv("foreign_pop_data/foreign_pop_test.csv")
head(test)

## Converting to numeric value

clean_foreign_pop <- test |>
  mutate(across(
    total_population:ncol(test),
    ~ ifelse(.x == "***", NA, as.numeric(gsub(",", "", .x)))
  ))

write_csv(clean_foreign_pop, "foreign_pop_data/foreign_pop_clean.csv")
