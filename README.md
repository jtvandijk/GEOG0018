# GEOG0018 Research Methods in Human Geography

This GitHub repository generates the GEOG0018 Research Methods in Human Geography workbook, which can be found at: https://jtvandijk.github.io/GEOG0018

## Building this workbook

The workbook is built with [Quarto](https://quarto.org) `1.10.18` and R `4.6.1`.

```
quarto render --no-clean
```

`--no-clean` is required: a plain `quarto render` clears `docs/` before rendering, which would delete the archived year snapshots stored under `docs/<year>/`.

This work is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
