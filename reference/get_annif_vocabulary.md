# Get a list of vocabulary from the Annif REST API

This function retrieves a list of vocabularies available in the Annif
API.

## Usage

``` r
get_annif_vocabulary()
```

## Value

A tibble containing vocabulary details, including languages, size,
vocabulary ID, training status, and modification time.

## Examples

``` r
vocab <- get_annif_vocabulary()
#> $vocabs
#>        languages loaded  size vocab_id
#> 1 en, fi, se, sv   TRUE 39365      yso
#> 2     en, fi, sv   TRUE  2737      ykl
#> 3 en, fi, se, sv   TRUE 36562    kauno
#> 
print(vocab)
#> # A tibble: 3 × 4
#>   languages      loaded  size vocab_id
#>   <chr>          <lgl>  <int> <chr>   
#> 1 en, fi, se, sv TRUE   39365 yso     
#> 2 en, fi, sv     TRUE    2737 ykl     
#> 3 en, fi, se, sv TRUE   36562 kauno   
```
