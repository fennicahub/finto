# Get labels for a specific concept from the Finto Skosmos API and return as a tibble

Get labels for a specific concept from the Finto Skosmos API and return
as a tibble

## Usage

``` r
get_concept_labels(uri, lang = NULL)
```

## Arguments

- uri:

  The URI of the concept to retrieve labels for.

- lang:

  The language of labels to retrieve, e.g., "en" or "fi". Optional.

## Value

A tibble containing the URI, preferred label (`prefLabel`), alternative
labels (`altLabel`), and hidden labels (`hiddenLabel`) for the concept.

## Examples

``` r
labeles <- get_concept_labels(uri = "http://www.yso.fi/onto/koko/p91024",
lang = "fi")
#> Requesting URL: https://api.finto.fi/rest/v1/label?uri=http%3A%2F%2Fwww.yso.fi%2Fonto%2Fkoko%2Fp91024&lang=fi
print(labeles)
#> # A tibble: 1 × 4
#>   uri                                prefLabel        altLabel hiddenLabel
#>   <chr>                              <chr>            <chr>    <lgl>      
#> 1 http://www.yso.fi/onto/koko/p91024 Sibelius (junat) Sibelius NA         
```
