#' Fetch hierarchy of professions from Finto API
#'
#' This function retrieves broader/narrower relationships and constructs a hierarchical structure.
#'
#' @param concept_uri The URI of the starting profession (root).
#' @param vocid The vocabulary ID (default: "mts").
#' @param depth The depth of hierarchy to fetch (default: 3).
#' @return A data.frame representing the hierarchy.
#' @author Akewak Jeba  \email{akewak84@@gmail.com}
#' @examples
#' hierarchy_df <- fetch_profession_hierarchy("http://urn.fi/URN:NBN:fi:au:mts:m3357")
#' print(hierarchy_df)
#' @export
fetch_profession_hierarchy <- function(concept_uri, vocid = "mts", depth = 3) {

  base_url <- paste0("https://api.finto.fi/rest/v1/", vocid, "/data")

  # Recursive function to fetch hierarchy
  get_hierarchy <- function(uri, level = 0) {

    if (level > depth) return(NULL)  # Stop recursion if max depth reached

    # Fetch data for the given concept URI
    response <- GET(base_url, query = list(uri = uri, format = "application/json"))

    if (status_code(response) != 200) return(NULL)

    json_data <- content(response, as = "parsed", type = "application/json")

    # Extract main concept
    graph_data <- json_data$graph
    concept <- graph_data[[which(sapply(graph_data, function(x) x$uri == uri))]]

    if (is.null(concept)) return(NULL)

    # Extract labels
    prefLabel <- if (!is.null(concept$prefLabel$en)) concept$prefLabel$en$value else NA_character_

    # Extract broader and narrower concepts
    broader_uri <- if (!is.null(concept$broader)) concept$broader$uri else NA_character_
    narrower_uris <- if (!is.null(concept$narrower)) concept$narrower$uri else NA_character_

    # Create dataframe row
    df <- tibble(
      child = uri,
      child_label = prefLabel,
      parent = broader_uri
    )

    # Recursively fetch broader and narrower concepts
    broader_df <- if (!is.na(broader_uri)) get_hierarchy(broader_uri, level + 1) else NULL
    narrower_df <- if (!is.na(narrower_uris)) bind_rows(lapply(narrower_uris, get_hierarchy, level + 1)) else NULL

    # Combine results
    return(bind_rows(df, broader_df, narrower_df))
  }

  # Fetch hierarchy starting from root URI
  hierarchy_df <- get_hierarchy(concept_uri)

  return(hierarchy_df)
}

# Fetch the profession hierarchy for "physiologist"
#hierarchy_df <- fetch_profession_hierarchy("http://urn.fi/URN:NBN:fi:au:mts:m3357")
#print(hierarchy_df)

#library(data.tree)

# Convert to hierarchical tree structure
#hierarchy_tree <- as.Node(hierarchy_df, pathName = "child")

# Print the tree
#print(hierarchy_tree, "child_label")
#library(igraph)

# Convert data to graph
#g <- graph_from_data_frame(hierarchy_df, directed = TRUE)

# Plot the graph
#plot(g, vertex.label = V(g)$name, layout = layout_as_tree(g))


