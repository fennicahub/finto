# Process and Fetch KANTO Information using author_ID

This function extracts Asteri IDs from the 'author_ID' column, fetches
RDF data from the Finto Skosmos API using those IDs, and returns a
cleaned tibble with the retrieved metadata and profession labels.

## Usage

``` r
get_kanto(data)
```

## Arguments

- data:

  A dataframe containing an 'author_ID' column with values like
  "(FIN11)000069536".

## Value

A tibble with `author_ID`, RDF data, and extracted profession labels.

## Examples

``` r
if (FALSE) { # \dontrun{
results <- get_kanto(my_data)
} # }
```
