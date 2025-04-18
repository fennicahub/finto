% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_vocabulary_info.R
\name{get_vocabulary_info}
\alias{get_vocabulary_info}
\title{Get general information about a specific vocabulary from the Finto Skosmos API}
\usage{
get_vocabulary_info(vocid, lang = NULL)
}
\arguments{
\item{vocid}{The vocabulary ID, e.g., "yso".}

\item{lang}{The language of labels to retrieve, e.g., "en" or "fi". Optional.}
}
\value{
A list containing the vocabulary details such as URI, title, languages, and concept schemes.
}
\description{
Get general information about a specific vocabulary from the Finto Skosmos API
}
\examples{
result <- get_vocabulary_info(vocid = "yso", lang = "fi")
print(result)
}
