-- =========================================================
-- exploratory_validation.sql
-- Projeto: Desafio Filmes - Camada Analytics
-- Objetivo: Validar qualidade, integridade e consistência
--           das tabelas dimensionais e fatos
-- =========================================================

-- #########################################################
-- 1. DATASET OVERVIEW
-- #########################################################

-- Total de filmes na dimensão
SELECT COUNT(*) AS total_filmes
FROM `desafio-filmes-bigquery.analytics.dim_movies`;

-- Total de ratings na fato
SELECT COUNT(*) AS total_ratings
FROM `desafio-filmes-bigquery.analytics.fact_ratings`;

-- Total de recommendations na fato
SELECT COUNT(*) AS total_recommendations
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`;

-- Quantidade distinta de filmes na dimensão
SELECT
  COUNT(*) AS total_linhas_dim_movies,
  COUNT(DISTINCT movie_id) AS total_movie_id_distintos
FROM `desafio-filmes-bigquery.analytics.dim_movies`;

-- Visão geral da fact_ratings
SELECT
  COUNT(*) AS total_linhas,
  COUNT(DISTINCT user_id) AS total_usuarios_distintos,
  COUNT(DISTINCT movie_id) AS total_filmes_distintos
FROM `desafio-filmes-bigquery.analytics.fact_ratings`;

-- Visão geral da fact_recommendations
SELECT
  COUNT(*) AS total_linhas,
  COUNT(DISTINCT user_id) AS total_usuarios_distintos,
  COUNT(DISTINCT movie_id) AS total_filmes_distintos
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`;


-- #########################################################
-- 2. NULL CHECKS
-- #########################################################

-- Nulos na dimensão de filmes
SELECT
  COUNTIF(movie_id IS NULL) AS movie_id_nulo,
  COUNTIF(titulo IS NULL) AS titulo_nulo,
  COUNTIF(generos IS NULL) AS generos_nulo,
  COUNTIF(ano_lancamento IS NULL) AS ano_lancamento_nulo
FROM `desafio-filmes-bigquery.analytics.dim_movies`;

-- Nulos na fato de ratings
SELECT
  COUNTIF(user_id IS NULL) AS user_id_nulo,
  COUNTIF(movie_id IS NULL) AS movie_id_nulo,
  COUNTIF(rating IS NULL) AS rating_nulo,
  COUNTIF(rating_timestamp IS NULL) AS rating_timestamp_nulo
FROM `desafio-filmes-bigquery.analytics.fact_ratings`;

-- Nulos na fato de recommendations
SELECT
  COUNTIF(user_id IS NULL) AS user_id_nulo,
  COUNTIF(movie_id IS NULL) AS movie_id_nulo,
  COUNTIF(predicted_rating IS NULL) AS predicted_rating_nulo,
  COUNTIF(recommendation_timestamp IS NULL) AS recommendation_timestamp_nulo
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`;


-- #########################################################
-- 3. REFERENTIAL INTEGRITY
-- #########################################################

-- Ratings sem correspondência na dimensão de filmes
SELECT COUNT(*) AS ratings_sem_dim_movie
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
WHERE d.movie_id IS NULL;

-- Recommendations sem correspondência na dimensão de filmes
SELECT COUNT(*) AS recommendations_sem_dim_movie
FROM `desafio-filmes-bigquery.analytics.fact_recommendations` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
WHERE d.movie_id IS NULL;


-- #########################################################
-- 4. DOMAIN VALIDATION
-- #########################################################

-- Valores distintos de rating
SELECT DISTINCT rating
FROM `desafio-filmes-bigquery.analytics.fact_ratings`
ORDER BY rating;

-- Distribuição dos ratings
SELECT
  rating,
  COUNT(*) AS qtd
FROM `desafio-filmes-bigquery.analytics.fact_ratings`
GROUP BY rating
ORDER BY rating;

-- Validação consolidada de ratings inválidos
SELECT
  COUNT(*) AS total_ratings,
  COUNTIF(rating = -1) AS ratings_invalidos,
  COUNTIF(rating >= 0) AS ratings_validos,
  ROUND(COUNTIF(rating = -1) / COUNT(*) * 100, 2) AS pct_invalidos
FROM `desafio-filmes-bigquery.analytics.fact_ratings`;

-- Possíveis ratings fora do domínio esperado
SELECT
  rating,
  COUNT(*) AS qtd
FROM `desafio-filmes-bigquery.analytics.fact_ratings`
WHERE rating NOT IN (-1.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0)
GROUP BY rating
ORDER BY rating;

-- Valores distintos de predicted_rating
SELECT DISTINCT predicted_rating
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`
ORDER BY predicted_rating;


-- #########################################################
-- 5. DUPLICATE CHECKS
-- #########################################################

-- Verificar duplicidade de chave na dimensão de filmes
SELECT
  movie_id,
  COUNT(*) AS qtd
FROM `desafio-filmes-bigquery.analytics.dim_movies`
GROUP BY movie_id
HAVING COUNT(*) > 1
ORDER BY qtd DESC, movie_id;

-- Verificar duplicidade de registros na fato de ratings
SELECT
  user_id,
  movie_id,
  rating_timestamp,
  COUNT(*) AS qtd
FROM `desafio-filmes-bigquery.analytics.fact_ratings`
GROUP BY user_id, movie_id, rating_timestamp
HAVING COUNT(*) > 1
ORDER BY qtd DESC, user_id, movie_id;

-- Verificar duplicidade de registros na fato de recommendations
SELECT
  user_id,
  movie_id,
  recommendation_timestamp,
  COUNT(*) AS qtd
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`
GROUP BY user_id, movie_id, recommendation_timestamp
HAVING COUNT(*) > 1
ORDER BY qtd DESC, user_id, movie_id;


-- #########################################################
-- 6. TEMPORAL VALIDATION
-- #########################################################

-- Intervalo temporal da fato de ratings
SELECT
  MIN(rating_timestamp) AS primeira_data_rating,
  MAX(rating_timestamp) AS ultima_data_rating
FROM `desafio-filmes-bigquery.analytics.fact_ratings`;

-- Intervalo temporal da fato de recommendations
SELECT
  MIN(recommendation_timestamp) AS primeira_data_recommendation,
  MAX(recommendation_timestamp) AS ultima_data_recommendation
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`;

-- Distribuição mensal dos ratings
SELECT
  FORMAT_TIMESTAMP('%Y-%m', rating_timestamp) AS ano_mes,
  COUNT(*) AS qtd_ratings
FROM `desafio-filmes-bigquery.analytics.fact_ratings`
GROUP BY ano_mes
ORDER BY ano_mes;

-- Distribuição mensal das recommendations
SELECT
  FORMAT_TIMESTAMP('%Y-%m', recommendation_timestamp) AS ano_mes,
  COUNT(*) AS qtd_recommendations
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`
GROUP BY ano_mes
ORDER BY ano_mes;