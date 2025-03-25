#' Process and Fetch KANTO Information using author_id
#'
#' This function extracts Asteri IDs from the 'author_id' column,
#' fetches RDF data from the Finto Skosmos API using those IDs,
#' and returns a cleaned tibble with the retrieved metadata and profession labels.
#'
#' @param data A dataframe containing an 'author_id' column with values like "(FIN11)000069536".
#' @return A tibble with `asteriID`, RDF data, and extracted profession labels.
#' @import dplyr purrr tibble stringr tidyr
#' @importFrom dplyr mutate select rowwise filter distinct group_by ungroup
#' @examples
#' \dontrun{
#' results <- get_kanto(my_data)
#' }
#' @export
get_kanto <- function(data) {
  # Step 1: Extract numeric Asteri ID from 'author_id' column
  data_clean <- data %>%
    dplyr::mutate(
      asteriID = stringr::str_extract(author_id, "\\d{9}")
    ) %>%
    dplyr::filter(!is.na(asteriID)) %>%
    dplyr::distinct(asteriID)

  # Step 2: Fetch RDF data for each valid asteriID
  results <- data_clean %>%
    dplyr::rowwise() %>%
    dplyr::mutate(
      rdf_data = list(
        tryCatch(
          fetch_kanto_info(asteriID) %>%
            dplyr::filter(uri == paste0("http://urn.fi/URN:NBN:fi:au:finaf:", asteriID)),
          error = function(e) tibble::tibble(
            uri = NA, type = NA, prefLabel = NA, altLabel = NA, hiddenLabel = NA,
            broader = NA, narrower = NA, related = NA, definition = NA, scopeNote = NA,
            example = NA, historyNote = NA, editorialNote = NA, changeNote = NA,
            profession = NA, birthDate = NA, deathDate = NA, exactMatch = NA, closeMatch = NA,
            inScheme = NA, created = NA, modified = NA
          )
        )
      )
    ) %>%
    tidyr::unnest(cols = c(rdf_data), keep_empty = TRUE)

  # Step 3: Resolve profession URIs to English labels
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

  # Step 4: Return cleaned result
  results_clean <- results %>%
    dplyr::select(asteriID, everything(), -profession_uris, -profession_metadata_prefLabel_en)

  return(results_clean)
}
