% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_annif_projects.R
\name{get_annif_projects}
\alias{get_annif_projects}
\title{Get a list of projects from the Annif REST API}
\usage{
get_annif_projects()
}
\value{
A tibble containing project details, including project ID, name,
language, backend ID,
training status, and modification time.
}
\description{
This function retrieves a list of projects available in the Annif API.
}
\examples{
projects <- get_annif_projects()
print(projects)
}
