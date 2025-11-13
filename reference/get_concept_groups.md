# Get concept groups for a given vocabulary from the Finto Skosmos API

Get concept groups for a given vocabulary from the Finto Skosmos API

## Usage

``` r
get_concept_groups(vocid, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- lang:

  The language of labels, e.g., "en" or "fi". Optional.

## Value

A tibble containing concept groups, with fields for URI, prefLabel, and
hasMembers.

## Examples

``` r
result <- get_concept_groups(vocid = "yso", lang = "fi")
#> Requesting URL: https://api.finto.fi/rest/v1/yso/groups?lang=fi
print(result)
#> # A tibble: 61 × 4
#>    uri                               prefLabel            hasMembers childGroups
#>    <chr>                             <chr>                <lgl>      <lgl>      
#>  1 http://www.yso.fi/onto/yso/p26556 00 Yleistermit       TRUE       NA         
#>  2 http://www.yso.fi/onto/yso/p26545 02 Filosofia         TRUE       NA         
#>  3 http://www.yso.fi/onto/yso/p26574 04 Matematiikka. Ti… TRUE       NA         
#>  4 http://www.yso.fi/onto/yso/p26588 06 Tähtitiede. Astr… TRUE       NA         
#>  5 http://www.yso.fi/onto/yso/p26565 07 Fysiikka          TRUE       NA         
#>  6 http://www.yso.fi/onto/yso/p26531 09 Kemia             TRUE       NA         
#>  7 http://www.yso.fi/onto/yso/p26535 11 Maantiede. Karto… TRUE       NA         
#>  8 http://www.yso.fi/onto/yso/p26580 13 Hydrologia        TRUE       NA         
#>  9 http://www.yso.fi/onto/yso/p26587 14 Klimatologia. Me… TRUE       NA         
#> 10 http://www.yso.fi/onto/yso/p26579 15 Biologia. Mikrob… TRUE       NA         
#> # ℹ 51 more rows
```
