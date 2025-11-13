# Get mappings for a specific concept from the Finto Skosmos API

Get mappings for a specific concept from the Finto Skosmos API

## Usage

``` r
get_mappings(vocid, uri, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- uri:

  The URI of the concept whose mappings to retrieve.

- lang:

  The language code for the labels, e.g., "fi" or "en". Optional.

## Value

A tibble containing mappings associated with the specified concept.

## Examples

``` r
mappings_data <- get_mappings(vocid = "yso", uri = "http://www.yso.fi/onto/yso/p22922", lang = "fi")
print(mappings_data)
#> # A tibble: 4 × 8
#>   uri           prefLabel typeLabel description fromURI toURI vocabName hrefLink
#>   <chr>         <chr>     <chr>     <chr>       <chr>   <chr> <chr>     <chr>   
#> 1 http://www.y… Sibelius  skos:clo… Läheisesti… http:/… http… www.wiki… http://…
#> 2 http://www.y… Sibelius… skos:exa… Merkitykse… http:/… http… YSA - Yl… ysa/fi/…
#> 3 http://www.y… Sibelius… skos:exa… Merkitykse… http:/… http… Allärs -… allars/…
#> 4 http://www.y… Sibelius… skos:exa… Merkitykse… http:/… http… KOKO-ont… koko/fi…
```
