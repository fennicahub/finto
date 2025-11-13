# Get the hierarchical context for a specific concept from the Finto Skosmos API

Get the hierarchical context for a specific concept from the Finto
Skosmos API

## Usage

``` r
get_hierarchy(vocid, uri, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- uri:

  The URI of the concept whose hierarchical context to retrieve.

- lang:

  The language code for the labels, e.g., "fi" or "en". Optional.

## Value

A tibble containing the hierarchical context (broader, narrower,
prefLabel, etc.) for the specified concept.

## Examples

``` r
hierarchy <- get_hierarchy(vocid = "yso", uri = "http://www.yso.fi/onto/yso/p24489", lang = "fi")
print(hierarchy)
#> # A tibble: 323 × 4
#>    uri                               broader               prefLabel hasChildren
#>    <chr>                             <chr>                 <chr>     <lgl>      
#>  1 http://www.yso.fi/onto/yso/p26592 NA                    tietokon… NA         
#>  2 http://www.yso.fi/onto/yso/p21162 http://www.yso.fi/on… tietokon… FALSE      
#>  3 http://www.yso.fi/onto/yso/p1576  http://www.yso.fi/on… tietokon… FALSE      
#>  4 http://www.yso.fi/onto/yso/p4496  http://www.yso.fi/on… tietokon… FALSE      
#>  5 http://www.yso.fi/onto/yso/p23494 http://www.yso.fi/on… tietokon… FALSE      
#>  6 http://www.yso.fi/onto/yso/p8288  http://www.yso.fi/on… tietokon… FALSE      
#>  7 http://www.yso.fi/onto/yso/p14684 http://www.yso.fi/on… tietokon… FALSE      
#>  8 http://www.yso.fi/onto/yso/p6300  http://www.yso.fi/on… tietokon… FALSE      
#>  9 http://www.yso.fi/onto/yso/p10945 http://www.yso.fi/on… tietokon… FALSE      
#> 10 http://www.yso.fi/onto/yso/p12166 http://www.yso.fi/on… tietokon… FALSE      
#> # ℹ 313 more rows
```
