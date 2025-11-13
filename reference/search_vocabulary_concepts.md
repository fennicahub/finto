# Search for concepts and collections in a specific vocabulary from the Finto Skosmos API

Search for concepts and collections in a specific vocabulary from the
Finto Skosmos API

## Usage

``` r
search_vocabulary_concepts(
  vocid,
  query,
  lang = NULL,
  type = NULL,
  maxhits = NULL,
  offset = NULL
)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- query:

  The search term, e.g., "cat\*".

- lang:

  The language of labels to match, e.g., "en" or "fi". Optional.

- type:

  Limit search to concepts of a given type, e.g., "skos:Concept".
  Optional.

- maxhits:

  Maximum number of results to return. Optional.

- offset:

  Offset where to start in the result set, useful for paging. Optional.

## Value

A tibble containing the search results with fields such as uri, type,
prefLabel, and altLabel.

## Examples

``` r
search_results <- search_vocabulary_concepts(vocid = "yso", query = "cat", lang = "en")
#> Requesting URL: https://api.finto.fi/rest/v1/yso/search?query=cat&lang=en
print(search_results)
#> # A tibble: 1 × 8
#>   uri                  type  prefLabel altLabel hiddenLabel lang  vocab notation
#>   <chr>                <chr> <chr>     <lgl>    <lgl>       <chr> <chr> <lgl>   
#> 1 http://www.yso.fi/o… skos… cat       NA       NA          en    yso   NA      
```
