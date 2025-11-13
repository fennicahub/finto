#' Get type information for a Finto vocabulary
#'
#' This function retrieves information about the types (classes) of objects
#' in a given Finto/Skosmos vocabulary, using the `/types` endpoint.
#'
#' @param vocid A Skosmos vocabulary identifier, e.g. `"yso"`.
#' @param lang Optional language code for labels, e.g. `"fi"` or `"en"`.
#'   If `NULL` (default), the API's default language is used.
#' @return A tibble with one row per type, typically containing columns
#'   `uri`, `label`, and (optionally) `superclass`.
#' @examples
#' types <- get_vocabulary_types("yso", lang = "fi")
#' print(types)
#' @export
get_vocabulary_types <- function(vocid, lang = NULL) {
  # Construct the /types endpoint URL
  base_url <- sprintf("https://api.finto.fi/rest/v1/%s/types", vocid)

  # Build query parameters, dropping NULLs
  params <- list(lang = lang)
  params <- params[!vapply(params, is.null, logical(1))]

  # Perform the request, asking for JSON-LD
  response <- httr::GET(
    url   = base_url,
    query = params,
    httr::accept("application/ld+json")
  )

  # Check status code
  if (httr::status_code(response) != 200) {
    stop(
      "Error: ", httr::status_code(response),
      " - ", httr::content(response, as = "text", encoding = "UTF-8")
    )
  }

  # Extract JSON as text and parse
  json_txt <- httr::content(response, as = "text", encoding = "UTF-8")
  json_obj <- jsonlite::fromJSON(json_txt, simplifyVector = TRUE)

  # Pull out the 'types' array
  types <- json_obj$types

  # If no types are found, return an empty tibble
  if (is.null(types) || length(types) == 0) {
    return(tibble::tibble())
  }

  # Convert to tibble (columns: uri, label, superclass if present)
  tibble::as_tibble(types)
}
