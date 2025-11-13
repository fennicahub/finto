# Get general information about a specific vocabulary from the Finto Skosmos API

Get general information about a specific vocabulary from the Finto
Skosmos API

## Usage

``` r
get_vocabulary_info(vocid, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- lang:

  The language of labels to retrieve, e.g., "en" or "fi". Optional.

## Value

A list containing the vocabulary details such as URI, title, languages,
and concept schemes.

## Examples

``` r
result <- get_vocabulary_info(vocid = "yso", lang = "fi")
#> Requesting URL: https://api.finto.fi/rest/v1/yso/?lang=fi
print(result)
#> # A tibble: 3 × 10
#>   vocab_uri vocab_id vocab_title          vocab_marcSource vocab_defaultLanguage
#>   <chr>     <chr>    <chr>                <chr>            <chr>                
#> 1 ""        yso      YSO - Yleinen suoma… yso/fin          fi                   
#> 2 ""        yso      YSO - Yleinen suoma… yso/fin          fi                   
#> 3 ""        yso      YSO - Yleinen suoma… yso/fin          fi                   
#> # ℹ 5 more variables: vocab_languages <chr>, label <chr>, title <chr>,
#> #   uri <chr>, type <chr>
```
