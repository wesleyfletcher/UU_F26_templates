# Dataset Catalog

Generated on August 26, 2026.

This catalog is based on:

- filenames and file structure in this directory
- spot-checks of rows/columns and encodings
- local companion docs/codebooks
- targeted web searches for likely upstream dataset pages

Cleaning status is intentionally conservative:

- `no`: looks like a raw or near-raw download/export
- `mixed`: mostly upstream data, but converted, lightly renamed, trimmed, or reformatted
- `yes`: clearly classroom-prepped, subsetted, aggregated, or feature-engineered
- `unclear`: provenance/source is not pinned down confidently enough to say more

Confidence is about provenance, not data quality.

## Main Catalog

| File | Shape | Likely source family | Probable upstream source | Cleaned? | Confidence | Notes |
| --- | --- | --- | --- | --- | --- | --- |
| `2022 election cycle fundraising.csv` | 537 x 9 | Kaggle / campaign-finance classroom dataset | Likely the #MakeoverMonday / Kaggle version of 2022 congressional fundraising data built from FEC/OpenSecrets context: [VizWiz prompt](https://www.vizwiz.com/2022/11/mm2022-w44.html) | `yes` | medium | Small summary table by member, not raw FEC filings. |
| `CardiacPatientData.csv` | 5,906 x 20 | Academic clinical dataset | Likely [Cardiac Patient Bed Head Ticket Dataset](https://explore.openaire.eu/search/dataset?pid=10.5281%2Fzenodo.7603771) | `mixed` | medium | Columns match the published cardiac variables very closely; local file looks like a flat CSV export of the research data. |
| `ForeignGifts_edu.csv` | 28,221 x 10 | U.S. government open data | U.S. Department of Education Section 117 / [Foreign Gifts and Contracts Report](https://catalog.data.gov/dataset/foreign-gifts-and-contracts-report) | `no` | high | Columns match the DOE spreadsheet export almost exactly. |
| `SIPRI Military Expenditure Database.csv` | 5,882 x 7 | SIPRI official data | [SIPRI Military Expenditure Database](https://www.sipri.org/databases/milex) | `mixed` | high | Looks like a tidy/exported slice with an added index column. |
| `USA_cars_datasets.csv` | 2,499 x 13 | Kaggle | [US Cars Dataset](https://www.kaggle.com/datasets/doaaalsenani/usa-cers-dataset/data) | `no` | high | Exact filename match. |
| `airbnb_NYC.csv` | 30,478 x 13 | Inside Airbnb classroom/community extract | Core upstream source is [Inside Airbnb](https://beta.insideairbnb.com/explore/) | `mixed` | medium | Already reduced to a teaching-friendly 13-column NYC listing table; not a full raw Inside Airbnb dump. |
| `airbnb_hw.csv` | 30,478 x 13 | Duplicate classroom copy | Same likely upstream as `airbnb_NYC.csv`: [Inside Airbnb](https://beta.insideairbnb.com/explore/) | `yes` | high | Same shape/columns as `airbnb_NYC.csv`; likely the homework working copy. |
| `ames_prices.csv` | 2,930 x 82 | Ames Housing teaching dataset | Dean De Cock's Ames Housing data: [Ames paper reference](https://lab.cs307.org/housing/) and common [Kaggle mirror](https://www.kaggle.com/datasets/marcopale/housing) | `yes` | high | Local codebook matches Ames; `area`/`price` naming suggests class-side renaming/cleanup. |
| `brazil_default.csv` | 50,000 x 54 | Brazilian credit/default dataset | Upstream page not pinned down confidently; local `brazil_codebook.XLS` strongly suggests a Brazilian credit application/default dataset | `mixed` | low | Kept in catalog because the codebook is detailed, but I could not verify a clean public landing page from the web. |
| `car_prices.csv` | 92 x 20 | Local/classroom derivative | Likely derived from local Charlottesville Craigslist car data rather than a public canonical dataset | `yes` | medium | Enriched version of the local Craigslist car scrape with extra parsed fields and free text. |
| `cars_env.csv` | 524 x 13 | EPA model input / policy modeling | EPA CVCM / OMEGA vehicle-sheet format documented in [Consumer Vehicle Choice Model documentation](https://nepis.epa.gov/Exe/ZyPURL.cgi?Dockey=P100EZ37.TXT) | `mixed` | medium | `predicted mpg` and `baseline mpg/sales` suggest model-ready input rather than raw market data. |
| `cars_hw.csv` | 976 x 12 | Used-car classroom dataset | Likely a Kaggle/community used-car dataset, but no exact upstream page confirmed | `yes` | low | Filename and structure strongly suggest a homework-prepped file. |
| `college_completion.csv` | 3,798 x 63 | Kaggle | [College Completion Dataset](https://www.kaggle.com/datasets/thedevastator/boost-student-success-with-college-completion-da) | `no` | high | Kaggle page says the data draw from NCES IPEDS and the Voluntary System of Accountability. |
| `corporate_ratings.csv` | 2,029 x 31 | Kaggle | [Corporate Credit Rating](https://www.kaggle.com/datasets/agewerc/corporate-credit-rating) | `no` | high | Exact schema match. |
| `craigslist_cville_cars.csv` | 46 x 7 | Local scrape | Charlottesville Craigslist listings, locally scraped | `yes` | high | Not a third-party packaged dataset; this looks like your own small scrape/export. |
| `crimebystatecombinedwithunemployment.csv` | 1,989 x 13 | Kaggle | [Crime rate and unemployment rate by state](https://www.kaggle.com/datasets/lydiavasil/crime-rate-and-unemployment-rate-by-state) | `no` | high | Exact filename match. |
| `cville_weather.csv` | 411 x 13 | NOAA climate data | NOAA Climate Data Online / Daily Summaries, Charlottesville area: [CDO Daily Summaries location details](https://www.ncdc.noaa.gov/cdo-web/datasets/GHCND/locations/ZIP%3A22902/detail) | `no` | high | Local file uses NOAA station-style columns and station `US1VACRC002`. |
| `diabetes-dataset.csv` | 2,000 x 9 | Kaggle | Likely [diadata](https://www.kaggle.com/datasets/bugrahanayd/diadata) or a very similar Kaggle Pima-style repost | `no` | medium | Exact filename appears on Kaggle; not the original 768-row UCI Pima file. |
| `divorce/divorce_data.csv` | 170 x 55 | UCI | [UCI Divorce Predictors data set](https://archive.ics.uci.edu/dataset/539/divorce%26) | `no` | high | Exact row count and 54 predictors + target. |
| `drilling_rigs.csv` | 623 x 10 | U.S. government energy data | EIA monthly drilling/rig statistics family, likely from the [Monthly Energy Review](https://www.eia.gov/totalenergy/data/monthly/) or a related EIA table | `no` | medium | Structure looks like a straight EIA table export. |
| `electricity_data_validation.csv` | 108 x 14 | EIA API extract | EIA electricity retail sales metadata/API: [EIA open data docs](https://www.eia.gov/opendata/documentation.php) | `yes` | high | Small Virginia-only recent-period validation slice, clearly not the full national dataset. |
| `energy.csv` | 632 x 10 | EIA spreadsheet export | [Monthly Energy Review](https://www.eia.gov/totalenergy/data/monthly/) | `no` | high | The first rows are title/release-date rows from an EIA spreadsheet export. |
| `heart_failure_clinical_records_dataset.csv` | 299 x 13 | UCI | [UCI Heart Failure Clinical Records](https://archive-beta.ics.uci.edu/dataset/519/heart%2Bfailure%2Bclinical%2Brecords/files) | `no` | high | Exact filename match. |
| `iowa.csv` | 159,904 x 14 | Iowa government open data | [Iowa Liquor Sales](https://dev.socrata.com/foundry/data.iowa.gov/m3tr-qhgy) | `mixed` | high | Column names match the official dataset, but this file is a classroom-sized subset/export rather than the full live table. |
| `justice_data.parquet` | 22,986 x 709 | Virginia official pretrial data | [Virginia Pre-Trial Data Project](https://vscc.virginia.gov/virginiapretrialdataproject.asp) | `mixed` | high | Very likely the wide official public dataset converted from CSV/XLS to Parquet for easier work. |
| `land_mines.csv` | 338 x 4 | UCI | [UCI Land Mines](https://archive-beta.ics.uci.edu/dataset/763/land%2Bmines-1) | `yes` | high | Row count matches UCI, but headers have been made friendlier (`voltage`, `height`, `soil`, `mine_type`). |
| `mammogram.csv` | 89,835 x 2 | OpenIntro teaching dataset | OpenIntro-style teaching distribution; see local companion doc [`mammogram.txt`](mammogram.txt) | `yes` | high | Highly distilled two-column teaching version, not a raw clinical file. |
| `metabric.csv` | 1,343 x 14 | Kaggle / derived METABRIC subset | Likely based on [Breast Cancer (METABRIC)](https://www.kaggle.com/datasets/gunesevitan/breast-cancer-metabric) | `yes` | medium | Much smaller and tidier than the common full Kaggle METABRIC tables, so this looks class-prepared. |
| `mn_police_use_of_force.csv` | 12,925 x 13 | OpenIntro from Minneapolis open data | [OpenIntro dataset page](https://openintrostat.github.io/openintro/reference/mn_police_use_of_force.html); original city source: [Minneapolis use-of-force data](https://www.ci.minneapolis.mn.us/government/government-data/datasource/use-of-force-dashboard/) | `mixed` | high | Looks like the OpenIntro teaching distribution of Minneapolis public data. |
| `mnist/Z_train.parquet`, `mnist/Z_test.parquet`, `mnist/y_train.parquet`, `mnist/y_test.parquet` | 60,000/10,000 image rows + labels | Official benchmark dataset, locally converted | [Official MNIST page](https://yann.lecun.org/exdb/mnist/index.html) | `yes` | high | Raw MNIST image/label split converted into Parquet matrices and label vectors. |
| `nhanes_data_17_18.csv` | 8,366 x 198 | NHANES | CDC NHANES 2017-2018: [data portal](https://wwwn.cdc.gov/nchs/nhanes/search/DataPage.aspx?Cycle=2017-2018) | `yes` | high | This is a merged, cleaned, human-readable NHANES extract, not a raw single XPT file. |
| `nhanes_meta_17_18.csv` | 197 x 18 | NHANES metadata | CDC NHANES 2017-2018: [questionnaires/datasets page](https://wwwn.cdc.gov/nchs/nhanes/continuousnhanes/default.aspx?BeginYear=2017) | `yes` | high | Custom variable dictionary/metadata table layered on top of NHANES docs and recodes. |
| `patents.csv` | 161 x 7 | WIPO-derived custom extract | [WIPO IP Statistics Data Center](https://www.wipo.int/en/web/ip-statistics/about) | `yes` | medium | Small country-by-country 2020-2021 extract; clearly a hand-selected summary rather than a raw WIPO bulk table. |
| `pierce_county_house_sales.csv` | 16,814 x 19 | OpenIntro/usdata from county open data | [OpenIntro/usdata page](https://openintrostat.github.io/usdata/reference/pierce_county_house_sales.html) | `mixed` | high | Distributed as a teaching dataset, sourced from Pierce County, Washington. |
| `pretrial_data.csv` | 22,986 x 17 | Derived from Virginia pretrial data | [Virginia Pre-Trial Data Project](https://vscc.virginia.gov/virginiapretrialdataproject.asp) | `yes` | high | Clearly a feature-selected/engineered modeling subset of `justice_data.parquet`. |
| `sharks.csv` | 6,462 x 257 | Shark attack registry / likely community mirror | Likely derived from the [Global Shark Attack File](https://www.sharks.org/global-shark-attack-file) | `no` | medium | Messy wide structure with many empty columns suggests a raw-ish export, not a cleaned teaching table. |
| `tech_stocks.csv` | 32,224 x 10 | Market API export / classroom aggregation | Schema matches Alpha Vantage [TIME_SERIES_DAILY_ADJUSTED](https://www.alphavantage.co/documentation/) | `mixed` | medium | Columns like `close_adjusted` and `split_coefficient` strongly suggest an Alpha Vantage-style export combined across symbols. |
| `time_use.csv` | 67 x 7 | ATUS/BLS-derived summary | Likely derived from the American Time Use Survey / [BLS ATUS releases](https://www.bls.gov/news.release/archives/atus_07222021.htm) | `yes` | medium | Already aggregated to age-level summary measures; not raw diary records. |
| `tuna.csv` | 10,032 x 1 | Biosequence classroom data | Upstream not confidently identified | `mixed` | low | One-column nucleotide sequence table; almost certainly preprocessed for class use, but I could not pin a canonical public source. |
| `us_power_consumption.csv` | 75 x 13 | EIA-derived annual energy summary | EIA energy data family / likely [Monthly Energy Review](https://www.eia.gov/totalenergy/data/monthly/) | `yes` | medium | Tidy annual totals table; much more processed than the raw `energy.csv` export. |
| `wages_hw.csv` | 731 x 6 | Kaggle-derived salary homework file | Likely derived from a Glassdoor salary dataset such as [Data Science Job Posting on Glassdoor](https://www.kaggle.com/datasets/rashikrahmanpritom/data-science-job-posting-on-glassdoor) | `yes` | medium | Minimal modeling subset with `avg_salary`, `job_state`, and a few employer descriptors. |
| `weapons-trade-register.csv` | CSV with SIPRI preamble + transfer rows | SIPRI official data | [SIPRI Arms Transfers Database](https://www.sipri.org/databases/armstransfers) / [register export interface](https://armstransfers.sipri.org/ArmsTransfer/TransferRegister) | `no` | high | Straight export with explanatory lines above the header; definitely near-raw. |
| `zoo.csv` | 101 x 18 | UCI | [UCI Zoo](https://archive-beta.ics.uci.edu/dataset/111/zoo) | `no` | high | Classic UCI dataset with standard 101-row shape. |

## Companion Docs And Related Files

These are not primary datasets themselves, but they explain or support the tabular files above.

| File | Relates to | Notes |
| --- | --- | --- |
| `ames_codebook.txt` | `ames_prices.csv` | Local codebook for Ames Housing; confirms provenance. |
| `brazil_codebook.XLS` | `brazil_default.csv` | Local variable dictionary for the Brazilian credit/default file. |
| `heart_failure_readme.txt` | `heart_failure_clinical_records_dataset.csv` | Local UCI-style README with provenance and citation info. |
| `VirginiaPretrialData2017Codebook.pdf` | `justice_data.parquet`, `pretrial_data.csv` | Official Virginia codebook for the October 2017 cohort. |
| `mammogram.txt` | `mammogram.csv` | Local dataset description and original study citation. |
| `use_of_force.txt` | `mn_police_use_of_force.csv` | Local dataset description matching OpenIntro wording. |
| `divorce/about.txt` | `divorce/divorce_data.csv` | Local description of the divorce predictors data. |
| `divorce/questions.txt` | `divorce/divorce_data.csv` | Human-readable questionnaire text for Q1-Q54. |
| `divorce/reference.tsv` | `divorce/divorce_data.csv` | Variable-to-question lookup table. |
| `mnist/example_solution.ipynb` | MNIST Parquet files | Teaching notebook/example solution using the local MNIST files. |
| `cpr.txt` | no matching CSV in this directory | Dataset description for a CPR class example; the tabular file itself is not present here. |
| `Effectiveness of Bystander Cardiopulmonary Resuscitation and Survival Following Out-of-Hospital Cardiac Arrest.pdf` | CPR/cardiac arrest teaching material | Source article or background reading; not a tabular dataset. |

## Short Takeaways

- `UCI` shows up clearly in `heart_failure_clinical_records_dataset.csv`, `zoo.csv`, `divorce/divorce_data.csv`, and `land_mines.csv`.
- `NHANES` is clearly represented by `nhanes_data_17_18.csv` and `nhanes_meta_17_18.csv`, and both are already classroom-cleaned/merged.
- `Kaggle/community mirrors` show up heavily in `USA_cars_datasets.csv`, `corporate_ratings.csv`, `college_completion.csv`, `crimebystatecombinedwithunemployment.csv`, and likely several of the homework-prepped derivatives.
- `Official/public-sector data` is a large share of the directory too: DOE Section 117, NOAA weather, Iowa liquor sales, Virginia pretrial, EIA energy/electricity/rig data, SIPRI, and WIPO.
- The files most clearly cleaned by you or for class are `airbnb_hw.csv`, `ames_prices.csv`, `car_prices.csv`, `craigslist_cville_cars.csv`, `electricity_data_validation.csv`, `pretrial_data.csv`, the MNIST Parquet set, both NHANES CSVs, `patents.csv`, `us_power_consumption.csv`, and `wages_hw.csv`.
- The shakiest provenance calls are `brazil_default.csv`, `cars_hw.csv`, and `tuna.csv`; those are the ones I would label as inferred rather than fully verified if someone asks.
