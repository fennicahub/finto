# Suggest subjects for a given text using the Annif REST API

This function sends a request to the Annif API to suggest subjects based
on the provided input text.

## Usage

``` r
annif_subject_indexing(
  project_id,
  text,
  limit = 10,
  threshold = 0,
  language = "en"
)
```

## Arguments

- project_id:

  The project identifier (e.g., "yso-en").

- text:

  The input text for which subjects are to be suggested.

- limit:

  An optional parameter to specify the maximum number of results to
  return. Default is 10.

- threshold:

  An optional parameter to specify the minimum score threshold for
  results. Default is 0.

- language:

  An optional parameter to specify the language of subject labels.
  Default is "en".

## Value

A tibble containing suggested subjects, including their labels, URIs,
and scores.

## Examples

``` r
suggestions <- annif_subject_indexing(project_id = "yso-en",
text = "Jean Sibelius orchestra music and composer")
#> [1] "https://ai.finto.fi/v1/projects/yso-en/suggest"
print(suggestions)
#> # A tibble: 10 × 3
#>    label                uri                                score
#>    <chr>                <chr>                              <dbl>
#>  1 composers            http://www.yso.fi/onto/yso/p2353  0.705 
#>  2 biographical history http://www.yso.fi/onto/yso/p2718  0.523 
#>  3 art music            http://www.yso.fi/onto/yso/p18434 0.329 
#>  4 music                http://www.yso.fi/onto/yso/p1808  0.275 
#>  5 composing            http://www.yso.fi/onto/yso/p13332 0.239 
#>  6 orchestras           http://www.yso.fi/onto/yso/p5070  0.200 
#>  7 history of music     http://www.yso.fi/onto/yso/p14569 0.154 
#>  8 biographies          http://www.yso.fi/onto/yso/p11597 0.146 
#>  9 compositions (music) http://www.yso.fi/onto/yso/p1515  0.104 
#> 10 jeans                http://www.yso.fi/onto/yso/p19836 0.0811
```
