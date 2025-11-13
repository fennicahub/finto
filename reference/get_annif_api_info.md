# Get basic information about the Annif REST API

This function retrieves basic information such as the title and version
of the Annif API.

## Usage

``` r
get_annif_api_info()
```

## Value

A list containing the title and version of the API.

## Examples

``` r
api_info <- get_annif_api_info()
print(api_info)
#> $title
#> [1] "Annif REST API"
#> 
#> $version
#> [1] "1.4.1"
#> 
```
