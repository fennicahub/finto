#' Process and Fetch KANTO Information using a list of author_IDs as column
#'
#' This function extracts Asteri IDs from the 'author_ID' column as list,
#' fetches RDF data from the Finto Skosmos API using those IDs,
#' and returns a cleaned tibble with the retrieved metadata and profession labels.
#'
#' @param data A dataframe containing an 'author_ID' column with values like "(FIN11)000069536".
#' @return A tibble with `author_ID`, RDF data, and extracted profession labels.
#' @import dplyr purrr tibble stringr tidyr
#' @importFrom dplyr mutate select rowwise filter distinct group_by ungroup distinct
#' @export
get_kanto <- function(data) {

  # ---- Step 1: Extract Asteri IDs ----
  data_clean <- data %>%
    dplyr::mutate(author_ID = stringr::str_extract(author_ID, "\\d{9}")) %>%
    dplyr::filter(!is.na(author_ID)) %>%
    dplyr::distinct(author_ID)

  # ---- Step 2: Fetch RDF metadata from KANTO ----
  results <- data_clean %>%
    dplyr::rowwise() %>%
    dplyr::mutate(
      rdf_data = list(
        tryCatch(
          fetch_kanto_info(author_ID) %>%
            dplyr::filter(uri == paste0("http://urn.fi/URN:NBN:fi:au:finaf:", author_ID)),
          error = function(e)
            tibble::tibble(
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
              birthPlace = NA_character_,
              deathPlace = NA_character_,
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
              error = function(e)
                tibble::tibble(uri = uri, prefLabel_en = NA_character_)
            )
          } else {
            tibble::tibble(uri = NA_character_, prefLabel_en = NA_character_)
          }
        }
      )
    ) %>%
    tidyr::unnest_wider(profession_metadata, names_sep = "_") %>%
    dplyr::group_by(author_ID) %>%
    dplyr::mutate(
      profession_labels =
        paste(profession_metadata_profession_prefLabel_en, collapse = ", ")
    ) %>%
    dplyr::ungroup()

  # ---- Step 4: Deduplicate repeated fields ----
  results_clean <- results %>%
    dplyr::select(-profession_uris) %>%
    dplyr::group_by(author_ID, uri) %>%
    dplyr::summarise(
      dplyr::across(where(is.character), collapse_chr),
      .groups = "drop"
    ) %>%
    dplyr::select(
      author_ID, dplyr::everything(),
      -profession_metadata_prefLabel_en
    )

  # ---- Step 5: Add YSO place metadata for birthPlace & deathPlace ----
  results_clean <- results_clean %>%
    dplyr::rowwise() %>%
    dplyr::mutate(
      birthPlace_info = list(extract_place_info(birthPlace, "birthPlace")),
      deathPlace_info = list(extract_place_info(deathPlace, "deathPlace")),
      country_info = list(extract_place_info(country, "country")),
      placeAssociatedWithPerson_info =
        list(extract_place_info(placeAssociatedWithPerson, "placeAssociatedWithPerson"))
    ) %>%
    dplyr::ungroup() %>%
    tidyr::unnest_wider(birthPlace_info) %>%
    tidyr::unnest_wider(deathPlace_info) %>%
    tidyr::unnest_wider(country_info) %>%
    tidyr::unnest_wider(placeAssociatedWithPerson_info)

  # ---- Step 6: relatedPersonOfPerson to labels (fi/en/sv) ----
  results_clean <- results_clean %>%
    dplyr::mutate(
      relatedPersonOfPerson_info = purrr::map(
        relatedPersonOfPerson,
        resolve_related_persons
      )
    ) %>%
    tidyr::unnest_wider(relatedPersonOfPerson_info)

  return(results_clean)
}

# Helper: collapse repeated character values
collapse_chr <- function(x) {
  x <- unique(stats::na.omit(x))
  if (length(x) == 0L) NA_character_ else paste(x, collapse = ", ")
}

# -------------------------------------------------------------------------
# Helper: extract selected fields from yso_place() and rename by prefix
extract_place_info <- function(uri, prefix) {

  if (is.na(uri) || uri == "") {
    return(tibble::tibble(
      !!paste0(prefix, "_label_fi")  := NA_character_,
      !!paste0(prefix, "_label_en")  := NA_character_,
      !!paste0(prefix, "_label_sv")  := NA_character_,
      !!paste0(prefix, "_lat")       := NA_real_,
      !!paste0(prefix, "_long")      := NA_real_
    ))
  }

  place <- yso_place(uri)

  tibble::tibble(
    !!paste0(prefix, "_label_fi")  := place$label_fi,
    !!paste0(prefix, "_label_en")  := place$label_en,
    !!paste0(prefix, "_label_sv")  := place$label_sv,
    !!paste0(prefix, "_lat")       := place$lat,
    !!paste0(prefix, "_long")      := place$long
  )
}

# Helper: from comma-separated Finaf URIs, get names in fi/en/sv
# Helper: from comma-separated Finaf URIs, get only prefLabel
resolve_related_persons <- function(uris_str) {

  # Handle empty / NA
  if (is.null(uris_str) || is.na(uris_str) || trimws(uris_str) == "") {
    return(tibble::tibble(
      relatedPersonOfPerson_prefLabel = NA_character_
    ))
  }

  uris <- strsplit(uris_str, ",\\s*")[[1]]
  ids  <- stringr::str_extract(uris, "\\d{9}")   # Extract 9-digit Asteri IDs

  lab_vec <- purrr::map_chr(
    ids,
    function(id) {
      if (is.na(id)) return(NA_character_)

      out <- tryCatch(
        fetch_kanto_info(id),
        error = function(e) NULL
      )

      if (is.null(out) || nrow(out) == 0) {
        NA_character_
      } else if ("prefLabel" %in% names(out)) {
        collapse_chr(out$prefLabel)
      } else {
        NA_character_
      }
    }
  )

  tibble::tibble(
    relatedPersonOfPerson_prefLabel = collapse_chr(lab_vec)
  )
}
