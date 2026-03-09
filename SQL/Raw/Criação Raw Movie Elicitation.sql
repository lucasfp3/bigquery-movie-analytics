CREATE OR REPLACE EXTERNAL TABLE `desafio-filmes-bigquery.raw.raw_movie_elicitation`
(
  movieId STRING,
  month_idx STRING,
  source STRING,
  tstamp STRING
)
OPTIONS (
  format = 'CSV',
  uris = ['gs://dados-filmes-desafio-lucas/bronze/movie_elicitation_set.csv'],
  skip_leading_rows = 1,
  field_delimiter = ',',
  quote = '"',
  allow_quoted_newlines = TRUE,
  max_bad_records = 1000
);