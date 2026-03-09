CREATE OR REPLACE EXTERNAL TABLE `desafio-filmes-bigquery.raw.raw_ratings_additional`
(
  userId STRING,
  movieId STRING,
  rating STRING,
  tstamp STRING
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://dados-filmes-desafio-lucas/bronze/ratings_for_additional_users.csv'],
  skip_leading_rows = 1,
  field_delimiter = ',',
  quote = '"',
  allow_quoted_newlines = TRUE,
  max_bad_records = 1000
);