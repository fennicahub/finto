# Search for concepts in the Finto Skosmos API by query term with additional parameters

Search for concepts in the Finto Skosmos API by query term with
additional parameters

## Usage

``` r
search_concepts(
  query,
  lang = NULL,
  labellang = NULL,
  vocab = NULL,
  type = NULL,
  parent = NULL,
  group = NULL,
  maxhits = NULL,
  offset = NULL,
  fields = NULL,
  unique = NULL
)
```

## Arguments

- query:

  The term to search for, e.g., "sibelius".

- lang:

  Language of labels to match, e.g., "en" or "fi". Optional.

- labellang:

  Language of labels to return, e.g., "en" or "fi". Optional.

- vocab:

  Vocabulary or vocabularies to limit search to, e.g., "yso". Optional.

- type:

  Limit search to concepts of the given type(s), e.g., "skos:Concept".
  Optional.

- parent:

  Limit search to concepts which have the given concept as a parent.
  Optional.

- group:

  Limit search to concepts in a specific group. Optional.

- maxhits:

  Maximum number of results to return (default is 191 as per the
  screenshot). Optional.

- offset:

  Offset to start in the result set, useful for paging. Optional.

- fields:

  Extra fields to include in the results (space-separated list).
  Optional.

- unique:

  Boolean flag to return each concept only once. Optional.

## Value

A data frame containing search results with columns: `uri`, `type`,
`prefLabel`, `altLabel`, `hiddenLabel`, `lang`, and `vocab`.

## Examples

``` r
concepts <- search_concepts(query = "sibelius", lang = "fi", maxhits = 191)
#> Requesting URL: https://api.finto.fi/rest/v1/search?query=sibelius&lang=fi&maxhits=191
print(concepts)
#> # A tibble: 2 × 7
#>   uri                           type  prefLabel altLabel hiddenLabel lang  vocab
#>   <chr>                         <chr> <chr>     <chr>    <lgl>       <chr> <chr>
#> 1 http://www.yso.fi/onto/koko/… skos… Sibelius… Sibelius NA          fi    koko 
#> 2 http://www.yso.fi/onto/mero/… skos… Sibelius… Sibelius NA          fi    liiko
```
