# Fetch RDF data for a specific concept from the Finto Skosmos API using an asteriID

This function retrieves RDF data for a given concept from the Finto API.
The user only needs to provide the asteriID, which is appended to a
fixed base URI.

## Usage

``` r
fetch_kanto_info(asteriID, format = "application/json")
```

## Arguments

- asteriID:

  The unique identifier to append to the base URI.

- format:

  The MIME type of the serialization format (e.g., "application/rdf+xml"
  or "text/turtle"). Default is "application/json".

## Value

A tibble containing the RDF data for the concept.

## Examples

``` r
concept_data <- fetch_kanto_info(asteriID = "000094320")
#> Requesting URL: https://api.finto.fi/rest/v1/data?uri=http%3A%2F%2Furn.fi%2FURN%3ANBN%3Afi%3Aau%3Afinaf%3A000094320&format=application%2Fjson
print(concept_data)
#> # A tibble: 6 × 22
#>   uri   type  prefLabel altLabel hiddenLabel broader narrower related definition
#>   <chr> <chr> <chr>     <chr>    <chr>       <chr>   <chr>    <chr>   <chr>     
#> 1 http… NA    NA        NA       NA          NA      NA       NA      NA        
#> 2 http… NA    NA        NA       NA          NA      NA       NA      NA        
#> 3 http… NA    NA        NA       NA          NA      NA       NA      NA        
#> 4 http… owl:… NA        NA       NA          NA      NA       NA      NA        
#> 5 http… skos… NA        NA       NA          NA      NA       NA      NA        
#> 6 http… http… A:son-Lj… Ljungbe… NA          NA      NA       NA      NA        
#> # ℹ 13 more variables: scopeNote <chr>, example <chr>, historyNote <chr>,
#> #   editorialNote <chr>, changeNote <chr>, profession <chr>, birthDate <chr>,
#> #   deathDate <chr>, exactMatch <chr>, closeMatch <chr>, inScheme <chr>,
#> #   created <chr>, modified <chr>
```
