# Get vocabulary statistics as a single tibble containing concepts, subtypes, and concept groups

Get vocabulary statistics as a single tibble containing concepts,
subtypes, and concept groups

## Usage

``` r
get_vocabulary_statistics(vocid, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- lang:

  The language of labels, e.g., "en" or "fi". Optional.

## Value

A tibble containing counts of concepts, subtypes, and concept groups,
with each entry in one row.

## Examples

``` r
result <- get_vocabulary_statistics(vocid = "yso", lang = "fi")
#> Requesting URL: https://api.finto.fi/rest/v1/yso/vocabularyStatistics?lang=fi
print(result)
#> # A tibble: 5 × 5
#>   category      class                                label count deprecatedCount
#>   <chr>         <chr>                                <chr> <int>           <int>
#> 1 Concepts      NA                                   NA       NA              NA
#> 2 SubTypes      http://www.yso.fi/onto/yso-meta/Ind… Yksi…   821               0
#> 3 SubTypes      http://www.yso.fi/onto/yso-meta/Hie… Hier…    81               0
#> 4 SubTypes      http://www.yso.fi/onto/yso-meta/Con… Ylei… 30407               4
#> 5 ConceptGroups http://www.w3.org/2004/02/skos/core… Koko…   242              32
```
