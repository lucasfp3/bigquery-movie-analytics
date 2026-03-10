CREATE OR REPLACE VIEW `desafio-filmes-bigquery.analytics.vw_movie_kpis` AS

SELECT
  COUNT(DISTINCT d.movie_id) AS total_movies,
  COUNT(f.rating) AS total_ratings,
  COUNT(DISTINCT f.user_id) AS total_users,
  ROUND(AVG(f.rating),2) AS avg_rating
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
ON f.movie_id = d.movie_id;