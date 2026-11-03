# Steps 1-2: import the raw Yelp JSON, filter to New Orleans restaurants, save as RDS.
# Run from the project root: Rscript R/import.R

library(tidyverse)
library(jsonlite)

business_file <- "data/raw/yelp_academic_dataset_business.json"
review_file <- "data/raw/yelp_academic_dataset_review.json"

# Business file is small enough (~120 MB) to read in one go
business <- stream_in(file(business_file), verbose = FALSE) |>
  select(
    business_id, name, address, city, state, postal_code,
    latitude, longitude, stars, review_count, categories
  )

new_orleans_restaurants <- business |>
  filter(
    state == "LA",
    city == "New Orleans",
    !is.na(categories),
    str_detect(categories, regex("Restaurants", ignore_case = TRUE))
  ) |>
  mutate(
    postal_code = na_if(postal_code, ""),
    categories = str_squish(categories),
    business_name = str_squish(name)
  ) |>
  distinct(business_id, .keep_all = TRUE)

new_orleans_restaurants |>
  summarise(
    number_of_restaurants = n(),
    missing_latitude = sum(is.na(latitude)),
    missing_longitude = sum(is.na(longitude)),
    missing_categories = sum(is.na(categories))
  ) |>
  print()

# Review file is ~5.3 GB: read in chunks and keep only New Orleans restaurant reviews,
# so the full file never has to fit in memory
review_chunks <- list()
stream_in(
  file(review_file),
  handler = function(df) {
    review_chunks[[length(review_chunks) + 1]] <<- df |>
      filter(business_id %in% new_orleans_restaurants$business_id) |>
      select(review_id, business_id, user_id, stars, date, text, useful, funny, cool)
  },
  pagesize = 50000,
  verbose = FALSE
)
new_orleans_reviews <- bind_rows(review_chunks)

dim(new_orleans_restaurants)
dim(new_orleans_reviews)
glimpse(new_orleans_reviews)

dir.create("data/new_orleans", recursive = TRUE, showWarnings = FALSE)
saveRDS(new_orleans_restaurants, "data/new_orleans/business_new_orleans.rds", compress = "xz")
saveRDS(new_orleans_reviews, "data/new_orleans/reviews_new_orleans.rds", compress = "xz")
