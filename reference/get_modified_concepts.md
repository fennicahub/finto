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
#>  1 http://www.yso.fi/onto/yso/p20945  aakkoset                 2025-11-13T09:47…
#>  2 http://www.yso.fi/onto/yso/p40914  aktinium                 2025-11-19T11:13…
#>  3 http://www.yso.fi/onto/yso/p040817 alaleukaluu              2025-11-10T15:48…
#>  4 http://www.yso.fi/onto/yso/p40957  aldosteroni              2025-11-19T11:13…
#>  5 http://www.yso.fi/onto/yso/p40993  alfa-PVP                 2025-11-19T11:15…
#>  6 http://www.yso.fi/onto/yso/p40311  alkuperäiskansojen tieto 2025-11-05T13:18…
#>  7 http://www.yso.fi/onto/yso/p7397   aluetuet                 2025-11-11T13:32…
#>  8 http://www.yso.fi/onto/yso/p41045  aluset (esineet)         2025-11-19T13:15…
#>  9 http://www.yso.fi/onto/yso/p41044  alustat (ajoneuvot)      2025-11-19T13:16…
#> 10 http://www.yso.fi/onto/yso/p41023  anatomiset teatterit     2025-11-19T11:15…
```
