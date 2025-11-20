# Get members of a specific concept group from the Finto Skosmos API

Get members of a specific concept group from the Finto Skosmos API

## Usage

``` r
get_group_members(vocid, uri, lang = NULL)
```

## Arguments

- vocid:

  The vocabulary ID, e.g., "yso".

- uri:

  The URI of the concept group whose members to retrieve.

- lang:

  The language code for the labels, e.g., "fi" or "en". Optional.

## Value

A tibble containing members associated with the specified concept group.

## Examples

``` r
group_members_data <- get_group_members(vocid = "yso",uri = "http://www.yso.fi/onto/yso/p26580", lang = "fi")
print(head(group_members_data))
#>                                 uri      prefLabel isSuper hasMembers
#> 1  http://www.yso.fi/onto/yso/p1191         aallot   FALSE      FALSE
#> 2 http://www.yso.fi/onto/yso/p17176        ahtojää   FALSE      FALSE
#> 3 http://www.yso.fi/onto/yso/p28291 alkaliniteetti   FALSE      FALSE
#> 4  http://www.yso.fi/onto/yso/p7723     alkalointi   FALSE      FALSE
#> 5  http://www.yso.fi/onto/yso/p3809    allasalueet   FALSE      FALSE
#> 6 http://www.yso.fi/onto/yso/p24086        allikot   FALSE      FALSE
#>                            type
#> 1 skos:Concept, ysometa:Concept
#> 2 skos:Concept, ysometa:Concept
#> 3 skos:Concept, ysometa:Concept
#> 4 skos:Concept, ysometa:Concept
#> 5 skos:Concept, ysometa:Concept
#> 6 skos:Concept, ysometa:Concept
```
