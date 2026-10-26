# Reproducibility

Package versions used to build the workbook, kept here for reference. This is documentation rather than an enforced lockfile: `renv` is not used, owing to the difficulty of supporting it on student machines.

Built with [Quarto](https://quarto.org) `1.10.18` and R `4.6.1`. The spatial tutorials use [QGIS](https://qgis.org) `3.44` LTR.

## R packages used in the teaching material

The packages called via `library()` in the `.qmd` files. A student running the code independently of the rendered workbook would need these, and all of them are installed by the `install.packages()` call in the Getting started chapter.

| Package | Version |
|---|---|
| descr | 1.1.9 |
| easystats | 0.7.6 |
| ggcorrplot | 0.3.0 |
| janitor | 2.2.1 |
| patchwork | 1.3.2 |
| tidyverse | 2.0.0 |

The diagnostic plots in the Statistical Analysis II chapter call `performance::check_model()`. `performance` (`0.17.1`) is installed as part of `easystats`.

## Additional packages required to build the site

Required only to render the workbook, not by students. `formatR` is invoked via the `#| tidy: True` knitr chunk option rather than a `library()` call.

| Package | Version | Used for |
|---|---|---|
| formatR | 1.14 | `#\| tidy: True` chunk option |
| knitr | 1.51 | rendering engine |
| rmarkdown | 2.31 | rendering engine |

## Rendering

Render with `quarto render --no-clean` (a plain `quarto render` deletes the archived year snapshots in `docs/`), then run `python3 _section_numbers.py` once to fix the section numbers and the landing page. `_publish.sh` does both. The script uses the Python standard library only.
