#' Process and Fetch KANTO Information with Multiple Professions
#'
#' This function extracts Asteri IDs from the provided dataset, fetches RDF data
#' from the Finto Skosmos API, and returns a cleaned tibble with the retrieved
#' data. The function retains only the Asteri ID and the relevant API results.
#' Additionally, it retrieves profession metadata for each profession URI and
#' stores the `prefLabel_en` values as a comma-separated string in the `profession` column.
#'
#' @param data A dataframe containing 'Code_1000' and 'Code_7001' columns.
#' @return A tibble with `asteriID`, fetched RDF data, and profession labels.
#' @import dplyr purrr tibble stringr tidyr
#' @importFrom dplyr mutate select coalesce rowwise filter distinct slice
#' @examples
#' \dontrun{
#' results <- process_and_fetch_kanto_info(my_data)
#' }
#' @export
process_and_fetch_kanto_info <- function(data) {
  # Step 1: Extract numeric asteriIDs from Code_1000 and Code_7001
  data_clean <- data %>%
    dplyr::mutate(
      asteriID_1000 = stringr::str_extract(Code_1000, "\\d{9}"),
      asteriID_7001 = stringr::str_extract(Code_7001, "\\d{9}"),
      asteriID = dplyr::coalesce(asteriID_1000, asteriID_7001)  # Prioritize non-NA asteriID
    ) %>%
    dplyr::select(asteriID) %>%
    dplyr::distinct()  # Remove duplicate Asteri IDs

  # Step 2: Fetch RDF data for each valid asteriID
  results <- data_clean %>%
    dplyr::rowwise() %>%
    dplyr::mutate(
      rdf_data = if (!is.na(asteriID)) {
        list(tryCatch(
          fetch_kanto_info(asteriID) %>%
            dplyr::filter(uri == paste0("http://urn.fi/URN:NBN:fi:au:finaf:", asteriID)),  # Keep only valid rows
          error = function(e) tibble::tibble(
            uri = NA, type = NA, prefLabel = NA, altLabel = NA, hiddenLabel = NA,
            broader = NA, narrower = NA, related = NA, definition = NA, scopeNote = NA,
            example = NA, historyNote = NA, editorialNote = NA, changeNote = NA,
            profession = NA, birthDate = NA, deathDate = NA, exactMatch = NA, closeMatch = NA,
            inScheme = NA, created = NA, modified = NA
          )
        ))
      } else list(NULL)
    ) %>%
    tidyr::unnest(cols = c(rdf_data), keep_empty = TRUE)  # Preserve missing rows

  # Step 3: Extract and fetch profession labels for multiple profession URIs
  results_with_profession <- results %>%
    dplyr::mutate(
      profession_uris = ifelse(!is.na(profession), strsplit(profession, ",\\s*"), list(NA_character_)) # Store as list
    ) %>%
    dplyr::rowwise() %>%
    dplyr::mutate(
      profession_labels = if (!is.na(profession) && length(profession_uris) > 0) {
        paste(
          purrr::map_chr(profession_uris, function(uri) {
            tryCatch(
              fetch_profession_info(uri) %>% dplyr::pull(prefLabel_en),  # Fetch label for each URI
              error = function(e) NA_character_
            )
          }),
          collapse = ", "  # Combine multiple professions into a single string
        )
      } else NA_character_
    ) %>%
    dplyr::mutate(profession = profession_labels) %>%  # Replace profession URIs with prefLabel_en values
    dplyr::select(-profession_uris, -profession_labels)  # Remove temp columns

  # Step 4: Ensure final output keeps asteriID and relevant columns
  results_clean <- results_with_profession %>%
    dplyr::select(asteriID, everything())  # Keep profession as second column

  return(results_clean)
}
