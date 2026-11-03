# Yelp New Orleans Restaurant Analysis

MATH 167R Project 2. Research question and findings: TBD.

## Getting the data

The raw Yelp JSON files are several GB, so they are not committed (`data/raw/` is in `.gitignore`).

1. Download the Yelp Open Dataset from <https://business.yelp.com/data/resources/open-dataset/>.
2. Unzip it and extract `yelp_academic_dataset_business.json` and `yelp_academic_dataset_review.json` from `yelp_dataset.tar` into `data/raw/`.
3. From the project root, run `Rscript R/import.R`. This filters to New Orleans restaurants and their reviews and saves them to `data/new_orleans/` as compressed `.rds` files.

## Files

- `R/import.R`: imports the raw JSON, filters to New Orleans restaurants, saves RDS files
- `data/new_orleans/`: filtered data
- `figures/`: saved plots and maps
