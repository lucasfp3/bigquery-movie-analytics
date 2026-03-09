🎬 MovieLens Analytics Pipeline (BigQuery)

End-to-end data analytics pipeline built using the MovieLens Beliefs Dataset, ingesting raw CSV data into Google Cloud Storage, transforming it with BigQuery SQL, and producing analytical tables for recommendation system exploration.

The project demonstrates how to design a modern analytics pipeline including raw ingestion, transformation, validation, exploratory analysis and KPI generation.

📊 Dataset

This project uses the MovieLens Beliefs Dataset, released by the GroupLens Research Group (University of Minnesota).

The dataset contains:

user ratings

recommendation system predictions

belief elicitation data (expected ratings for unseen movies)

Users are anonymized and represented only by userId.

Source:
http://grouplens.org/datasets/

Citation:

Aridor, G., Goncalves, D., Kong, R., Culver, D., Konstan, J. (2024)
The MovieLens Beliefs Dataset: Collecting Pre-Choice Data for Online Recommender Systems.

🏗 Architecture

The pipeline follows a raw → analytics transformation model.

CSV Dataset
    │
    ▼
Google Cloud Storage
    │
    ▼
BigQuery RAW Layer
    │
    ▼
BigQuery Analytics Layer
    │
    ├── dim_movies
    ├── fact_ratings
    └── fact_recommendations
    │
    ▼
SQL Analysis

Raw CSV files are ingested as external tables, then transformed into typed analytical tables.

📂 Project Structure
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
├── Images
│
├── data_release
│   └── README.txt
│
├── .gitignore
└── README.md

Large CSV files are excluded from the repository due to GitHub size limits.

🧱 Data Model

The analytics layer uses a star schema.

Dimension

dim_movies

column	description
movie_id	unique movie identifier
titulo	movie title
generos	genre list
ano_lancamento	release year
Fact Tables

fact_ratings

Contains historical user ratings.

column	description
user_id	user identifier
movie_id	movie identifier
rating	rating value
rating_timestamp	rating timestamp

fact_recommendations

Contains recommendation system predictions.

column	description
user_id	user identifier
movie_id	movie identifier
predicted_rating	predicted rating
recommendation_timestamp	timestamp of recommendation
🔎 Data Validation

Validation queries ensure data consistency:

null checks

dataset size validation

foreign key validation between facts and dimensions

Example finding:

ratings without corresponding movie in dim_movies: 30,600

This indicates potential inconsistencies between the ratings dataset and the movie catalog.

📈 Exploratory Analysis

The project includes exploratory queries such as:

rating distribution

most rated movies

highest average rated movies

recommendation frequency analysis

predicted rating distribution

Example query:

SELECT
  d.titulo,
  COUNT(*) AS qtd_avaliacoes,
  ROUND(AVG(f.rating), 2) AS media_rating
FROM analytics.fact_ratings f
LEFT JOIN analytics.dim_movies d
ON f.movie_id = d.movie_id
GROUP BY 1
HAVING COUNT(*) >= 100
ORDER BY media_rating DESC;
📊 KPIs

Key metrics generated:

total movies

total ratings

total recommendations

global rating average

predicted rating average

distinct users

distinct movies rated

💡 Insights

Initial findings include:

6.19M valid ratings

1.28M recommendations

105k movies in catalog

strong skew towards ratings between 3.5 and 4.5

Further insights are documented in:

Docs/insights.md
⚙️ Technologies Used

Google BigQuery

Google Cloud Storage

SQL

Git / GitHub

MovieLens dataset

📜 License

The dataset is distributed under the MovieLens research license.
See the original dataset documentation for full license terms.

🚀 Future Improvements

Possible next steps:

dashboard visualization (Metabase / Looker Studio)

recommendation model evaluation

genre-level analysis

user clustering analysis