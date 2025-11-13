# Get available vocabularies from the Finto Skosmos API

Get available vocabularies from the Finto Skosmos API

## Usage

``` r
get_vocabularies(lang = "fi")
```

## Arguments

- lang:

  Language of labels, e.g., "en" or "fi" (default is "fi")

## Value

A data frame with the vocabulary details: uri, id, and title

## Examples

``` r
result <- get_vocabularies(lang = "fi")
#> Requesting URL: https://api.finto.fi/rest/v1/vocabularies?lang=fi
print(result)
#>                 uri               id
#> 1               afo              afo
#> 2            allars           allars
#> 3               cer              cer
#> 4                cn               cn
#> 5             finaf            finaf
#> 6               geo              geo
#> 7              hero             hero
#> 8              hklj             hklj
#> 9                ic               ic
#> 10             iptc             iptc
#> 11             juho             juho
#> 12             jupo             jupo
#> 13            kassu            kassu
#> 14            kauno            kauno
#> 15         kaunokki         kaunokki
#> 16             keko             keko
#> 17             kito             kito
#> 18             kkaa             kkaa
#> 19             koko             koko
#> 20              kto              kto
#> 21             kulo             kulo
#> 22          lajisto          lajisto
#> 23        lapponica        lapponica
#> 24            lexvo            lexvo
#> 25            liiko            liiko
#> 26           maotao           maotao
#> 27             mesh             mesh
#> 28              mts              mts
#> 29             musa             musa
#> 30             muso             muso
#> 31             oiko             oiko
#> 32   okm-tieteenala   okm-tieteenala
#> 33              oma              oma
#> 34 ponduskategorier ponduskategorier
#> 35              pto              pto
#> 36             puho             puho
#> 37             seko             seko
#> 38              slm              slm
#> 39             soto             soto
#> 40             tero             tero
#> 41              tsr              tsr
#> 42               tt               tt
#> 43             ucum             ucum
#> 44             udcs             udcs
#> 45             valo             valo
#> 46              ykl              ykl
#> 47              ysa              ysa
#> 48              yse              yse
#> 49              yso              yso
#> 50         yso-aika         yso-aika
#> 51       yso-paikat       yso-paikat
#>                                                                  title
#> 1                             AFO - Luonnonvara- ja ympäristöontologia
#> 2                                  Allärs - Allmän tesaurus på svenska
#> 3                                    Tieteen termipankin CER-ontologia
#> 4                                             Suomalaiset yhteisönimet
#> 5                                    KANTO - Kansalliset toimijatiedot
#> 6                                            GEO - Geologian ontologia
#> 7                                         HERO - Heraldiikan ontologia
#> 8             HKLJ -  Helsingin kaupunginkirjaston luokitusjärjestelmä
#> 9                                                            Iconclass
#> 10                                                      IPTC NewsCodes
#> 11                                    JUHO - Julkishallinnon ontologia
#> 12                          JUPO - Julkisen hallinnon palveluontologia
#> 13                                Kassu - Kasvien suomenkieliset nimet
#> 14                             KAUNO - fiktiivisen aineiston ontologia
#> 15                      KAUNOKKI/BELLA - fiktiivisen aineiston sanasto
#> 16                    KEKO - Kestävän kehityksen kasvatuksen ontologia
#> 17                          KITO - Kirjallisuudentutkimuksen ontologia
#> 18                     Kokoelmien kuvailun aihealueet (Kokoelmakartta)
#> 19                                                      KOKO-ontologia
#> 20                                        KTO - Kielitieteen ontologia
#> 21                            KULO - Kulttuurien tutkimuksen ontologia
#> 22                           LAJISTO - Lajitietokeskuksen lajiluettelo
#> 23                                                           Lapponica
#> 24                                       Lexvo - ISO 639-3 kielikoodit
#> 25                                        LIIKO - Liikenteen ontologia
#> 26                MAO/TAO - Museoalan ja taideteollisuusalan ontologia
#> 27                                                      MeSH / FinMeSH
#> 28                                                    Metatietosanasto
#> 29                                   MUSA/CILLA - Musiikin asiasanasto
#> 30                                           MUSO - Musiikin ontologia
#> 31                                    OIKO - Oikeushallinnon ontologia
#> 32 Korkeakoulujen tutkimustiedonkeruussa käytettävä tieteenalaluokitus
#> 33                                        OMA - Mediataiteen ontologia
#> 34                                                   Pondus-kategoriat
#> 35                                         PTO - Paikkatieto-ontologia
#> 36                                 PUHO - Puolustushallinnon ontologia
#> 37                          SEKO - Suomalainen esityskokoonpanosanasto
#> 38                       SLM - Suomalainen lajityyppi- ja muotosanasto
#> 39                                        SOTO - Sotatieteen ontologia
#> 40                          TERO - Terveyden ja hyvinvoinnin ontologia
#> 41                                                       TSR-ontologia
#> 42                                                         Tietotermit
#> 43                        UCUM - The Unified Code for Units of Measure
#> 44                                                      Supistettu UDK
#> 45                                     VALO - Valokuvausalan ontologia
#> 46                      YKL - Yleisten kirjastojen luokitusjärjestelmä
#> 47                               YSA - Yleinen suomalainen asiasanasto
#> 48                                              YSOn käsite-ehdotukset
#> 49                                 YSO - Yleinen suomalainen ontologia
#> 50                                                            YSO-aika
#> 51                                                          YSO-paikat
```
