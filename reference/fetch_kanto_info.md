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
#> # A tibble: 1 × 32
#>   uri          type  prefLabel altLabel Person preferredNameOfPerson variantName
#>   <chr>        <chr> <chr>     <chr>    <chr>  <chr>                 <chr>      
#> 1 http://urn.… http… A:son-Lj… Ljungbe… NA     NA                    Ljungberg,…
#> # ℹ 25 more variables: fullerFormOfName <chr>, hiddenLabel <chr>,
#> #   authorizedAccessPoint <chr>, note <chr>, birthDate <chr>, deathDate <chr>,
#> #   birthPlace <chr>, deathPlace <chr>, profession <chr>, language <chr>,
#> #   title <chr>, relatedPersonOfPerson <chr>, country <chr>,
#> #   periodOfActivityOfPerson <chr>, placeOfResidence <chr>,
#> #   relatedPerson <chr>, placeAssociatedWithPerson <chr>,
#> #   fieldOfActivityOfPerson <chr>, isni <chr>, source <chr>, …
```
