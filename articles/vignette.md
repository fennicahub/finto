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

| uri                                           | type                                                      | prefLabel              | altLabel                | hiddenLabel | broader | narrower | related | definition | scopeNote | example | historyNote | editorialNote | changeNote | profession | birthDate | deathDate | exactMatch | closeMatch | inScheme                             | created    | modified            |
|:----------------------------------------------|:----------------------------------------------------------|:-----------------------|:------------------------|:------------|:--------|:---------|:--------|:-----------|:----------|:--------|:------------|:--------------|:-----------|:-----------|:----------|:----------|:-----------|:-----------|:-------------------------------------|:-----------|:--------------------|
| <http://rdaregistry.info/Elements/a/P50094>   | NA                                                        | NA                     | NA                      | NA          | NA      | NA       | NA      | NA         | NA        | NA      | NA          | NA            | NA         | NA         | NA        | NA        | NA         | NA         | NA                                   | NA         | NA                  |
| <http://rdaregistry.info/Elements/a/P50103>   | NA                                                        | NA                     | NA                      | NA          | NA      | NA       | NA      | NA         | NA        | NA      | NA          | NA            | NA         | NA         | NA        | NA        | NA         | NA         | NA                                   | NA         | NA                  |
| <http://rdaregistry.info/Elements/a/P50411>   | NA                                                        | NA                     | NA                      | NA          | NA      | NA       | NA      | NA         | NA        | NA      | NA          | NA            | NA         | NA         | NA        | NA        | NA         | NA         | NA                                   | NA         | NA                  |
| <http://rdaregistry.info/Elements/c/C10004>   | owl:Class                                                 | NA                     | NA                      | NA          | NA      | NA       | NA      | NA         | NA        | NA      | NA          | NA            | NA         | NA         | NA        | NA        | NA         | NA         | NA                                   | NA         | NA                  |
| <http://urn.fi/URN:NBN:fi:au:finaf>:          | skos:ConceptScheme                                        | NA                     | NA                      | NA          | NA      | NA       | NA      | NA         | NA        | NA      | NA          | NA            | NA         | NA         | NA        | NA        | NA         | NA         | NA                                   | NA         | NA                  |
| <http://urn.fi/URN:NBN:fi:au:finaf:000094320> | <http://rdaregistry.info/Elements/c/C10004>, skos:Concept | A:son-Ljungberg, Inger | Ljungberg, Inger A:son- | NA          | NA      | NA       | NA      | NA         | NA        | NA      | NA          | NA            | NA         | NA         | NA        | NA        | NA         | NA         | <http://urn.fi/URN:NBN:fi:au:finaf>: | 1998-04-16 | 2020-11-11T20:14:39 |

author info

### Retrieval of profession information

``` r
library(finto)
profession_info <- fetch_profession_info("http://urn.fi/URN:NBN:fi:au:mts:m3357")
knitr::kable(profession_info,caption = "author info")
```

| profession_uri                          | profession_prefLabel_en | profession_prefLabel_fi | profession_prefLabel_sv | profession_entryTerms                 | profession_belongsToGroup          | profession_broader | profession_narrower | profession_related | profession_created | profession_modified | profession_closeMatch               | profession_source                                                | profession_downloadFormats |
|:----------------------------------------|:------------------------|:------------------------|:------------------------|:--------------------------------------|:-----------------------------------|:-------------------|:--------------------|:-------------------|:-------------------|:--------------------|:------------------------------------|:-----------------------------------------------------------------|:---------------------------|
| <http://urn.fi/URN:NBN:fi:au:mts:m3357> | physiologist            | fysiologi               | fysiolog                | fysiologer, physiologists, fysiologit | <http://urn.fi/URN:NBN:fi:au:mts>: | NA                 | NA                  | NA                 | 2018-11-01         | 2024-08-27          | <http://www.yso.fi/onto/yso/p20543> | ALLFO-term, YSO-termi, Nationell RDA-term, Kansallinen RDA-termi | RDF/XML, TURTLE, JSON-LD   |

author info

### Retriveal of both author and profession informations

For this we need a tibble

``` r
library(finto)
library(tidyverse)
input_data <- tibble(author_ID = c("000069536", "000041234", "000057891"))
full_author_info <- finto::get_kanto(input_data)
knitr::kable(full_author_info, caption = "Full author Data Frame from kanto")
```

| author_ID | uri                                           | type                                                      | prefLabel                       | altLabel                        | hiddenLabel | broader | narrower | related | definition | scopeNote | example | historyNote | editorialNote | changeNote | profession                                                                                                                | birthDate | deathDate | exactMatch | closeMatch                                | inScheme                             | created    | modified            | profession_metadata_profession_uri      | profession_metadata_profession_prefLabel_en | profession_metadata_profession_prefLabel_fi | profession_metadata_profession_prefLabel_sv | profession_metadata_profession_entryTerms                                                                                                                                                                                                       | profession_metadata_profession_belongsToGroup | profession_metadata_profession_broader  | profession_metadata_profession_narrower | profession_metadata_profession_related | profession_metadata_profession_created | profession_metadata_profession_modified | profession_metadata_profession_closeMatch | profession_metadata_profession_source                            | profession_metadata_profession_downloadFormats | profession_metadata_uri | profession_labels |
|:----------|:----------------------------------------------|:----------------------------------------------------------|:--------------------------------|:--------------------------------|:------------|:--------|:---------|:--------|:-----------|:----------|:--------|:------------|:--------------|:-----------|:--------------------------------------------------------------------------------------------------------------------------|:----------|:----------|:-----------|:------------------------------------------|:-------------------------------------|:-----------|:--------------------|:----------------------------------------|:--------------------------------------------|:--------------------------------------------|:--------------------------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:----------------------------------------------|:----------------------------------------|:----------------------------------------|:---------------------------------------|:---------------------------------------|:----------------------------------------|:------------------------------------------|:-----------------------------------------------------------------|:-----------------------------------------------|:------------------------|:------------------|
| 000069536 | <http://urn.fi/URN:NBN:fi:au:finaf:000069536> | skos:Concept, <http://rdaregistry.info/Elements/c/C10004> | Malmivaara, Wilhelmi, 1854-1922 | NA                              | NA          | NA      | NA       | NA      | NA         | NA        | NA      | NA          | NA            | NA         | <http://urn.fi/URN:NBN:fi:au:mts:m3285>, <http://urn.fi/URN:NBN:fi:au:mts:m2479>, <http://urn.fi/URN:NBN:fi:au:mts:m2518> | 1854      | 1922      | NA         | <http://urn.fi/urn:nbn:fi:sks-kbg-006242> | <http://urn.fi/URN:NBN:fi:au:finaf>: | 1994-11-13 | 2025-03-03T10:09:23 | <http://urn.fi/URN:NBN:fi:au:mts:m3285> | poet                                        | runoilija                                   | diktare                                     | poets, skalder, lyriker, runoilijat, poeter, lyyrikot                                                                                                                                                                                           | <http://urn.fi/URN:NBN:fi:au:mts>:            | <http://urn.fi/URN:NBN:fi:au:mts:m3004> | NA                                      | NA                                     | 2018-11-01                             | 2024-08-27                              | <http://www.yso.fi/onto/yso/p3490>        | ALLFO-term, YSO-termi, Nationell RDA-term, Kansallinen RDA-termi | RDF/XML, TURTLE, JSON-LD                       | NA                      | NA, NA, NA        |
| 000069536 | <http://urn.fi/URN:NBN:fi:au:finaf:000069536> | skos:Concept, <http://rdaregistry.info/Elements/c/C10004> | Malmivaara, Wilhelmi, 1854-1922 | NA                              | NA          | NA      | NA       | NA      | NA         | NA        | NA      | NA          | NA            | NA         | <http://urn.fi/URN:NBN:fi:au:mts:m3285>, <http://urn.fi/URN:NBN:fi:au:mts:m2479>, <http://urn.fi/URN:NBN:fi:au:mts:m2518> | 1854      | 1922      | NA         | <http://urn.fi/urn:nbn:fi:sks-kbg-006242> | <http://urn.fi/URN:NBN:fi:au:finaf>: | 1994-11-13 | 2025-03-03T10:09:23 | <http://urn.fi/URN:NBN:fi:au:mts:m2479> | priest                                      | pappi                                       | präst                                       | papit, pastors, pastorit, präster, clergymen, pastorer, priests, minister                                                                                                                                                                       | <http://urn.fi/URN:NBN:fi:au:mts>:            | <http://urn.fi/URN:NBN:fi:au:mts:m2671> | NA                                      | NA                                     | 2018-11-01                             | 2024-08-27                              | <http://www.yso.fi/onto/yso/p5468>        | Kansallinen RDA-termi, ALLFO-term, YSO-termi, Nationell RDA-term | RDF/XML, TURTLE, JSON-LD                       | NA                      | NA, NA, NA        |
| 000069536 | <http://urn.fi/URN:NBN:fi:au:finaf:000069536> | skos:Concept, <http://rdaregistry.info/Elements/c/C10004> | Malmivaara, Wilhelmi, 1854-1922 | NA                              | NA          | NA      | NA       | NA      | NA         | NA        | NA      | NA          | NA            | NA         | <http://urn.fi/URN:NBN:fi:au:mts:m3285>, <http://urn.fi/URN:NBN:fi:au:mts:m2479>, <http://urn.fi/URN:NBN:fi:au:mts:m2518> | 1854      | 1922      | NA         | <http://urn.fi/urn:nbn:fi:sks-kbg-006242> | <http://urn.fi/URN:NBN:fi:au:finaf>: | 1994-11-13 | 2025-03-03T10:09:23 | <http://urn.fi/URN:NBN:fi:au:mts:m2518> | member of parliament                        | kansanedustaja                              | riksdagsledamot                             | riksdagsmän, riksdagsledamöter, members of parliament, kansanedustajat, riksdagskvinnor                                                                                                                                                         | <http://urn.fi/URN:NBN:fi:au:mts>:            | NA                                      | NA                                      | NA                                     | 2018-11-01                             | 2024-08-27                              | <http://www.yso.fi/onto/yso/p1520>        | ALLFO-term, Nationell RDA-term, YSO-termi, Kansallinen RDA-termi | RDF/XML, TURTLE, JSON-LD                       | NA                      | NA, NA, NA        |
| 000041234 | <http://urn.fi/URN:NBN:fi:au:finaf:000041234> | skos:Concept, <http://rdaregistry.info/Elements/c/C10004> | Bonsdorff, Johan von, 1940-2002 | Von Bonsdorff, Johan, 1940-2002 | NA          | NA      | NA       | NA      | NA         | NA        | NA      | NA          | NA            | NA         | <http://urn.fi/URN:NBN:fi:au:mts:m3004>, <http://urn.fi/URN:NBN:fi:au:mts:m2565>                                          | 1940      | 2002      | NA         | <http://urn.fi/urn:nbn:fi:sks-kbg-009461> | <http://urn.fi/URN:NBN:fi:au:finaf>: | 1980-08-18 | 2023-04-20T12:33:22 | <http://urn.fi/URN:NBN:fi:au:mts:m3004> | author                                      | kirjailija                                  | författare                                  | arbetarförfattare, novelisti, proletärförfattare, authors, kansalliskirjailija, novellisti, nationalförfattare, kaunokirjailija, prosaisti, nationalskald, esseisti, national author, writers, kirjailijat, proosakirjailija, työläiskirjailija | <http://urn.fi/URN:NBN:fi:au:mts>:            | <http://urn.fi/URN:NBN:fi:au:mts:m2505> | NA                                      | NA                                     | 2018-11-01                             | 2025-09-24                              | <http://www.yso.fi/onto/yso/p8970>        | Kansallinen RDA-termi, ALLFO-term, YSO-termi, Nationell RDA-term | RDF/XML, TURTLE, JSON-LD                       | NA                      | NA, NA            |
| 000041234 | <http://urn.fi/URN:NBN:fi:au:finaf:000041234> | skos:Concept, <http://rdaregistry.info/Elements/c/C10004> | Bonsdorff, Johan von, 1940-2002 | Von Bonsdorff, Johan, 1940-2002 | NA          | NA      | NA       | NA      | NA         | NA        | NA      | NA          | NA            | NA         | <http://urn.fi/URN:NBN:fi:au:mts:m3004>, <http://urn.fi/URN:NBN:fi:au:mts:m2565>                                          | 1940      | 2002      | NA         | <http://urn.fi/urn:nbn:fi:sks-kbg-009461> | <http://urn.fi/URN:NBN:fi:au:finaf>: | 1980-08-18 | 2023-04-20T12:33:22 | <http://urn.fi/URN:NBN:fi:au:mts:m2565> | journalist                                  | toimittaja                                  | journalist                                  | lehtimiehet, editors, toimittajat, journalistit, journalister, reportrar, journalists, redaktörer, tidningsmän, reportterit                                                                                                                     | <http://urn.fi/URN:NBN:fi:au:mts>:            | NA                                      | NA                                      | NA                                     | 2018-11-01                             | 2024-08-27                              | <http://www.yso.fi/onto/yso/p1021>        | YSO-termi, ALLFO-term, Nationell RDA-term, Kansallinen RDA-termi | RDF/XML, TURTLE, JSON-LD                       | NA                      | NA, NA            |
| 000057891 | <http://urn.fi/URN:NBN:fi:au:finaf:000057891> | <http://rdaregistry.info/Elements/c/C10004>, skos:Concept | Saksanen, Seppo, 1936-          | NA                              | NA          | NA      | NA       | NA      | NA         | NA        | NA      | NA          | NA            | NA         | NA                                                                                                                        | 1936      | NA        | NA         | NA                                        | <http://urn.fi/URN:NBN:fi:au:finaf>: | 1981-10-16 | 2020-11-07T16:23:38 | NA                                      | NA                                          | NA                                          | NA                                          | NA                                                                                                                                                                                                                                              | NA                                            | NA                                      | NA                                      | NA                                     | NA                                     | NA                                      | NA                                        | NA                                                               | NA                                             | NA                      | NA                |

Full author Data Frame from kanto
