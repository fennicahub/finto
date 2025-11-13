# Get information about the types (classes) of objects in all vocabularies from the Finto Skosmos API

Get information about the types (classes) of objects in all vocabularies
from the Finto Skosmos API

## Usage

``` r
get_types(lang = NULL)
```

## Arguments

- lang:

  The language of labels to retrieve, e.g., "en" or "fi". Optional.

## Value

A tibble containing the URI, label, and superclass for each type.

## Examples

``` r
result <- get_types(lang = "fi")
#> Requesting URL: https://api.finto.fi/rest/v1/types?lang=fi
print(result)
#> # A tibble: 72 × 3
#>    uri                                               label            superclass
#>    <chr>                                             <chr>            <chr>     
#>  1 http://www.w3.org/2004/02/skos/core#Concept       Käsite           NA        
#>  2 http://www.w3.org/2004/02/skos/core#Collection    Kokoelma         NA        
#>  3 http://purl.org/iso25964/skos-thes#ConceptGroup   Käsiteryhmä      NA        
#>  4 http://purl.org/iso25964/skos-thes#ThesaurusArray Sisarkäsitteide… NA        
#>  5 http://www.yso.fi/onto/yso-meta/Concept           Yleiskäsite      http://ww…
#>  6 http://www.yso.fi/onto/yso-meta/Hierarchy         Hierarkisoiva k… http://ww…
#>  7 http://www.yso.fi/onto/gtk-meta/Concept           GEO-käsite       http://ww…
#>  8 http://www.yso.fi/onto/juho-meta/Concept          JUHO-käsite      http://ww…
#>  9 http://www.yso.fi/onto/jupo-meta/Concept          JUPO-käsite      http://ww…
#> 10 http://www.yso.fi/onto/kauno-meta/Concept         KAUNO-käsite     http://ww…
#> # ℹ 62 more rows
```
