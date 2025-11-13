# Get children concepts for a specific concept from the Finto Skosmos API

Get children concepts for a specific concept from the Finto Skosmos API

## Usage

``` r
get_children_concepts(vocid, uri, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- uri:

  The URI of the concept whose children concepts to retrieve.

- lang:

  The language code for the labels, e.g., "fi" or "en". Optional.

## Value

A tibble containing the children concepts (prefLabel, uri, hasChildren)
for the specified concept.

## Examples

``` r
children <- get_children_concepts(vocid = "yso",
uri = "http://www.yso.fi/onto/yso/p690", lang = "fi")
print(children)
#> # A tibble: 21 × 3
#>    uri                               prefLabel                      hasChildren
#>    <chr>                             <chr>                          <lgl>      
#>  1 http://www.yso.fi/onto/yso/p27641 rajapinnat (tietojenkäsittely) TRUE       
#>  2 http://www.yso.fi/onto/yso/p26592 tietokoneohjelmat              TRUE       
#>  3 http://www.yso.fi/onto/yso/p14670 hypermedia                     FALSE      
#>  4 http://www.yso.fi/onto/yso/p22929 ontologiat (tiedonhallinta)    FALSE      
#>  5 http://www.yso.fi/onto/yso/p24015 linkit                         FALSE      
#>  6 http://www.yso.fi/onto/yso/p1312  matkaliput                     TRUE       
#>  7 http://www.yso.fi/onto/yso/p25964 tietorakenteet                 FALSE      
#>  8 http://www.yso.fi/onto/yso/p21231 salasanat                      FALSE      
#>  9 http://www.yso.fi/onto/yso/p23971 ohjelmistopaketit              TRUE       
#> 10 http://www.yso.fi/onto/yso/p22933 korpukset                      FALSE      
#> # ℹ 11 more rows
```
