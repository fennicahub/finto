# Fetch hierarchy of professions from Finto API

This function retrieves broader/narrower relationships and constructs a
hierarchical structure.

## Usage

``` r
fetch_profession_hierarchy(concept_uri, vocid = "mts", depth = 3)
```

## Arguments

- concept_uri:

  The URI of the starting profession (root).

- vocid:

  The vocabulary ID (default: "mts").

- depth:

  The depth of hierarchy to fetch (default: 3).

## Value

A data.frame representing the hierarchy.

## Examples

``` r
hierarchy_df <- fetch_profession_hierarchy("http://urn.fi/URN:NBN:fi:au:mts:m3357")
print(hierarchy_df)
#> # A tibble: 1 × 3
#>   child                                 child_label parent
#>   <chr>                                 <chr>       <chr> 
#> 1 http://urn.fi/URN:NBN:fi:au:mts:m3357 NA          NA    
```
