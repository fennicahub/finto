# Get a list of projects from the Annif REST API

This function retrieves a list of projects available in the Annif API.

## Usage

``` r
get_annif_projects()
```

## Value

A tibble containing project details, including project ID, name,
language, backend ID, training status, and modification time.

## Examples

``` r
projects <- get_annif_projects()
print(projects)
#> # A tibble: 7 × 8
#>   backend$backend_id is_trained language modification_time      name  project_id
#>   <chr>              <lgl>      <chr>    <chr>                  <chr> <chr>     
#> 1 nn_ensemble        TRUE       fi       2025-09-16T16:34:33.5… YSO … yso-fi    
#> 2 nn_ensemble        TRUE       sv       2025-09-16T16:38:35.5… ALLF… yso-sv    
#> 3 nn_ensemble        TRUE       en       2025-09-16T16:44:39.0… YSO … yso-en    
#> 4 ensemble           TRUE       fi       2025-10-01T04:44:50.5… YKL … ykl-fi    
#> 5 ensemble           TRUE       sv       2025-10-01T04:44:58.6… KAB … ykl-sv    
#> 6 ensemble           TRUE       en       2025-10-01T04:45:04.5… PLC … ykl-en    
#> 7 nn_ensemble        TRUE       fi       2024-12-13T07:57:21+0… KAUN… kauno-fi  
#> # ℹ 2 more variables: vocab <df[,4]>, vocab_language <chr>
```
