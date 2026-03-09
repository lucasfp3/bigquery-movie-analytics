-- =========================
-- ANALISE EXPLORATORIA
-- =========================

-- Distribuicao das notas
SELECT
  rating,
  COUNT(*) AS total_ratings
FROM `desafio-filmes-bigquery.analytics.fact_ratings`
GROUP BY rating
ORDER BY rating DESC;

-- Filmes mais avaliados
SELECT
  d.titulo,
  COUNT(*) AS qtd_avaliacoes
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 20;

-- Filmes com maior media de rating (minimo 100 avaliacoes)
SELECT
  d.titulo,
  COUNT(*) AS qtd_avaliacoes,
  ROUND(AVG(f.rating), 2) AS media_rating
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
GROUP BY 1
HAVING COUNT(*) >= 100
ORDER BY media_rating DESC, qtd_avaliacoes DESC
LIMIT 20;

-- Filmes mais recomendados
SELECT
  d.titulo,
  COUNT(*) AS qtd_recomendacoes
FROM `desafio-filmes-bigquery.analytics.fact_recommendations` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 20;

-- Filmes com maior media predita (minimo 100 recomendacoes)
SELECT
  d.titulo,
  COUNT(*) AS qtd_recomendacoes,
  ROUND(AVG(f.predicted_rating), 2) AS media_predita
FROM `desafio-filmes-bigquery.analytics.fact_recommendations` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
GROUP BY 1
HAVING COUNT(*) >= 100
ORDER BY media_predita DESC, qtd_recomendacoes DESC
LIMIT 20;

-- Evolucao das avaliacoes por ano
SELECT
  EXTRACT(YEAR FROM rating_timestamp) AS ano,
  COUNT(*) AS total_avaliacoes
FROM `desafio-filmes-bigquery.analytics.fact_ratings`
GROUP BY 1
ORDER BY 1;

-- Evolucao das recomendacoes por ano
SELECT
  EXTRACT(YEAR FROM recommendation_timestamp) AS ano,
  COUNT(*) AS total_recomendacoes
FROM `desafio-filmes-bigquery.analytics.fact_recommendations`
GROUP BY 1
ORDER BY 1;