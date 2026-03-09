CREATE OR REPLACE TABLE `desafio-filmes-bigquery.analytics.fact_recommendations` AS

SELECT
  SAFE_CAST(userId AS INT64) AS user_id,
  SAFE_CAST(movieId AS INT64) AS movie_id,
  SAFE_CAST(predictedRating AS FLOAT64) AS predicted_rating,
  TIMESTAMP_SECONDS(SAFE_CAST(tstamp AS INT64)) AS recommendation_timestamp
FROM `desafio-filmes-bigquery.raw.raw_user_recommendation_history`;