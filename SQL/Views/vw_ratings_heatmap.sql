CREATE OR REPLACE VIEW `desafio-filmes-bigquery.analytics.vw_ratings_heatmap` AS

SELECT
  rating,
  COUNT(*) AS total_ratings
FROM `desafio-filmes-bigquery.analytics.fact_ratings`
GROUP BY rating
ORDER BY rating;