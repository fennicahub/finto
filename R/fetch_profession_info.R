#' Fetch all metadata from Finto Skosmos API
#'
#' This function queries the Finto API for a given concept URI and extracts all relevant metadata fields.
#'
#' @param concept_uri The URI of the concept to fetch.
#' @return A tibble containing the full metadata.
#' @author Akewak Jeba & Leo Lahti
#' @examples
#' metadata <- fetch_profession_info("http://urn.fi/URN:NBN:fi:au:mts:m3357")
#' print(metadata)
#' @export
fetch_profession_info <- function(concept_uri) {

  # Define the Finto API endpoint
  base_url <- "https://api.finto.fi/rest/v1/data"

  # Construct query parameters
  params <- list(uri = concept_uri, format = "application/json")

  # Make the API request
  response <- GET(base_url, query = params, accept("application/ld+json"))

  # Check if the request was successful
  if (status_code(response) != 200) {
    stop("Failed to retrieve data. Check the URI and try again.")
  }

  # Parse JSON response
  json_data <- content(response, as = "parsed", type = "application/json")

  # Extract the graph
  graph_data <- json_data$graph

  # Function to extract preferred label from multilingual fields
  extract_label <- function(label_list, lang = "en") {
    if (is.null(label_list)) return(NA_character_)
    label <- label_list[which(sapply(label_list, function(x) x$lang == lang))]
    if (length(label) == 0) return(NA_character_)
    return(label[[1]]$value)
  }

  # Find the main concept in the graph
  main_entry <- graph_data[[which(sapply(graph_data, function(x) x$uri == concept_uri))]]

  if (is.null(main_entry)) {
    stop("No matching concept found for the given URI.")
  }

  # Extract data safely
  rdf_tibble <- tibble(
    profession_uri = concept_uri,
    profession_prefLabel_en = extract_label(main_entry$prefLabel, "en"),
    profession_prefLabel_fi = extract_label(main_entry$prefLabel, "fi"),
    profession_prefLabel_sv = extract_label(main_entry$prefLabel, "sv"),
    profession_entryTerms = if (!is.null(main_entry$altLabel))
      paste(sapply(main_entry$altLabel, function(x) x$value), collapse = ", ") else NA_character_,
    profession_belongsToGroup = if (!is.null(main_entry$inScheme$uri)) main_entry$inScheme$uri else NA_character_,
    profession_broader = if (!is.null(main_entry$broader$uri)) main_entry$broader$uri else NA_character_,
    profession_narrower = if (!is.null(main_entry$narrower$uri)) main_entry$narrower$uri else NA_character_,
    profession_related = if (!is.null(main_entry$related$uri)) main_entry$related$uri else NA_character_,
    profession_created = if (!is.null(main_entry$`dct:created`$value)) main_entry$`dct:created`$value else NA_character_,
    profession_modified = if (!is.null(main_entry$`dct:modified`$value)) main_entry$`dct:modified`$value else NA_character_,
    profession_closeMatch = if (!is.null(main_entry$closeMatch$uri)) main_entry$closeMatch$uri else NA_character_,
    profession_source = if (!is.null(main_entry$`dc11:source`))
      paste(sapply(main_entry$`dc11:source`, function(x) x$value), collapse = ", ") else NA_character_,
    profession_downloadFormats = "RDF/XML, TURTLE, JSON-LD" # Static formats
  )

  return(rdf_tibble)
}
