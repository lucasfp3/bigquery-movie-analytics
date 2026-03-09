CREATE OR REPLACE TABLE `desafio-filmes-bigquery.analytics.dim_movies` AS
SELECT
  SAFE_CAST(movieId AS INT64) AS movie_id,
  REPLACE(REPLACE(title, '""', '"'), '"', '') AS titulo,
  genres AS generos,
  SAFE_CAST(REGEXP_EXTRACT(title, r'\((\d{4})\)') AS INT64) AS ano_lancamento
FROM `desafio-filmes-bigquery.raw.raw_movies`;