CREATE OR REPLACE EXTERNAL TABLE `desafio-filmes-bigquery.raw.raw_movies`
(
  movieId STRING,
  title STRING,
  genres STRING
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://dados-filmes-desafio-lucas/bronze/movies.csv'],
  skip_leading_rows = 1,
  field_delimiter = ',',
  quote = '"',
  allow_quoted_newlines = TRUE,
  max_bad_records = 1000
);