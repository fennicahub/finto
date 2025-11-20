# Get label statistics by language in a specific vocabulary from the Finto Skosmos API

Get label statistics by language in a specific vocabulary from the Finto
Skosmos API

## Usage

``` r
get_label_statistics(vocid)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

## Value

A tibble containing the label statistics for each language, with columns
for language, literal, property, and label count.

## Examples

``` r
result <- get_label_statistics(vocid = "yso")
#> Requesting URL: https://api.finto.fi/rest/v1/yso/labelStatistics
print(result)
#> # A tibble: 12 × 4
#>    language literal      property         labels
#>    <chr>    <chr>        <chr>             <int>
#>  1 en       englanti     skos:prefLabel    32504
#>  2 en       englanti     skos:altLabel      9078
#>  3 en       englanti     skos:hiddenLabel  15584
#>  4 fi       suomi        skos:prefLabel    32993
#>  5 fi       suomi        skos:altLabel     16389
#>  6 fi       suomi        skos:hiddenLabel  18140
#>  7 se       pohjoissaame skos:prefLabel    21662
#>  8 se       pohjoissaame skos:altLabel      1836
#>  9 se       pohjoissaame skos:hiddenLabel      6
#> 10 sv       ruotsi       skos:prefLabel    32560
#> 11 sv       ruotsi       skos:altLabel     22166
#> 12 sv       ruotsi       skos:hiddenLabel  15162
```
