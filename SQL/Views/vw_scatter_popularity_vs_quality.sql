CREATE OR REPLACE VIEW `desafio-filmes-bigquery.analytics.vw_scatter_popularity_vs_quality` AS

SELECT
  d.movie_id,
  d.titulo,
  COUNT(*) AS total_ratings,
  ROUND(AVG(f.rating),2) AS avg_rating
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
ON f.movie_id = d.movie_id
GROUP BY 1,2;