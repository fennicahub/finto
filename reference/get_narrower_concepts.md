# Get narrower concepts for a specific concept from the Finto Skosmos API

Get narrower concepts for a specific concept from the Finto Skosmos API

## Usage

``` r
get_narrower_concepts(vocid, uri, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- uri:

  The URI of the concept whose narrower concepts to retrieve.

- lang:

  The language code for the labels, e.g., "fi" or "en". Optional.

## Value

A tibble containing the narrower concepts (prefLabel and uri) for the
specified concept.

## Examples

``` r
narrower_concepts <- get_narrower_concepts(vocid = "yso",
uri = "http://www.yso.fi/onto/yso/p690", lang = "fi")
print(narrower_concepts)
#> # A tibble: 21 × 2
#>    uri                               prefLabel                     
#>    <chr>                             <chr>                         
#>  1 http://www.yso.fi/onto/yso/p27641 rajapinnat (tietojenkäsittely)
#>  2 http://www.yso.fi/onto/yso/p26592 tietokoneohjelmat             
#>  3 http://www.yso.fi/onto/yso/p14670 hypermedia                    
#>  4 http://www.yso.fi/onto/yso/p22929 ontologiat (tiedonhallinta)   
#>  5 http://www.yso.fi/onto/yso/p24015 linkit                        
#>  6 http://www.yso.fi/onto/yso/p1312  matkaliput                    
#>  7 http://www.yso.fi/onto/yso/p25964 tietorakenteet                
#>  8 http://www.yso.fi/onto/yso/p21231 salasanat                     
#>  9 http://www.yso.fi/onto/yso/p23971 ohjelmistopaketit             
#> 10 http://www.yso.fi/onto/yso/p22933 korpukset                     
#> # ℹ 11 more rows
```
