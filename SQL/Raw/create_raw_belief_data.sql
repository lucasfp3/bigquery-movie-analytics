CREATE OR REPLACE EXTERNAL TABLE `desafio-filmes-bigquery.raw.raw_belief_data`
(
  userId STRING,
  movieId STRING,
  isSeen STRING,
  watchDate STRING,
  userElicitRating STRING,
  userPredictRating STRING,
  userCertainty STRING,
  tstamp STRING,
  movie_idx STRING,
  source STRING,
  systemPredictRating STRING
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://dados-filmes-desafio-lucas/bronze/belief_data.csv'],
  skip_leading_rows = 1,
  field_delimiter = ',',
  quote = '"',
  allow_quoted_newlines = TRUE,
  max_bad_records = 1000
);