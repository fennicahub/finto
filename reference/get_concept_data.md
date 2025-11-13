# Get RDF data for a specific concept from the Finto Skosmos API

Get RDF data for a specific concept from the Finto Skosmos API

## Usage

``` r
get_concept_data(uri, format = "application/json")
```

## Arguments

- uri:

  The URI of the concept to retrieve data for.

- format:

  The MIME type of the serialization format (e.g., "application/rdf+xml"
  or "text/turtle"). Default is "application/json".

## Value

A tibble containing the RDF data for the concept.

## Examples

``` r
concept_data <- get_concept_data(uri = "http://www.yso.fi/onto/afo/")
#> Requesting URL: https://api.finto.fi/rest/v1/data?uri=http%3A%2F%2Fwww.yso.fi%2Fonto%2Fafo%2F&format=application%2Fjson
print(concept_data)
#> # A tibble: 7 × 6
#>   uri                          type  prefLabel description publisher contributor
#>   <chr>                        <chr> <chr>     <chr>       <chr>     <chr>      
#> 1 http://www.yso.fi/onto/afo/  "sko… NA        "AFO sovel… National… Semanttise…
#> 2 http://www.yso.fi/onto/afo/… "htt… ihmistyö   NA         NA        NA         
#> 3 http://www.yso.fi/onto/koko/ ""    NA         NA         NA        NA         
#> 4 http://www.yso.fi/onto/yso/… "htt… prosopag…  NA         NA        NA         
#> 5 http://www.yso.fi/onto/yso/… "htt… yso-käsi…  NA         NA        NA         
#> 6 http://www.yso.fi/onto/yso/… "htt… NA         NA         NA        NA         
#> 7 http://www.yso.fi/onto/yso/… "htt… NA         NA         NA        NA         
```
