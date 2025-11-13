# Get top concepts of a specific vocabulary from the Finto Skosmos API

Get top concepts of a specific vocabulary from the Finto Skosmos API

## Usage

``` r
get_top_concepts(vocid, lang = NULL, scheme = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- lang:

  The language of labels to retrieve, e.g., "en" or "fi". Optional.

- scheme:

  The concept scheme to retrieve top concepts from. Optional.

## Value

A tibble containing the URI, label, topConceptOf, notation, and
hasChildren for each top concept.

## Examples

``` r
result <- get_top_concepts(vocid = "yso", lang = "fi")
#> Requesting URL: https://api.finto.fi/rest/v1/yso/topConcepts?lang=fi
print(result)
#> # A tibble: 3 × 5
#>   uri                               label      topConceptOf notation hasChildren
#>   <chr>                             <chr>      <chr>        <lgl>    <lgl>      
#> 1 http://www.yso.fi/onto/yso/p8691  ominaisuu… http://www.… NA       TRUE       
#> 2 http://www.yso.fi/onto/yso/p4762  oliot      http://www.… NA       TRUE       
#> 3 http://www.yso.fi/onto/yso/p15238 tapahtuma… http://www.… NA       TRUE       
```
