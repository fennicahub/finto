# Get broader transitive concepts for a specific concept from the Finto Skosmos API

Get broader transitive concepts for a specific concept from the Finto
Skosmos API

## Usage

``` r
get_broader_transitive_concepts(vocid, uri, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- uri:

  The URI of the concept whose broader transitive concepts to retrieve.

- lang:

  The language code for the labels, e.g., "fi" or "en". Optional.

## Value

A tibble containing the broader transitive concepts (prefLabel and uri)
for the specified concept.

## Examples

``` r
concepts <- get_broader_transitive_concepts(vocid = "yso",
uri = "http://www.yso.fi/onto/yso/p22922", lang = "fi")
print(concepts)
#> # A tibble: 5 × 2
#>   uri                               prefLabel                              
#>   <chr>                             <chr>                                  
#> 1 http://www.yso.fi/onto/yso/p26592 tietokoneohjelmat                      
#> 2 http://www.yso.fi/onto/yso/p4762  oliot                                  
#> 3 http://www.yso.fi/onto/yso/p8318  abstraktit objektit                    
#> 4 http://www.yso.fi/onto/yso/p22922 Sibelius (tietokoneohjelmat)           
#> 5 http://www.yso.fi/onto/yso/p690   tekniset objektit (abstraktit objektit)
```
