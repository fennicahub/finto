

#' Suggest subjects for a batch (maximum 32 docs) via Annif REST API
#'
#' @param project_id Project id, e.g. "yso-en".
#' @param texts Character vector of document texts to analyze (max 32 documents).
#' @param doc_ids Optional character vector of IDs (same length as texts).
#'   If NULL, IDs are auto-generated as "doc-1", "doc-2", ...
#' @param limit Max suggestions per document (default 10).
#' @param threshold Minimum score (default 0).
#' @param language Label language for suggestions (e.g., "en", "fi", "sv").
#' @return Tibble with columns: document_id, label, uri, notation, score
#' @importFrom httr POST accept_json content status_code modify_url user_agent
#' @importFrom tibble tibble as_tibble
#' @importFrom dplyr bind_rows select relocate
#' @examples
#' \dontrun{
#' texts <- c(
#'   "A quick brown fox jumped over the lazy dog.",
#'   "Climate change and global warming effects on Arctic ecosystems.",
#'   "Machine learning applications in healthcare diagnostics."
#' )
#' results <- annif_batch_indexing(
#'   project_id = "yso-en",
#'   texts = texts,
#'   limit = 5
#' )
#' print(results)
#' }
#'
#' @export
annif_batch_indexing <- function(project_id,
                                 texts,
                                 doc_ids = NULL,
                                 limit = 10,
                                 threshold = 0,
                                 language = "en") {

  # Input validation
  if (length(texts) > 32) {
    stop("Maximum 32 documents allowed per batch request.")
  }

  if (is.null(doc_ids)) {
    doc_ids <- paste0("doc-", seq_along(texts))
  } else if (length(doc_ids) != length(texts)) {
    stop("doc_ids must be the same length as texts")
  }

  # Construct request body according to API specification
  documents <- lapply(seq_along(texts), function(i) {
    list(
      text = texts[i],
      document_id = doc_ids[i]
      # metadata is optional, can be added if needed
    )
  })

  request_body <- list(documents = documents)

  # Construct URL with correct parameter names
  base_url <- httr::modify_url(
    "https://ai.finto.fi",
    path = paste0("v1/projects/", project_id, "/suggest-batch"),
    query = list(
      limit = limit,
      threshold = threshold,
      language = language
    )
  )

  # Make POST request with correct headers and body
  response <- httr::POST(
    url = base_url,
    httr::accept_json(),
    httr::content_type_json(),
    body = jsonlite::toJSON(request_body, auto_unbox = TRUE, pretty = FALSE)
  )

  # Check for successful response
  if (httr::status_code(response) != 200) {
    error_content <- httr::content(response, "text", encoding = "UTF-8")
    stop("API request failed with status ", httr::status_code(response), ": ", error_content)
  }

  # Parse the JSON response
  response_data <- httr::content(response, "parsed", encoding = "UTF-8")

  # Process the batch response into a tidy tibble
  results_list <- list()

  for (doc_response in response_data) {
    doc_id <- doc_response$document_id
    doc_results <- doc_response$results

    if (length(doc_results) > 0) {
      # Convert each result to a data frame and add document_id
      for (result in doc_results) {
        results_list[[length(results_list) + 1]] <- data.frame(
          document_id = doc_id,
          label = ifelse(is.null(result$label), NA, result$label),
          uri = ifelse(is.null(result$uri), NA, result$uri),
          notation = ifelse(is.null(result$notation), NA, result$notation),
          score = ifelse(is.null(result$score), NA, result$score),
          stringsAsFactors = FALSE
        )
      }
    } else {
      # Create empty row for documents with no results
      results_list[[length(results_list) + 1]] <- data.frame(
        document_id = doc_id,
        label = NA,
        uri = NA,
        notation = NA,
        score = NA,
        stringsAsFactors = FALSE
      )
    }
  }

  # Combine all results
  if (length(results_list) > 0) {
    final_results <- dplyr::bind_rows(results_list)
  } else {
    final_results <- tibble::tibble(
      document_id = character(),
      label = character(),
      uri = character(),
      notation = character(),
      score = numeric()
    )
  }

  return(final_results)
}
