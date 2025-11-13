# Suggest subjects for a batch (maximum 32 docs) via Annif REST API

Suggest subjects for a batch (maximum 32 docs) via Annif REST API

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
if (FALSE) { # \dontrun{
texts <- c(
  "A quick brown fox jumped over the lazy dog.",
  "Climate change and global warming effects on Arctic ecosystems.",
  "Machine learning applications in healthcare diagnostics."
)
results <- annif_batch_indexing(
  project_id = "yso-en",
  texts = texts,
  limit = 5
)
print(results)
} # }
```
