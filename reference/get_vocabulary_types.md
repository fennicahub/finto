# Get type information for a Finto vocabulary

This function retrieves information about the types (classes) of objects
in a given Finto/Skosmos vocabulary, using the `/types` endpoint.

## Usage

``` r
get_vocabulary_types(vocid, lang = NULL)
```

## Arguments

- vocid:

  A Skosmos vocabulary identifier, e.g. `"yso"`.

- lang:

  Optional language code for labels, e.g. `"fi"` or `"en"`. If `NULL`
  (default), the API's default language is used.

## Value

A tibble with one row per type, typically containing columns `uri`,
`label`, and (optionally) `superclass`.

## Examples

``` r
types <- get_vocabulary_types("yso", lang = "fi")
print(types)
#> # A tibble: 7 × 3
#>   uri                                               label             superclass
#>   <chr>                                             <chr>             <chr>     
#> 1 http://www.w3.org/2004/02/skos/core#Concept       Käsite            NA        
#> 2 http://www.w3.org/2004/02/skos/core#Collection    Kokoelma          NA        
#> 3 http://purl.org/iso25964/skos-thes#ConceptGroup   Käsiteryhmä       NA        
#> 4 http://purl.org/iso25964/skos-thes#ThesaurusArray Sisarkäsitteiden… NA        
#> 5 http://www.yso.fi/onto/yso-meta/Concept           Yleiskäsite       http://ww…
#> 6 http://www.yso.fi/onto/yso-meta/Hierarchy         Hierarkisoiva kä… http://ww…
#> 7 http://www.yso.fi/onto/yso-meta/Individual        Yksilökäsite      http://ww…
```
