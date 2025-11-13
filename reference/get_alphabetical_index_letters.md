# Get the initial letters of the alphabetical index for labels in a specific vocabulary from the Finto Skosmos API

Get the initial letters of the alphabetical index for labels in a
specific vocabulary from the Finto Skosmos API

## Usage

``` r
get_alphabetical_index_letters(vocid, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- lang:

  The language of labels, e.g., "en" or "fi". Optional.

## Value

A tibble containing the initial letters of the alphabetical index.

## Examples

``` r
result <- get_alphabetical_index_letters(vocid = "yso", lang = "fi")
#> Requesting URL: https://api.finto.fi/rest/v1/yso/index/?lang=fi
print(result)
#> # A tibble: 31 × 1
#>    indexLetter
#>    <chr>      
#>  1 A          
#>  2 B          
#>  3 C          
#>  4 D          
#>  5 E          
#>  6 F          
#>  7 G          
#>  8 H          
#>  9 I          
#> 10 J          
#> # ℹ 21 more rows
```
