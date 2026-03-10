-- =========================================================
-- ADVANCED INSIGHTS
-- Projeto: MovieLens Analytics Pipeline
-- Objetivo: gerar insights analíticos sobre filmes, gêneros,
-- usuários e o sistema de recomendação.
-- =========================================================


-- =========================================================
-- 1. FILMES: POPULARIDADE VS QUALIDADE
-- =========================================================

-- Insight 1
-- Filmes populares e bem avaliados:
-- títulos com alto volume de avaliações e média elevada.
SELECT
  d.titulo,
  COUNT(*) AS total_ratings,
  ROUND(AVG(f.rating), 2) AS avg_rating
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
GROUP BY d.titulo
HAVING COUNT(*) >= 500
ORDER BY avg_rating DESC, total_ratings DESC
LIMIT 20;


-- Insight 2
-- Filmes muito avaliados, mas com média mais baixa:
-- ajuda a identificar títulos populares, porém medianos.
SELECT
  d.titulo,
  COUNT(*) AS total_ratings,
  ROUND(AVG(f.rating), 2) AS avg_rating
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
GROUP BY d.titulo
HAVING COUNT(*) >= 1000
ORDER BY avg_rating ASC, total_ratings DESC
LIMIT 20;


-- Insight 3
-- "Joias escondidas":
-- filmes com menos avaliações, mas média alta.
SELECT
  d.titulo,
  COUNT(*) AS total_ratings,
  ROUND(AVG(f.rating), 2) AS avg_rating
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
GROUP BY d.titulo
HAVING COUNT(*) BETWEEN 50 AND 200
ORDER BY avg_rating DESC, total_ratings DESC
LIMIT 20;


-- =========================================================
-- 2. GÊNEROS: PERFORMANCE E CONSISTÊNCIA
-- =========================================================

-- Insight 4
-- Gêneros com maior média de avaliação.
SELECT
  genre,
  COUNT(*) AS total_ratings,
  ROUND(AVG(f.rating), 2) AS avg_rating
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
CROSS JOIN UNNEST(SPLIT(d.generos, '|')) AS genre
WHERE d.generos IS NOT NULL
GROUP BY genre
HAVING COUNT(*) >= 1000
ORDER BY avg_rating DESC;


-- Insight 5
-- Gêneros mais populares, medidos por volume de avaliações.
SELECT
  genre,
  COUNT(*) AS total_ratings
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
CROSS JOIN UNNEST(SPLIT(d.generos, '|')) AS genre
WHERE d.generos IS NOT NULL
GROUP BY genre
ORDER BY total_ratings DESC;


-- Insight 6
-- Gêneros com maior dispersão nas notas.
-- Desvio padrão alto sugere opiniões mais divididas.
SELECT
  genre,
  COUNT(*) AS total_ratings,
  ROUND(AVG(f.rating), 2) AS avg_rating,
  ROUND(STDDEV(f.rating), 2) AS rating_stddev
FROM `desafio-filmes-bigquery.analytics.fact_ratings` f
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON f.movie_id = d.movie_id
CROSS JOIN UNNEST(SPLIT(d.generos, '|')) AS genre
WHERE d.generos IS NOT NULL
GROUP BY genre
HAVING COUNT(*) >= 1000
ORDER BY rating_stddev DESC;


-- =========================================================
-- 3. USUÁRIOS: COMPORTAMENTO DE AVALIAÇÃO
-- =========================================================

-- Insight 7
-- Usuários mais ativos.
SELECT
  user_id,
  COUNT(*) AS total_ratings,
  ROUND(AVG(rating), 2) AS avg_rating_given
FROM `desafio-filmes-bigquery.analytics.fact_ratings`
GROUP BY user_id
ORDER BY total_ratings DESC
LIMIT 20;


-- Insight 8
-- Usuários mais exigentes:
-- usuários com menor média de notas atribuídas.
SELECT
  user_id,
  COUNT(*) AS total_ratings,
  ROUND(AVG(rating), 2) AS avg_rating_given
FROM `desafio-filmes-bigquery.analytics.fact_ratings`
GROUP BY user_id
HAVING COUNT(*) >= 100
ORDER BY avg_rating_given ASC
LIMIT 20;


-- Insight 9
-- Usuários mais generosos:
-- usuários com maior média de notas atribuídas.
SELECT
  user_id,
  COUNT(*) AS total_ratings,
  ROUND(AVG(rating), 2) AS avg_rating_given
FROM `desafio-filmes-bigquery.analytics.fact_ratings`
GROUP BY user_id
HAVING COUNT(*) >= 100
ORDER BY avg_rating_given DESC
LIMIT 20;


-- =========================================================
-- 4. SISTEMA DE RECOMENDAÇÃO: PREVISÃO VS REALIDADE
-- =========================================================

-- Insight 10
-- Diferença entre nota prevista pelo sistema e nota real dada pelo usuário.
SELECT
  r.user_id,
  r.movie_id,
  d.titulo,
  r.predicted_rating,
  f.rating AS actual_rating,
  ROUND(f.rating - r.predicted_rating, 2) AS rating_diff
FROM `desafio-filmes-bigquery.analytics.fact_recommendations` r
INNER JOIN `desafio-filmes-bigquery.analytics.fact_ratings` f
  ON r.user_id = f.user_id
 AND r.movie_id = f.movie_id
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON r.movie_id = d.movie_id
LIMIT 100;


-- Insight 11
-- Erro médio absoluto do sistema de recomendação.
SELECT
  COUNT(*) AS matched_cases,
  ROUND(AVG(ABS(f.rating - r.predicted_rating)), 3) AS avg_absolute_error
FROM `desafio-filmes-bigquery.analytics.fact_recommendations` r
INNER JOIN `desafio-filmes-bigquery.analytics.fact_ratings` f
  ON r.user_id = f.user_id
 AND r.movie_id = f.movie_id;


-- Insight 12
-- Filmes mais subestimados pelo sistema:
-- quando a nota real média é maior que a nota prevista média.
SELECT
  d.titulo,
  COUNT(*) AS matched_cases,
  ROUND(AVG(f.rating), 2) AS avg_actual_rating,
  ROUND(AVG(r.predicted_rating), 2) AS avg_predicted_rating,
  ROUND(AVG(f.rating - r.predicted_rating), 2) AS avg_gap
FROM `desafio-filmes-bigquery.analytics.fact_recommendations` r
INNER JOIN `desafio-filmes-bigquery.analytics.fact_ratings` f
  ON r.user_id = f.user_id
 AND r.movie_id = f.movie_id
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON r.movie_id = d.movie_id
GROUP BY d.titulo
HAVING COUNT(*) >= 50
ORDER BY avg_gap DESC
LIMIT 20;


-- Insight 13
-- Filmes mais superestimados pelo sistema:
-- quando a nota prevista média é maior que a nota real média.
SELECT
  d.titulo,
  COUNT(*) AS matched_cases,
  ROUND(AVG(f.rating), 2) AS avg_actual_rating,
  ROUND(AVG(r.predicted_rating), 2) AS avg_predicted_rating,
  ROUND(AVG(f.rating - r.predicted_rating), 2) AS avg_gap
FROM `desafio-filmes-bigquery.analytics.fact_recommendations` r
INNER JOIN `desafio-filmes-bigquery.analytics.fact_ratings` f
  ON r.user_id = f.user_id
 AND r.movie_id = f.movie_id
LEFT JOIN `desafio-filmes-bigquery.analytics.dim_movies` d
  ON r.movie_id = d.movie_id
GROUP BY d.titulo
HAVING COUNT(*) >= 50
ORDER BY avg_gap ASC
LIMIT 20;