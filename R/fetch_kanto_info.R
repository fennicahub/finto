#' Fetch RDF data for a specific concept from the Finto Skosmos API using an asteriID
#'
#' This function retrieves RDF data for a given concept from the Finto API.
#' The user only needs to provide the asteriID, which is appended to a fixed base URI.
#'
#' @param asteriID The unique identifier to append to the base URI.
#' @param format The MIME type of the serialization format (e.g., "application/rdf+xml" or "text/turtle"). Default is "application/json".
#' @return A tibble containing the RDF data for the concept.
#' @examples
#' concept_data <- fetch_kanto_info(asteriID = "000094320")
#' print(concept_data)
#' @export
fetch_kanto_info <- function(asteriID, format = "application/json") {

  base_uri <- "http://urn.fi/URN:NBN:fi:au:finaf:"

  if (missing(asteriID) || is.null(asteriID)) {
    stop("The 'asteriID' parameter is required.")
  }

  full_uri <- paste0(base_uri, asteriID)
  params <- list(uri = full_uri, format = format)
  response <- finto_api_request("data", params)
  #print(response)

  if (!is.list(response) || is.null(response$graph)) {
    stop("Unexpected API response format.")
  }

  graph_data <- response$graph
  #print(graph_data)
  concept <- purrr::detect(graph_data, ~ identical(.x$uri, full_uri))
  #print(concept)
  safe_extract_values <- function(x, field) {
    val <- x[[field]]
    if (is.null(val)) return(NA_character_)
    if (is.character(val)) return(val)
    if (!is.null(val$value)) return(val$value)
    if (is.list(val)) {
      if (all(purrr::map_lgl(val, ~ is.list(.x) && "value" %in% names(.x)))) {
        return(paste(purrr::map_chr(val, "value"), collapse = ", "))
      }
      if (!is.null(val$value)) return(val$value)
    }
    return(as.character(val))
  }

  safe_extract_uris <- function(x, field) {
    val <- x[[field]]
    if (is.null(val)) return(NA_character_)
    if (!is.null(val$uri)) return(val$uri)
    if (is.character(val)) return(NA_character_)  # skip non-URI
    if (is.list(val) && all(purrr::map_lgl(val, ~ is.list(.x) && "uri" %in% names(.x)))) {
      uris <- purrr::map_chr(val, "uri")
      return(paste(na.omit(uris), collapse = ", "))
    }
    return(NA_character_)
  }


  rdf_tibble <- tibble(
    uri = concept$uri,
    type = paste(concept$type, collapse = ", "),
    prefLabel = safe_extract_values(concept, "prefLabel"),
    altLabel = safe_extract_values(concept, "altLabel"),
    variantName = safe_extract_values(concept, "http://rdaregistry.info/Elements/a/P50103"),
    hiddenLabel = safe_extract_values(concept, "hiddenLabel"),
    authorizedAccessPoint = safe_extract_values(concept, "http://rdaregistry.info/Elements/a/P50411"),
    note = safe_extract_values(concept, "http://rdaregistry.info/Elements/a/P50395"),
    birthDate = concept[["http://rdaregistry.info/Elements/a/P50121"]] %||% NA_character_,
    deathDate = concept[["http://rdaregistry.info/Elements/a/P50120"]] %||% NA_character_,
    birthPlace = safe_extract_uris(concept, "http://rdaregistry.info/Elements/a/P50119"),
    deathPlace = safe_extract_uris(concept, "http://rdaregistry.info/Elements/a/P50118"),
    profession = safe_extract_uris(concept, "http://rdaregistry.info/Elements/a/P50104"),
    language = safe_extract_uris(concept, "http://rdaregistry.info/Elements/a/P50102"),
    title = safe_extract_uris(concept, "http://rdaregistry.info/Elements/a/P50110"),
    country = safe_extract_uris(concept, "http://rdaregistry.info/Elements/a/P50097"),
    relatedPerson = safe_extract_uris(concept, "http://rdaregistry.info/Elements/a/P50316"),
    isni = safe_extract_uris(concept, "http://rdaregistry.info/Elements/a/P50094"),
    source = safe_extract_values(concept, "http://rdaregistry.info/Elements/u/P61101"),
    exactMatch = safe_extract_uris(concept, "exactMatch"),
    closeMatch = safe_extract_uris(concept, "closeMatch"),
    inScheme = safe_extract_uris(concept, "inScheme"),
    created = concept[["dct:created"]]$value %||% NA_character_,
    modified = concept[["dct:modified"]]$value %||% NA_character_
  )

}
