# finto

[![R-CMD-check](https://github.com/fennicahub/finto/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/fennicahub/finto/actions/workflows/check-standard.yaml)
[![issues](https://img.shields.io/github/issues/fennicahub/finto)](https://github.com/fennicahub/finto/issues)
[![pulls](https://img.shields.io/github/issues-pr/fennicahub/finto)](https://github.com/fennicahub/finto/pulls)


The `finto` package provides tools to access the serivice for interoperable thesauri, ontologies and classification schemes for different subject areas. 

## Installation instructions


The devel version of finto can be installed from GitHub as follows:

``` r
# Install finto if not already installed
if (!requireNamespace("finto", quietly = TRUE)) {
  remotes::install_github("fennicahub/finto")
}
```

``` r
remotes::install_github("fennicahub/finto")
```

## Example
The basic functionality of 'finto' can be explored as follows:


``` r
# Load the package
library(finto)
# Perform a simple search and print a table

concepts <- search_concepts("sibelius")
head(concepts)
```



## Contribute

Contributions are very welcome:

- [Use issue tracker](https://github.com/fennicahub/finto/issues) for feedback and bug reports.
- [Send pull requests](https://github.com/fennicahub/finto/)
- [Star us on the Github page](https://github.com/fennicahub/finto/)

### Disclaimer

This package is in no way officially related to or endorsed by Finto.

When using metadata retrieved from Finto database in your work, please
indicate that the metadata source is Finto. If your re-use involves some
kind of modification to data or text, please state this clearly to the
end user. See Finto policy on [copyright and free re-use of data
](https://api.finto.fi/) for more detailed information and certain exceptions.
