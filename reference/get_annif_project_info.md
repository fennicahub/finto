# Get information about a specific project from the Annif REST API

This function retrieves detailed information about a specified project
using the Annif API.

## Usage

``` r
get_annif_project_info(project_id)
```

## Arguments

- project_id:

  A string representing the project identifier (e.g., "dummy-fi").

## Value

A tibble containing project details, or an error message if the project
is not found.

## Examples

``` r
project_info <- get_annif_project_info(project_id = "yso-fi")
print(project_info)
#> # A tibble: 4 × 8
#>   backend      is_trained language modification_time      name  project_id vocab
#>   <named list> <lgl>      <chr>    <chr>                  <chr> <chr>      <nam>
#> 1 <chr [1]>    TRUE       fi       2025-09-16T16:34:33.5… YSO … yso-fi     <chr>
#> 2 <chr [1]>    TRUE       fi       2025-09-16T16:34:33.5… YSO … yso-fi     <lgl>
#> 3 <chr [1]>    TRUE       fi       2025-09-16T16:34:33.5… YSO … yso-fi     <int>
#> 4 <chr [1]>    TRUE       fi       2025-09-16T16:34:33.5… YSO … yso-fi     <chr>
#> # ℹ 1 more variable: vocab_language <chr>
```
