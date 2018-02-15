library(jsonlite)

prettify(toJSON(list(a=list(b=1,c=2.2), z=list(x=FALSE, y="six"))))

prettify(toJSON(data.frame(iris)[1,]))

## paper: does not have meta, but follows BibTeX:
## - pub PID, DOI whenever possible (use DOI=UNDEFINED ???)

## metadata for studies
## study unique ID=PID:STUDY:REP
meta_study <- list(
    STUDY=list(
        name="STUDY",
        def="Identifier for a set of islands with measured/observed/inferred proprties within a defined taxonomic group.",
        required=TRUE,
        unit="character, alphanumeric only, e.g. study01, but not starting with number",
        values=NULL
    ),
    REP=list(
        name="REP",
        def="Identifier for replication within STUDY, i.e. when the set of istamds for a taxonomic group has be resurveyed.",
        required=TRUE,
        unit="numeric, integer",
        values=NULL
    ),
    PAPER=list(
        name="PAPER",
        def="Identifies the source of the data by linking to the publication identifier.",
        required=TRUE,
        unit="character",
        values=NULL
    ),
    TAXON_ORIG=list(
        name="TAXON_ORIG",
        def="Original definition of taxonomic group from source publication.",
        required=TRUE,
        unit="character",
        values=NULL
    ),
    TAXON=list(
        name="TAXON",
        def="Normalized taxonomic classification.",
        required=TRUE,
        unit="character",
        values=list(
            "bats"="bats, flying terrestrial mammals",
            "birds"="birds",
            "herptiles"="amphibians and reptiles",
            "mammals"="non-volant terrestrial mammals",
            "insects"="insects",
            "plants"="plants",
            "other"="other"
        )
    ),
    TYPE_ORIG=list(
        name="TYPE_ORIG",
        def="Original definition of island/archipelago type from source publication.",
        required=TRUE,
        unit="character",
        values=NULL
    ),
    TYPE=list(
        name="TYPE",
        def="Normalized island/archipelago type classification.",
        required=TRUE,
        unit="character",
        values=list(
            "landbridge"="near shore, on continental shelf",
            "oceanic"="off shore, on oceanic shelf",
            "nonmarine"="isolates in terrestrial enviroments, see MATRIX"
        )
    ),
    MATRIX=list(
        name="MATRIX",
        def="Description of the surrounding habitat matrix that is a barrier to dispersal or survival; from publication source.",
        required=TRUE,
        unit="character",
        values=NULL
    ),
    LOCATION=list(
        name="LOCATION",
        def="Archipelago description, name; from from publication source.",
        required=TRUE,
        unit="character",
        values=NULL
    ),
    ## standardize this as well?
    REGION=list(
        name="REGION",
        def="Normalized classification for continents and oceans.",
        required=TRUE,
        unit="character",
        values=list(
            "Afr"="Africa",
            "Asia"="Asia",
            "Austr"="Australia",
            "Eur"="Europe",
            "N_Am"="North America (Mecxico incl.)",
            "S_Am"="South America, Central America (w/o Mexico)",
            "Oc_Atl"="Atlantic Ocean",
            "Oc_Ind"="Indian Ocean",
            "Oc_Pac"="Pacific Ocean",
            "Oc_South"="Southern (Antarctic) Ocean",
            "Other"="Other (worldwide, or entire hemisphere)"
        )
    ),
    XMIN=list(
        name="XMIN",
        def="Minimum of longitude from bounding box.",
        required=TRUE,
        unit="numeric, decimal degrees WGS84, approximate",
        values=NULL
    ),
    XMAX=list(
        name="XMAX",
        def="Maximum of longitude from bounding box.",
        required=TRUE,
        unit="numeric, decimal degrees WGS84, approximate",
        values=NULL
    ),
    YMIN=list(
        name="YMIN",
        def="Minimum of latitude from bounding box.",
        required=TRUE,
        unit="numeric, decimal degrees WGS84, approximate",
        values=NULL
    ),
    YMAX=list(
        name="YMAX",
        def="Maximum of latitude from bounding box.",
        required=TRUE,
        unit="numeric, decimal degrees WGS84, approximate",
        values=NULL
    )
)

library(yaml)
library(bibtex)
setwd("~/repos/speciesarea/inst/")
s <- read.csv("olddata/SAR_paper.csv")
which(duplicated(s$PAPER))
rownames(s) <- s$PAPER
str(s)
tools::showNonASCIIfile("olddata/sardata.bib")
b <- read.bib("olddata/sardata.bib")
for (i in 1:length(b)) {
    id <- b[[i]]$study.id
    names(b)[i] <- b[[i]]$study.id
    #b[[i]]$key <- b[[i]]$study.id
    b[[i]]$study.id <- NULL
    b[[i]]$ref_id_SL <- i
    if (!is.na(s[z$key,"KAT_ref_no"]))
        b[[i]]$ref_id_KAT <- s[z$key,"KAT_ref_no"]
}
names(b)

if (z$key %in% rownames(s)) {
    if (!is.na(s[z$key,"Solymos_Lele_2012_GEB"]))
        z$study_id_SL <- which(names(b) == z$key)
}
z$study.id <- NULL

writeLines(paste(format(z, "Bibtex"), collapse = "\n\n"),
    paste0("extdata/papers/", z$key, ".bib"))

