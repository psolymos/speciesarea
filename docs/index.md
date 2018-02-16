# Species-area relationship data sets

**Papers** in the literature contain one or more **studies**, within each study there are one or more **islands**. Studies have their own study-level variables, e.g. taxon, brad geographic location, isolation. Islands have their own measurements/estimates, such as number of species, area, distance to mainland, habitat diversity, etc. The following outline gives direction regarding how to enter the data from a paper.

## Data input

Data are enetered at the study level. When different taxa are counted on the same islands in the same paper, those count as separate studies (repeating much of the information).

* Create a directory in the `/inst/extdata/studies` folder with the name of the study, e.g. `<study_1>`. Use lower case letters (`a-z`), numbers (`0-9`) and underscores (`_`) only.
* Create a `<study_1>.csv` file with all the island level variables. See [xxx] for naming conventions and mandatory fields.
* Create a `<study_1>.yml` file with study specific matadata, see [xxx] for conventions and mandatory fields.
* Create a `.bib` entry in the `/inst/extdata/papers` folder (if the paper is not alrady there), use the publication label to link the study metadata to the source.

### New data

When adding new studies to the repo, please do the following:

1. Fork/clone the repo.
2. Add new data as described above.
3. Create a PR.

The repo owner will review the submission and update the repo.

### Reporting issues

When you find problems with existing data, please create an issue or provide a fix via PR.

## Auto-content

Data from the `/inst/extdata` folder is parsed to create the following:

1. R package with ready to use data.
2. Update html: this lists papers, studies, and data in a human readable and searchable format.
3. PDF version of the contents.


# How to restructure SAR db

4 csv files are not suitable for:

- entry level version control
- cannot integrate other APIs

## Structure

Like an R package with usual folders. Helper functions to find papers, studies,
and island level data, and manipulate these.
It also gives the opportunity to programmatically access the data (using curl or opencpu).

`/inst/extdata`: define metadata here,
`_publications.bib` contains `pid`s (publication IDs) for each reference along with
BibTeX entry with DOI where applicable (see below howto get BibTeX based
on DOI using the Crossref API). The root folder also has a `_studies.yml` file
that describes all the study level attributes (short name, descriptive name,
definition, measurement units, etc.).
The `_islands.yml` lists island level attributes the same way.

#### Studies

`/inst/extdata/studies`: a folder where each study has an `sid` that is composed
of `<pid>_<s>` where `<pid>` is publication ID, `<s>` is a descriptive
ID for a study within the publication (`sid` must be unique).
Each study is inside `/studies/<sid>` folder (called study folder).
Inside the folder, there are 2 files: `study.json` contains study level
attributes, `islands.json` has the island level attribute data.
Both files are prettified JSON (e.g. `prettify(toJSON(iris))` from jsonlite).

In `islands.json` the required fields are:

* island id `<i>` that must be unique within study (`<pid>_<s>_<i>` is the
  island ID (`iid`).
* richness
* area

In `islands.json` the optional fields can include habitat diversity, distance from mainland, height, age, etc. (field names and measurement units defined in the root).

In `study.json` the required fields are:

* `<s>` (which is kind of redundat due to the folder structure)
* `<pid>` which links to the publication
* archipelago type (oceanic, etc)
* taxonomic group (see if integrated with taxize?), probably multiple entries (e.g. as given in paper, vs. some collapsed ones)

Optional fields: location etc.

## Use cases

1. Use the R package and demonstrate usage (breakpoint regression, log-log etc sar)
2. Parser scripts to make jekyll based website where each study will have a page, search features will be built in (using UI), listing the publication source, study level info, and DT based (`y <- DT::datatable(x); DT::saveWidget(y, 'foo.html')`)
3. curl/opencpu based API: write support functions to get study and island level data, also to get all the data in a tidy format.

## Misc


Within each study folder, we have the following:
a file called `_meta` containing any


```
http://api.crossref.org/works/10.1111/ecog.03415/transform/application/x-bibtex
```

will return

```
@article{S_lymos_2018,
	doi = {10.1111/ecog.03415},
	url = {https://doi.org/10.1111%2Fecog.03415},
	year = 2018,
	month = {feb},
	publisher = {Wiley-Blackwell},
	author = {P{\'{e}}ter S{\'{o}}lymos and Steven M. Matsuoka and Diana Stralberg and Nicole K. S. Barker and Erin M. Bayne},
	title = {Phylogeny and species traits predict bird detectability},
	journal = {Ecography}
}
```

# Structure

```
inst
|--sardata
   |
   |--paper01
   |  |--study01
   |  |  |--sdata.json # study level attributes
   |  |  |--idata.json # island level data (replicate=1 if not stated)
   |  |
   |  |--study02
   |  |  |--sdata.json
   |  |  |--idata.json
   |  |
   |  |--citation.bib # paper level attributes (citation info)
   |
   |--paper02
   |  |--study01
   |  |  |--sdata.json
   |  |  |--idata.json # replicate=1 if only one idata-<n>.json file found
   |  |
   |  |--study02
   |  |  |--sdata.json
   |  |  |--idata-1.json # replicate 1
   |  |  |--idata-2.json # replicate 2
   |  |
   |  |--citation.bib # paper level attributes (citation info)
   |
   [...other papers/studies...]
   |
   |--study.json # study level variable definitions
   |--island.json # island level variable definitions
```

In jekyll:

* use `none` as permalink style (`/:categories/:title.html`) paper-study-replicate as title and `sardata` as category (there might be `blog` etc later), put files into `/sardata/_posts`
* use paper/study/replicate & study level variables as tags: searchable
