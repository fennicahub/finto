% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_modified_concepts.R
\name{get_modified_concepts}
\alias{get_modified_concepts}
\title{Get modified concepts in a specific vocabulary from the Finto Skosmos API}
\usage{
get_modified_concepts(vocid, lang = NULL, offset = NULL, limit = NULL)
}
\arguments{
\item{vocid}{The vocabulary ID, e.g., "yso".}

\item{lang}{The language of labels, e.g., "en" or "fi". Optional.}

\item{offset}{Offset for the starting index of the results. Optional.}

\item{limit}{Maximum number of concepts to return. Optional.}
}
\value{
A tibble containing the modified concepts with URI, label, and modification date.
}
\description{
Get modified concepts in a specific vocabulary from the Finto Skosmos API
}
\examples{
result <- get_modified_concepts(vocid = "yso", lang = "fi", limit = 10)
print(result)
}
