# Fetch all metadata from Finto Skosmos API

This function queries the Finto API for a given concept URI and extracts
all relevant metadata fields.

## Usage

``` r
fetch_profession_info(concept_uri)
```

## Arguments

- concept_uri:

  The URI of the concept to fetch.

## Value

A tibble containing the full metadata.

## Examples

``` r
metadata <- fetch_profession_info("http://urn.fi/URN:NBN:fi:au:mts:m3357")
print(metadata)
#> # A tibble: 1 × 14
#>   profession_uri                   profession_prefLabel…¹ profession_prefLabel…²
#>   <chr>                            <chr>                  <chr>                 
#> 1 http://urn.fi/URN:NBN:fi:au:mts… physiologist           fysiologi             
#> # ℹ abbreviated names: ¹​profession_prefLabel_en, ²​profession_prefLabel_fi
#> # ℹ 11 more variables: profession_prefLabel_sv <chr>,
#> #   profession_entryTerms <chr>, profession_belongsToGroup <chr>,
#> #   profession_broader <chr>, profession_narrower <chr>,
#> #   profession_related <chr>, profession_created <chr>,
#> #   profession_modified <chr>, profession_closeMatch <chr>,
#> #   profession_source <chr>, profession_downloadFormats <chr>
```
