# Get new concepts in a specific vocabulary from the Finto Skosmos API

Get new concepts in a specific vocabulary from the Finto Skosmos API

## Usage

``` r
get_new_concepts(vocid, lang = NULL, offset = NULL, limit = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- lang:

  The language of labels, e.g., "en" or "fi". Optional.

- offset:

  Offset for the starting index of the results. Optional.

- limit:

  Maximum number of concepts to return. Optional.

## Value

A tibble containing the new concepts with URI, label, and creation date.

## Examples

``` r
result <- get_new_concepts(vocid = "yso", lang = "fi", limit = 10)
#> Requesting URL: https://api.finto.fi/rest/v1/yso/new?lang=fi&limit=10
print(result)
#> # A tibble: 10 × 3
#>    uri                               prefLabel                         date     
#>    <chr>                             <chr>                             <chr>    
#>  1 http://www.yso.fi/onto/yso/p41045 aluset (esineet)                  2025-11-…
#>  2 http://www.yso.fi/onto/yso/p41044 alustat (ajoneuvot)               2025-11-…
#>  3 http://www.yso.fi/onto/yso/p11429 atk-ala                           2025-11-…
#>  4 http://www.yso.fi/onto/yso/p41043 energia-aineenvaihdunta           2025-11-…
#>  5 http://www.yso.fi/onto/yso/p5693  erehdys                           2025-11-…
#>  6 http://www.yso.fi/onto/yso/p41047 erillisopetus (sukupuolen mukaan) 2025-11-…
#>  7 http://www.yso.fi/onto/yso/p26604 hoitoaineet                       2025-11-…
#>  8 http://www.yso.fi/onto/yso/p17538 huoltomiehet                      2025-11-…
#>  9 http://www.yso.fi/onto/yso/p20009 INCH                              2025-11-…
#> 10 http://www.yso.fi/onto/yso/p41049 kulttuuriministerit               2025-11-…
```
