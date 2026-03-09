# Movie Recommendation Analytics (BigQuery + Metabase)

This project implements an end-to-end analytics pipeline to analyze a movie recommendation dataset using Google Cloud and SQL.

## Stack

- Google Cloud Storage
- BigQuery
- SQL (BigQuery SQL)
- Metabase
- Docker

## Architecture

CSV files are stored in Google Cloud Storage and accessed through external tables in BigQuery.  
The pipeline separates the **raw layer** from the **analytics layer**.

## Data Layers

### RAW

External tables created directly on top of CSV files.

All fields are ingested as **STRING** to ensure ingestion stability.

Tables:

- raw_movies
- raw_belief_data
- raw_movie_elicitation
- raw_ratings_additional
- raw_user_rating_history
- raw_user_recommendation_history

### Analytics

Curated tables used for analysis.

Tables:

- dim_movies
- fact_ratings
- fact_recommendations

## Data Cleaning

Key transformations include:

- Casting raw fields using SAFE_CAST
- Removing invalid ratings (NA)
- Extracting release year from movie title
- Cleaning escaped quotes in movie titles

## Example Analysis

Top rated movies with at least 100 ratings:

| Movie | Avg Rating |
|------|-----------|
| Shawshank Redemption | 4.2 |
| Parasite | 4.14 |
| Fight Club | 4.13 |
| Pulp Fiction | 4.13 |

## Next Steps

- Build dashboards in Metabase
- Analyze genre popularity
- Compare predicted ratings vs real ratings
<<<<<<< HEAD
- User behavior analysis
=======
- User behavior analysis
>>>>>>> 03b85a54afdc086150c428355bca2d6d437202a9

Raw dataset files were used locally and stored in Google Cloud Storage for ingestion into BigQuery.

Large CSV files are not included in this repository due to GitHub file size limits.

Files used in the project:
- belief_data.csv
- movie_elicitation_set.csv
- movies.csv
- ratings_for_additional_users.csv
- user_rating_history.csv
- user_recommendation_history.csv