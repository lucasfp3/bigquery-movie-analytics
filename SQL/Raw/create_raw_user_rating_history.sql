CREATE OR REPLACE EXTERNAL TABLE `desafio-filmes-bigquery.raw.raw_user_rating_history`
(
  userId STRING,
  movieId STRING,
  rating STRING,
  tstamp STRING
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://dados-filmes-desafio-lucas/bronze/user_rating_history.csv'],
  skip_leading_rows = 1,
  field_delimiter = ',',
  quote = '"',
  allow_quoted_newlines = TRUE,
  max_bad_records = 1000
);