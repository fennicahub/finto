#' Fetch place information from YSO places (yso-paikat)
#' @importFrom httr GET content stop_for_status
#' @importFrom jsonlite fromJSON
#' @importFrom tibble tibble
#' @importFrom rlang :=
#' @param x Place id, page URL, or YSO URI
#' @return A one-row tibble with key fields for the place
#' @examples
#' place <- yso_place("http://www.yso.fi/onto/yso/p94257")
#' print(place)
#'
#' @export
yso_place <- function(x) {

  uri <- normalize_yso_place(x)
  if (is.na(uri)) {
    return(tibble(
      input          = x,
      uri            = NA_character_,
      label_fi       = NA_character_,
      label_en       = NA_character_,
      label_sv       = NA_character_,
      broader_uri    = NA_character_,
      broader_fi     = NA_character_,
      broader_en     = NA_character_,
      lat            = NA_real_,
      long           = NA_real_,
      nls_type_uri   = NA_character_,
      nls_type_en    = NA_character_,
      created        = NA_character_,
      modified       = NA_character_,
      exactMatch     = NA_character_,
      closeMatch     = NA_character_,
      narrower_uris  = NA_character_,
      related_uris   = NA_character_
    ))
  }

  resp <- GET(
    "https://api.finto.fi/rest/v1/yso-paikat/data",
    query = list(uri = uri, format = "application/ld+json")
  )
  stop_for_status(resp)

  txt   <- content(resp, as = "text", encoding = "UTF-8")
  json  <- fromJSON(txt, simplifyVector = FALSE)

  g <- json$graph

  # main concept node
  idx <- which(vapply(g, function(n) identical(n$uri, uri), logical(1)))
  concept <- g[[idx]]

  # labels
  lab_fi <- pick_label(concept$prefLabel, "fi")
  lab_en <- pick_label(concept$prefLabel, "en")
  lab_sv <- pick_label(concept$prefLabel, "sv")

  # broader concept
  broader_uri <- concept$broader$uri %||% NA_character_
  if (!is.na(broader_uri)) {
    b_idx <- which(vapply(g, function(n) identical(n$uri, broader_uri), logical(1)))
    broader <- g[[b_idx]]
    broader_fi <- pick_label(broader$prefLabel, "fi")
    broader_en <- pick_label(broader$prefLabel, "en")
  } else {
    broader_fi <- broader_en <- NA_character_
  }

  # coordinates
  lat  <- as.numeric(concept[["http://www.w3.org/2003/01/geo/wgs84_pos#lat"]] %||% NA_character_)
  long <- as.numeric(concept[["http://www.w3.org/2003/01/geo/wgs84_pos#long"]] %||% NA_character_)

  # NLS place type
  nls_type_uri <- concept[["http://www.yso.fi/onto/yso-meta/mmlPlaceType"]]$uri %||% NA_character_
  if (!is.na(nls_type_uri)) {
    t_idx <- which(vapply(g, function(n) identical(n$uri, nls_type_uri), logical(1)))
    nls_type_node <- g[[t_idx]]
    nls_type_en   <- pick_label(nls_type_node$label, "en")
  } else {
    nls_type_en <- NA_character_
  }

  # created / modified
  created  <- concept[["dct:created"]]$value  %||% NA_character_
  modified <- concept[["dct:modified"]]$value %||% NA_character_

  # match URIs

  exact  <- collapse_uris(concept$exactMatch)
  close  <- collapse_uris(concept$closeMatch)
  nar    <- collapse_uris(concept$narrower)
  rel    <- if (is.null(concept$related)) NA_character_ else concept$related$uri

  tibble(
    input          = x,
    uri            = uri,
    label_fi       = lab_fi,
    label_en       = lab_en,
    label_sv       = lab_sv,
    broader_uri    = broader_uri,
    broader_fi     = broader_fi,
    broader_en     = broader_en,
    lat            = lat,
    long           = long,
    nls_type_uri   = nls_type_uri,
    nls_type_en    = nls_type_en,
    created        = created,
    modified       = modified,
    exactMatch     = exact,
    closeMatch     = close,
    narrower_uris  = nar,
    related_uris   = rel
  )
}

normalize_yso_place <- function(x) {
  if (is.na(x) || x == "") return(NA_character_)

  # Finto page URL
  if (grepl("finto.fi/yso-paikat/.*/page/", x)) {
    id <- sub(".*/page/", "", x)
    return(paste0("http://www.yso.fi/onto/yso/", id))
  }

  # bare id
  if (grepl("^p[0-9]+$", x)) {
    return(paste0("http://www.yso.fi/onto/yso/", x))
  }

  # already a YSO URI
  if (grepl("www.yso.fi/onto/yso/", x)) {
    return(x)
  }

  NA_character_
}

# Pick a label with the given language from a list like prefLabel
pick_label <- function(lbls, lang) {
  if (is.null(lbls)) return(NA_character_)
  langs <- vapply(lbls, function(l) l$lang %||% "", character(1))
  hit <- which(langs == lang)
  if (length(hit) == 0) NA_character_ else lbls[[hit[1]]]$value
}

# Safely collapse list of {uri=...} objects to a single '; ' separated string
collapse_uris <- function(x) {
  if (is.null(x)) return(NA_character_)

  # already character
  if (is.character(x)) {
    x <- stats::na.omit(x)
    return(if (!length(x)) NA_character_ else paste(x, collapse = "; "))
  }

  # single object with $uri
  if (is.list(x) && !is.null(x$uri)) {
    return(as.character(x$uri))
  }

  # list of items
  if (is.list(x)) {
    vals <- unlist(
      lapply(x, function(i) {
        if (is.list(i) && !is.null(i$uri)) {
          i$uri
        } else if (is.character(i)) {
          i
        } else {
          NA_character_
        }
      })
    )

    vals <- stats::na.omit(vals)
    return(if (!length(vals)) NA_character_ else paste(vals, collapse = "; "))
  }

  NA_character_
}



# small helper for "x or y"
`%||%` <- function(x, y) if (is.null(x)) y else x
