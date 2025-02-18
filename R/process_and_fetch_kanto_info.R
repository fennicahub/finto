#' Process and Fetch KANTO Information
#'
#' This function extracts Asteri IDs from the provided dataset, fetches RDF data
#' from the Finto Skosmos API, and returns a cleaned tibble with the retrieved
#' data. The function retains the Asteri ID, the relevant API results, and
#' includes profession labels as separate columns.
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
    dplyr::select(asteriID)  # Keep only asteriID

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

  # Step 3: For each profession URI, fetch the prefLabel_en
  results <- results %>%
    dplyr::mutate(
      profession_uris = strsplit(profession, ",\\s*")
    ) %>%
    tidyr::unnest_longer(profession_uris) %>%
    dplyr::mutate(
      profession_metadata = purrr::map(profession_uris, function(uri) {
        if (!is.na(uri)) {
          tryCatch(
            fetch_profession_info(uri),
            error = function(e) tibble::tibble(
              uri = uri, prefLabel_en = NA_character_
            )
          )
        } else {
          tibble::tibble(uri = NA_character_, prefLabel_en = NA_character_)
        }
      })
    ) %>%
    tidyr::unnest_wider(profession_metadata, names_sep = "_") %>%
    dplyr::group_by(asteriID) %>%
    dplyr::mutate(profession_labels = paste(profession_metadata_prefLabel_en, collapse = ", ")) %>%
    dplyr::ungroup()

  # Step 4: Ensure the final output keeps asteriID and all other columns
  results_clean <- results %>%
    dplyr::select(asteriID, everything(), -profession_uris, -profession_metadata_prefLabel_en)

  return(results_clean)
}
