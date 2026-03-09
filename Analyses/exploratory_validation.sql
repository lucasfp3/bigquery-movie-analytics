-- =========================
-- VALIDACAO DAS TABELAS
-- =========================

-- Total de filmes
SELECT COUNT(*) AS total_filmes
FROM `desafio-filmes-bigquery.analytics.dim_movies`;

-- Nulos na dim_movies
SELECT
  COUNTIF(movie_id IS NULL) AS movie_id_nulo,
  COUNTIF(titulo IS NULL) AS titulo_nulo,
  COUNTIF(generos IS NULL) AS generos_nulo,
  COUNTIF(ano_lancamento IS NULL) AS ano_nulo
FROM `desafio-filmes-bigquery.analytics.dim_movies`;

-- Total de ratings
SELECT COUNT(*) AS total_ratings
FROM `desafio-filmes-bigquery.analytics.fact_ratings`;

-- Nulos na fact_ratings
SELECT
  COUNTIF(user_id IS NULL) AS user_id_nulo,
  COUNTIF(movie_id IS NULL) AS movie_id_nulo,
  COUNTIF(rating IS NULL) AS rating_nulo,
  COUNTIF(rating_timestamp IS NULL) AS timestamp_nulo
FROM `desafio-filmes-bigquery.analytics.fact_ratings`;

-- Total de recommendations
SELECT COUNT(*) AS total_recommendations
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`;

-- Nulos na fact_recommendations
SELECT
  COUNTIF(user_id IS NULL) AS user_id_nulo,
  COUNTIF(movie_id IS NULL) AS movie_id_nulo,
  COUNTIF(predicted_rating IS NULL) AS predicted_rating_nulo,
  COUNTIF(recommendation_timestamp IS NULL) AS recommendation_timestamp_nulo
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`;

-- Ratings sem match na dimensao de filmes
SELECT COUNT(*) AS ratings_sem_dim_movie
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
WHERE d.movie_id IS NULL;

-- Recommendations sem match na dimensao de filmes
SELECT COUNT(*) AS recommendations_sem_dim_movie
FROM `desafio-filmes-bigquery.analytics.fact_recommendations` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
WHERE d.movie_id IS NULL;