# Introduction to finto

## Introduction

[Finto](https://finto.fi/) is a Finnish thesaurus and ontology service
that provides a centralized platform for managing and utilizing
controlled vocabularies in various applications, including libraries,
archives, and research institutions. It enables seamless integration
with linked data and supports automated subject indexing through tools
like Annif. Maintained by the National Library of Finland, Finto
enhances interoperability and accessibility of structured metadata
across different domains.

To make a simple search Search Concepts by Query Term we use the
following.

``` r
library(finto)
concepts <- search_concepts("sibelius")
head(concepts)
```

    ## # A tibble: 2 × 7
    ##   uri                           type  prefLabel altLabel hiddenLabel lang  vocab
    ##   <chr>                         <chr> <chr>     <chr>    <lgl>       <chr> <chr>
    ## 1 http://www.yso.fi/onto/koko/… skos… Sibelius… Sibelius NA          fi    koko 
    ## 2 http://www.yso.fi/onto/mero/… skos… Sibelius… Sibelius NA          fi    liiko

To get available vocabularies from the Finto Skosmos API we use

``` r
library(finto)
vocabularies <- get_vocabularies(lang = "en")
head(vocabularies)
```

    ##      uri     id
    ## 1    afo    afo
    ## 2 allars allars
    ## 3    cer    cer
    ## 4     cn     cn
    ## 5  finaf  finaf
    ## 6    geo    geo
    ##                                                                                   title
    ## 1                                       AFO - Natural resource and environment ontology
    ## 2                                                 Allärs - General thesaurus in Swedish
    ## 3 Clean Energy Research ontology of The Bank of Finnish Terminology in Art and Sciences
    ## 4                                                               Finnish Corporate Names
    ## 5                                                     KANTO - Kansalliset toimijatiedot
    ## 6                                                             GEO - Geologian ontologia

To retrieve top concepts in a vocabulary

``` r
library(finto)
top_concepts <- get_top_concepts(vocid = "yso", lang = "fi")
head(top_concepts)
```

    ## # A tibble: 3 × 5
    ##   uri                               label      topConceptOf notation hasChildren
    ##   <chr>                             <chr>      <chr>        <lgl>    <lgl>      
    ## 1 http://www.yso.fi/onto/yso/p8691  ominaisuu… http://www.… NA       TRUE       
    ## 2 http://www.yso.fi/onto/yso/p4762  oliot      http://www.… NA       TRUE       
    ## 3 http://www.yso.fi/onto/yso/p15238 tapahtuma… http://www.… NA       TRUE

### Retrieving author information

To retrieve author information we need unique identifier of the author
which is called asterID

``` r
library(finto)
author_info <- fetch_kanto_info(asteriID = "000094320")
knitr::kable(author_info,caption = "author info")
```

### Retrieval of profession information

``` r
library(finto)
profession_info <- fetch_profession_info("http://urn.fi/URN:NBN:fi:au:mts:m3357")
knitr::kable(profession_info,caption = "author info")
```

### Retriveal of both author and profession informations

For this we need a tibble

``` r
library(finto)
library(tidyverse)
input_data <- tibble(author_ID = c("000069536", "000041234", "000057891"))
full_author_info <- finto::get_kanto(input_data)
knitr::kable(full_author_info, caption = "Full author Data Frame from kanto")
```
