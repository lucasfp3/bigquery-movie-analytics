CREATE OR REPLACE TABLE `desafio-filmes-bigquery.analytics.fact_ratings` AS

SELECT
  SAFE_CAST(userId AS INT64) AS user_id,
  SAFE_CAST(movieId AS INT64) AS movie_id,
  SAFE_CAST(rating AS FLOAT64) AS rating,
  SAFE_CAST(tstamp AS TIMESTAMP) AS rating_timestamp
FROM `desafio-filmes-bigquery.raw.raw_user_rating_history`
WHERE SAFE_CAST(rating AS FLOAT64) IS NOT NULL

UNION ALL

SELECT
  SAFE_CAST(userId AS INT64) AS user_id,
  SAFE_CAST(movieId AS INT64) AS movie_id,
  SAFE_CAST(rating AS FLOAT64) AS rating,
  SAFE_CAST(tstamp AS TIMESTAMP) AS rating_timestamp
FROM `desafio-filmes-bigquery.raw.raw_ratings_additional`
WHERE SAFE_CAST(rating AS FLOAT64) IS NOT NULL;