# Get modified concepts in a specific vocabulary from the Finto Skosmos API

Get modified concepts in a specific vocabulary from the Finto Skosmos
API

## Usage

``` r
get_modified_concepts(vocid, lang = NULL, offset = NULL, limit = NULL)
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

A tibble containing the modified concepts with URI, label, and
modification date.

## Examples

``` r
result <- get_modified_concepts(vocid = "yso", lang = "fi", limit = 10)
#> Requesting URL: https://api.finto.fi/rest/v1/yso/modified?lang=fi&limit=10
print(result)
#> # A tibble: 10 × 3
#>    uri                                prefLabel                date             
#>    <chr>                              <chr>                    <chr>            
#>  1 http://www.yso.fi/onto/yso/p20945  aakkoset                 2025-11-06T11:07…
#>  2 http://www.yso.fi/onto/yso/p040817 alaleukaluu              2025-11-10T15:48…
#>  3 http://www.yso.fi/onto/yso/p40311  alkuperäiskansojen tieto 2025-11-05T13:18…
#>  4 http://www.yso.fi/onto/yso/p7397   aluetuet                 2025-11-11T13:32…
#>  5 http://www.yso.fi/onto/yso/p41045  aluset (esineet)         2025-11-11T15:19…
#>  6 http://www.yso.fi/onto/yso/p41044  alustat (ajoneuvot)      2025-11-11T15:45…
#>  7 http://www.yso.fi/onto/yso/p8767   anglikaaniset kirkot     2025-11-11T17:01…
#>  8 http://www.yso.fi/onto/yso/p40959  anhedonia                2025-11-10T10:18…
#>  9 http://www.yso.fi/onto/yso/p10267  antroposofit             2025-11-12T11:45…
#> 10 http://www.yso.fi/onto/yso/p40949  aplastinen anemia        2025-11-10T10:20…
```
