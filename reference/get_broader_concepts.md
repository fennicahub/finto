# Get broader concepts for a specific concept from the Finto Skosmos API

Get broader concepts for a specific concept from the Finto Skosmos API

## Usage

``` r
get_broader_concepts(vocid, uri, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- uri:

  The URI of the concept whose broader concepts to retrieve.

- lang:

  The language code for the labels, e.g., "fi" or "en". Optional.

## Value

A tibble containing the broader concepts (prefLabel and uri) for the
specified concept.

## Examples

``` r
conepts <- get_broader_concepts(vocid = "yso",uri = "http://www.yso.fi/onto/yso/p22922", lang = "fi")
print(conepts)
#> # A tibble: 1 × 2
#>   uri                               prefLabel        
#>   <chr>                             <chr>            
#> 1 http://www.yso.fi/onto/yso/p26592 tietokoneohjelmat
```
