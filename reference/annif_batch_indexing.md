# Suggest subjects for a batch (≤32 docs) via Annif REST API

Suggest subjects for a batch (≤32 docs) via Annif REST API

## Usage

``` r
annif_batch_indexing(
  project_id,
  texts,
  doc_ids = NULL,
  limit = 10,
  threshold = 0,
  language = "en"
)
```

## Arguments

- project_id:

  Project id, e.g. "yso-en".

- texts:

  Character vector of document texts to analyze (max 32 documents).

- doc_ids:

  Optional character vector of IDs (same length as texts). If NULL, IDs
  are auto-generated as "doc-1", "doc-2", ...

- limit:

  Max suggestions per document (default 10).

- threshold:

  Minimum score (default 0).

- language:

  Label language for suggestions (e.g., "en", "fi", "sv").

## Value

Tibble with columns: document_id, label, uri, notation, score

## Examples

``` r
texts <- c("A quick brown fox jumped over the lazy dog.",
"Climate change and global warming effects on Arctic ecosystems.",
"Machine learning applications in healthcare diagnostics.")
results <- annif_batch_indexing(project_id = "yso-en",texts = texts,
limit = 5)
print(results)
#>    document_id                   label                               uri
#> 1        doc-1                     dog  http://www.yso.fi/onto/yso/p5319
#> 2        doc-1                 jumping http://www.yso.fi/onto/yso/p27825
#> 3        doc-1                 red fox  http://www.yso.fi/onto/yso/p2228
#> 4        doc-1                laziness  http://www.yso.fi/onto/yso/p8122
#> 5        doc-1                 singers  http://www.yso.fi/onto/yso/p2352
#> 6        doc-2         climate changes  http://www.yso.fi/onto/yso/p5729
#> 7        doc-2                 warming  http://www.yso.fi/onto/yso/p2055
#> 8        doc-2           arctic region http://www.yso.fi/onto/yso/p12434
#> 9        doc-2    ecosystems (ecology)  http://www.yso.fi/onto/yso/p4997
#> 10       doc-2        climatic effects http://www.yso.fi/onto/yso/p20949
#> 11       doc-3        machine learning http://www.yso.fi/onto/yso/p21846
#> 12       doc-3             diagnostics   http://www.yso.fi/onto/yso/p416
#> 13       doc-3          health service  http://www.yso.fi/onto/yso/p2658
#> 14       doc-3           deep learning http://www.yso.fi/onto/yso/p39324
#> 15       doc-3 applications (applying) http://www.yso.fi/onto/yso/p28185
#>    notation      score
#> 1        NA 0.23629589
#> 2        NA 0.09779555
#> 3        NA 0.08116682
#> 4        NA 0.07790201
#> 5        NA 0.07759041
#> 6        NA 0.96081901
#> 7        NA 0.40325975
#> 8        NA 0.35408971
#> 9        NA 0.34540403
#> 10       NA 0.26177147
#> 11       NA 0.74381649
#> 12       NA 0.51998848
#> 13       NA 0.30789036
#> 14       NA 0.20481938
#> 15       NA 0.17973194
```
