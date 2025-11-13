# Get labels for a specific concept from the Finto Skosmos API

Get labels for a specific concept from the Finto Skosmos API

## Usage

``` r
get_concept_labels_vocid(vocid, uri, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- uri:

  The URI of the concept whose labels to retrieve.

- lang:

  The language code for the labels, e.g., "fi" or "en". Optional.

## Value

A tibble containing the labels (prefLabel, altLabel, hiddenLabel) for
the specified concept.

## Examples

``` r
lables <- get_concept_labels_vocid(vocid = "yso",
uri = "http://www.yso.fi/onto/yso/p22922", lang = "fi")
print(lables)
#> # A tibble: 1 × 4
#>   uri                               prefLabel               altLabel hiddenLabel
#>   <chr>                             <chr>                   <chr>    <lgl>      
#> 1 http://www.yso.fi/onto/yso/p22922 Sibelius (tietokoneohj… Sibeliu… NA         
```
