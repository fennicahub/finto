# Get concepts starting with a specific letter in the alphabetical index for a given vocabulary

Get concepts starting with a specific letter in the alphabetical index
for a given vocabulary

## Usage

``` r
get_concepts_by_letter(vocid, letter, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- letter:

  The initial letter, or "0-9" for numeric or "!\*" for special
  character labels.

- lang:

  The language of labels, e.g., "en" or "fi". Optional.

## Value

A tibble containing concepts with labels starting with the given letter.

## Examples

``` r
result <- get_concepts_by_letter(vocid = "yso", letter = "A", lang = "fi")
#> Requesting URL: https://api.finto.fi/rest/v1/yso/index/A?lang=fi
print(result)
#> # A tibble: 2,762 × 5
#>    uri                               localname prefLabel          altLabel lang 
#>    <chr>                             <chr>     <chr>              <chr>    <chr>
#>  1 http://www.yso.fi/onto/yso/p23406 p23406    A(H1N1)-virus      NA       fi   
#>  2 http://www.yso.fi/onto/yso/p21184 p21184    A(H5N1)-virus      NA       fi   
#>  3 http://www.yso.fi/onto/yso/p21723 p21723    puhetta tukeva ja… AAC-men… fi   
#>  4 http://www.yso.fi/onto/yso/p20945 p20945    aakkoset           NA       fi   
#>  5 http://www.yso.fi/onto/yso/p38031 p38031    radioaakkoset      aakkosn… fi   
#>  6 http://www.yso.fi/onto/yso/p20945 p20945    aakkoset           aakkosto fi   
#>  7 http://www.yso.fi/onto/yso/p20945 p20945    aakkoset           aakkost… fi   
#>  8 http://www.yso.fi/onto/yso/p17153 p17153    aakkostus          NA       fi   
#>  9 http://www.yso.fi/onto/yso/p26179 p26179    AA-liike           NA       fi   
#> 10 http://www.yso.fi/onto/yso/p26021 p26021    aallonmurtajat     NA       fi   
#> # ℹ 2,752 more rows
```
