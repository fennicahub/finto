# Get related concepts for a specific concept from the Finto Skosmos API

Get related concepts for a specific concept from the Finto Skosmos API

## Usage

``` r
get_related_concepts(vocid, uri, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- uri:

  The URI of the concept whose related concepts to retrieve.

- lang:

  The language code for the labels, e.g., "fi" or "en". Optional.

## Value

A tibble containing the related concepts (prefLabel and uri) for the
specified concept.

## Examples

``` r
related <- get_related_concepts(vocid = "yso",uri = "http://www.yso.fi/onto/yso/p24489", lang = "fi")
print(related)
#> # A tibble: 1 × 2
#>   uri                              prefLabel
#>   <chr>                            <chr>    
#> 1 http://www.yso.fi/onto/yso/p2616 tekoäly  
```
