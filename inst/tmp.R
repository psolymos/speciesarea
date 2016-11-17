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

