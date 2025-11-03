#' Get a list of vocabulary from the Annif REST API
#'
#' This function retrieves a list of vocabularies available in the Annif API.
#'
#' @return A tibble containing vocabulary details, including languages, size,
#' vocabulary ID,
#'         training status, and modification time.
#' @importFrom httr GET status_code content accept
#' @importFrom jsonlite fromJSON
#' @importFrom tibble as_tibble
#' @examples
#' vocab <- get_annif_vocabulary()
#' print(vocab)
#' @export
get_annif_vocabulary <- function() {
  # Define the base URL for the Annif API
  base_url <- "https://ai.finto.fi/v1/vocabs"

  # Make the API request using httr::GET
  response <- httr::GET(base_url, httr::accept("application/json"))
  #print(jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8")))

  # Check for successful response and handle errors
  if (httr::status_code(response) != 200) {
    stop("Error: ", httr::status_code(response), " - ", httr::content(response, "text"))
  }

  # Parse the JSON response
  json_data <- jsonlite::fromJSON(httr::content(response, "text", encoding = "UTF-8"))
  print(json_data)

  # Convert the list of projects into a tibble
  vocab_df <- as_tibble(json_data$vocabs)

  # Flatten languages list-column to a readable string
  if ("languages" %in% names(vocab_df)) {
    vocab_df$languages <- vapply(
      vocab_df$languages,
      function(x) paste(x, collapse = ", "),
      FUN.VALUE = character(1)
    )
  }

  return(vocab_df)
}
