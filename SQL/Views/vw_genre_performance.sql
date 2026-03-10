CREATE OR REPLACE VIEW `desafio-filmes-bigquery.analytics.vw_genre_performance` AS

SELECT
  genre,
  COUNT(*) AS total_ratings,
  ROUND(AVG(f.rating),2) AS avg_rating
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
ON f.movie_id = d.movie_id,
UNNEST(SPLIT(d.generos,'|')) AS genre
GROUP BY genre
ORDER BY avg_rating DESC;