# Look up concepts by label in a specific vocabulary from the Finto Skosmos API

Look up concepts by label in a specific vocabulary from the Finto
Skosmos API

## Usage

``` r
lookup_concept_by_label(vocid, label, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- label:

  The label to look up, e.g., "cat".

- lang:

  The search language, e.g., "en" or "fi". Optional.

## Value

A tibble containing the best matching concept(s) with fields like uri,
type, prefLabel, and altLabel.

## Examples

``` r
result <- lookup_concept_by_label(vocid = "yso", label = "cat", lang = "en")
#> Requesting URL: https://api.finto.fi/rest/v1/yso/lookup?label=cat&lang=en
print(result)
#> # A tibble: 1 × 8
#>   uri                  type  prefLabel altLabel hiddenLabel lang  vocab notation
#>   <chr>                <chr> <chr>     <lgl>    <lgl>       <chr> <chr> <lgl>   
#> 1 http://www.yso.fi/o… skos… cat       NA       NA          en    yso   NA      
```
