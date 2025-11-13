# Get narrower transitive concepts for a specific concept from the Finto Skosmos API

Get narrower transitive concepts for a specific concept from the Finto
Skosmos API

## Usage

``` r
get_narrower_transitive(vocid, uri, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- uri:

  The URI of the concept whose narrower transitive hierarchy to
  retrieve.

- lang:

  The language code for the labels, e.g., "fi" or "en". Optional.

## Value

A tibble containing the narrower transitive concepts (prefLabel and uri)
for the specified concept.

## Examples

``` r
narrow <- get_narrower_transitive(vocid = "yso",
uri = "http://www.yso.fi/onto/yso/p690", lang = "fi")
print(narrow)
#> # A tibble: 318 × 2
#>    uri                               prefLabel                    
#>    <chr>                             <chr>                        
#>  1 http://www.yso.fi/onto/yso/p20268 K-mies                       
#>  2 http://www.yso.fi/onto/yso/p23971 ohjelmistopaketit            
#>  3 http://www.yso.fi/onto/yso/p1292  virustentorjuntaohjelmat     
#>  4 http://www.yso.fi/onto/yso/p12053 Statistix                    
#>  5 http://www.yso.fi/onto/yso/p1576  Access                       
#>  6 http://www.yso.fi/onto/yso/p16035 Works for Windows            
#>  7 http://www.yso.fi/onto/yso/p22922 Sibelius (tietokoneohjelmat) 
#>  8 http://www.yso.fi/onto/yso/p23011 SAP Business One             
#>  9 http://www.yso.fi/onto/yso/p24489 älykkäät agentit             
#> 10 http://www.yso.fi/onto/yso/p25215 Primavera (tietokoneohjelmat)
#> # ℹ 308 more rows
```
