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
