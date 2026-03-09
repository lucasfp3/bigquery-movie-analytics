# MovieLens Analytics Pipeline (BigQuery)

This project implements an end-to-end data analytics pipeline using the **MovieLens Beliefs Dataset**.  
Raw CSV files are ingested into **Google Cloud Storage**, processed in **BigQuery**, and transformed into analytical tables used for exploratory analysis and KPI generation.

The goal of the project is to demonstrate how to structure a **modern analytics workflow**, including:

- raw data ingestion
- data transformation
- analytical modeling
- data validation
- exploratory SQL analysis

---

# Dataset

This project uses the **MovieLens Beliefs Dataset**, provided by the **GroupLens Research Group (University of Minnesota)**.

The dataset includes:

- historical movie ratings
- recommendation system predictions
- belief elicitation data (expected ratings for unseen movies)

Users are anonymized and represented only by a unique `userId`.

Source  
http://grouplens.org/datasets/

Citation  

Aridor, G., Goncalves, D., Kong, R., Culver, D., Konstan, J. (2024).  
*The MovieLens Beliefs Dataset: Collecting Pre-Choice Data for Online Recommender Systems.*

---

# Architecture

The data pipeline follows a **raw → analytics** transformation approach.

CSV Dataset
↓
Google Cloud Storage
↓
BigQuery Raw Tables
↓
BigQuery Analytics Tables
↓
Exploratory SQL Analysis



Raw CSV files are first ingested as external tables and then transformed into typed analytical tables optimized for querying.

---

## Project Structure

```
bigquery-movie-analytics
│
├── SQL
│   ├── Raw
│   │   ├── create_raw_belief_data.sql
│   │   ├── create_raw_movie_elicitation.sql
│   │   ├── create_raw_movies.sql
│   │   ├── create_raw_ratings_additional.sql
│   │   ├── create_raw_user_rating_history.sql
│   │   └── create_raw_user_recommendation_history.sql
│   │
│   └── Analytics
│       ├── create_dim_movies.sql
│       ├── create_fact_ratings.sql
│       └── create_fact_recommendations.sql
│
├── Analyses
│   ├── exploratory_validation.sql
│   ├── exploratory_analysis.sql
│   └── kpis_queries.sql
│
├── Docs
│   └── insights.md
│
├── data_release
│   └── README.txt
│
├── .gitignore
└── README.md
```
Large CSV files are excluded from the repository due to GitHub size limitations.

---

# Data Model

The analytics layer follows a **star schema**.

## Dimension Table

**dim_movies**

| column | description |
|------|-------------|
| movie_id | unique movie identifier |
| titulo | movie title |
| generos | genre list |
| ano_lancamento | release year |

---

## Fact Tables

### fact_ratings

| column | description |
|------|-------------|
| user_id | user identifier |
| movie_id | movie identifier |
| rating | rating value |
| rating_timestamp | rating timestamp |

### fact_recommendations

| column | description |
|------|-------------|
| user_id | user identifier |
| movie_id | movie identifier |
| predicted_rating | predicted rating |
| recommendation_timestamp | recommendation timestamp |

---

# Data Validation

Validation queries were created to verify dataset consistency, including:

- null value checks
- dataset size validation
- referential integrity between fact tables and dimensions

Example finding:
ratings without corresponding movie in dim_movies: 30,600

This indicates potential inconsistencies between the ratings dataset and the movie catalog.

---

# Exploratory Analysis

The project includes SQL queries for exploratory analysis such as:

- rating distribution
- most rated movies
- highest average rated movies
- recommendation frequency
- predicted rating distribution

Example query:

```sql
SELECT
  d.titulo,
  COUNT(*) AS total_ratings,
  ROUND(AVG(f.rating),2) AS avg_rating
FROM analytics.fact_ratings f
LEFT JOIN analytics.dim_movies d
  ON f.movie_id = d.movie_id
GROUP BY 1
HAVING COUNT(*) >= 100
ORDER BY avg_rating DESC;
```
## Key Metrics

- Movies: **105,071**
- Ratings: **6.19 million**
- Recommendations: **1.28 million**

Ratings are distributed on a **0.5 to 5.0 scale**, with a concentration between **3.5 and 4.5**.

Further insights are available in:

`Docs/insights.md`

## Technologies Used

- Google BigQuery
- Google Cloud Storage
- SQL
- Git / GitHub
- MovieLens Dataset
