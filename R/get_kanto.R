#' Process and Fetch KANTO Information using author_ID
#'
#' This function extracts Asteri IDs from the 'author_ID' column,
#' fetches RDF data from the Finto Skosmos API using those IDs,
#' and returns a cleaned tibble with the retrieved metadata and profession labels.
#'
#' @param data A dataframe containing an 'author_ID' column with values like "(FIN11)000069536".
#' @return A tibble with `author_ID`, RDF data, and extracted profession labels.
#' @author Akewak Jeba & Leo Lahti
#' @import dplyr purrr tibble stringr tidyr
#' @importFrom dplyr mutate select rowwise filter distinct group_by ungroup distinct
#' @examples
#' \dontrun{
#' results <- get_kanto(my_data)
#' }
#' @export
get_kanto <- function(data) {

  # Helper to collapse character vectors to unique, comma-separated values
  collapse_chr <- function(x) {
    x <- unique(stats::na.omit(x))
    if (length(x) == 0L) NA_character_ else paste(x, collapse = ", ")
  }

  # ---- Step 1: Extract numeric Asteri ID from 'author_ID' column ----
  data_clean <- data %>%
    dplyr::mutate(author_ID = stringr::str_extract(author_ID, "\\d{9}")) %>%
    dplyr::filter(!is.na(author_ID)) %>%
    dplyr::distinct(author_ID)

  # ---- Step 2: Fetch RDF data per author_ID ----
  results <- data_clean %>%
    dplyr::rowwise() %>%
    dplyr::mutate(
      rdf_data = list(
        tryCatch(
          fetch_kanto_info(author_ID) %>%
            dplyr::filter(uri == paste0("http://urn.fi/URN:NBN:fi:au:finaf:", author_ID)),
          error = function(e) tibble::tibble(
            uri = NA_character_,
            type = NA_character_,
            prefLabel = NA_character_,
            altLabel = NA_character_,
            hiddenLabel = NA_character_,
            broader = NA_character_,
            narrower = NA_character_,
            related = NA_character_,
            definition = NA_character_,
            scopeNote = NA_character_,
            example = NA_character_,
            historyNote = NA_character_,
            editorialNote = NA_character_,
            changeNote = NA_character_,
            profession = NA_character_,
            birthDate = NA_character_,
            deathDate = NA_character_,
            exactMatch = NA_character_,
            closeMatch = NA_character_,
            inScheme = NA_character_,
            created = NA_character_,
            modified = NA_character_
          )
        )
      )
    ) %>%
    dplyr::ungroup() %>%
    tidyr::unnest(cols = c(rdf_data), keep_empty = TRUE)

  # ---- Step 3: Resolve profession URIs to English labels ----
  results <- results %>%
    dplyr::mutate(profession_uris = strsplit(profession, ",\\s*")) %>%
    tidyr::unnest_longer(profession_uris) %>%
    dplyr::mutate(
      profession_metadata = purrr::map(
        profession_uris,
        function(uri) {
          if (!is.na(uri)) {
            tryCatch(
              fetch_profession_info(uri),
              error = function(e) tibble::tibble(uri = uri, prefLabel_en = NA_character_)
            )
          } else {
            tibble::tibble(uri = NA_character_, prefLabel_en = NA_character_)
          }
        }
      )
    ) %>%
    tidyr::unnest_wider(profession_metadata, names_sep = "_") %>%
    dplyr::group_by(author_ID) %>%
    dplyr::mutate(profession_labels = paste(profession_metadata_profession_prefLabel_en, collapse = ", ")) %>%

    dplyr::ungroup()

  # ---- Step 4: De-duplicate rows (fix repetitions) & clean columns ----
  # Collapse to one row per (author_ID, uri); combine repeated character fields.
  results_clean <- results %>%
    dplyr::select(-profession_uris) %>%                                # drop helper list-col
    dplyr::group_by(author_ID, uri) %>%
    dplyr::summarise(
      dplyr::across(where(is.character), collapse_chr),
      .groups = "drop"
    ) %>%
    dplyr::select(author_ID, dplyr::everything(), -profession_metadata_prefLabel_en)

  return(results_clean)
}
