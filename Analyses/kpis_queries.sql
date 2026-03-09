-- =========================
-- KPIs PARA DASHBOARD
-- =========================

-- Total de filmes
SELECT COUNT(*) AS total_filmes
FROM `desafio-filmes-bigquery.analytics.dim_movies`;

-- Total de ratings validos
SELECT COUNT(*) AS total_ratings
FROM `desafio-filmes-bigquery.analytics.fact_ratings`;

-- Total de recommendations
SELECT COUNT(*) AS total_recommendations
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`;

-- Rating medio global
SELECT ROUND(AVG(rating), 2) AS rating_medio_global
FROM `desafio-filmes-bigquery.analytics.fact_ratings`;

-- Predicted rating medio global
SELECT ROUND(AVG(predicted_rating), 2) AS predicted_rating_medio_global
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`;

-- Usuarios unicos que avaliaram
SELECT COUNT(DISTINCT user_id) AS usuarios_unicos_rating
FROM `desafio-filmes-bigquery.analytics.fact_ratings`;

-- Usuarios unicos com recomendacao
SELECT COUNT(DISTINCT user_id) AS usuarios_unicos_recommendation
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`;

-- Filmes distintos avaliados
SELECT COUNT(DISTINCT movie_id) AS filmes_distintos_avaliados
FROM `desafio-filmes-bigquery.analytics.fact_ratings`;

-- Filmes distintos recomendados
SELECT COUNT(DISTINCT movie_id) AS filmes_distintos_recomendados
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`;