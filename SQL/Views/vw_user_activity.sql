CREATE OR REPLACE VIEW `desafio-filmes-bigquery.analytics.vw_user_activity` AS

SELECT
  user_id,
  COUNT(*) AS total_ratings,
  ROUND(AVG(rating),2) AS avg_rating_given
FROM `desafio-filmes-bigquery.analytics.fact_ratings`
GROUP BY user_id
ORDER BY total_ratings DESC;