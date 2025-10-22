#' Get the hierarchical context for a specific concept from the Finto Skosmos API
#'
#' @param vocid The vocabulary ID, e.g., "yso".
#' @param uri The URI of the concept whose hierarchical context to retrieve.
#' @param lang The language code for the labels, e.g., "fi" or "en". Optional.
#' @return A tibble containing the hierarchical context (broader, narrower, prefLabel, etc.) for the specified concept.
#' @author Akewak Jeba & Leo Lahti
#' @importFrom httr GET status_code content accept
#' @importFrom jsonlite fromJSON
#' @importFrom tibble tibble
#' @importFrom dplyr add_row
#' @examples
#' hierarchy <- get_hierarchy(vocid = "yso", uri = "http://www.yso.fi/onto/yso/p24489", lang = "fi")
#' print(hierarchy)
#' @export
get_hierarchy <- function(vocid, uri, lang = NULL) {
  # Construct the base URL for the API request
  base_url <- paste0("https://api.finto.fi/rest/v1/", vocid, "/hierarchy")

  # Set up the query parameters
  params <- list(
    uri = uri,
    lang = lang
  )

  # Make the API request using httr::GET
  response <- httr::GET(base_url, query = params, httr::accept("application/ld+json"))

  # Check for a successful response
  status <- httr::status_code(response)
  if (status == 404) {
    message("Warning: Concept not found in the vocabulary '", vocid, "' for URI: ", uri)
    return(tibble::tibble(uri = uri, broader = NA_character_, prefLabel = NA_character_, hasChildren = NA))
  } else if (status != 200) {
    warning("API request failed with status code ", status, ": ", httr::content(response, "text"))
    return(NULL)
  }

  # Parse the response content using jsonlite
  data <- jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"), flatten = TRUE)

  # Initialize a tibble to store the results
  results <- tibble::tibble(
    uri = character(),
    broader = character(),
    prefLabel = character(),
    hasChildren = logical()
  )

  # Extract broader transitive information
  if (!is.null(data$broaderTransitive)) {
    for (broad in names(data$broaderTransitive)) {
      broader_info <- data$broaderTransitive[[broad]]
      results <- dplyr::add_row(results,
                                uri = broader_info$uri,
                                broader = NA_character_,
                                prefLabel = broader_info$prefLabel,
                                hasChildren = broader_info$hasChildren
      )

      # Extract narrower concepts
      if (!is.null(broader_info$narrower)) {
        for (narrow in broader_info$narrower$uri) {
          results <- dplyr::add_row(results,
                                    uri = narrow,
                                    broader = broader_info$uri,
                                    prefLabel = broader_info$prefLabel,
                                    hasChildren = FALSE
          )
        }
      }
    }
  }

  # Return the final tibble with all hierarchical data
  return(results)
}
