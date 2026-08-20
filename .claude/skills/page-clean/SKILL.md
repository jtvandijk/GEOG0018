---
name: page-clean
description: Runs a hygiene/consistency cleanup pass on a single GEOG0018 .qmd chapter file — tidies prose, formats code chunks to match repo conventions, fixes genuine spelling mistakes, checks internal and external links, and flags heading/structure inconsistencies against the other week files. Use this whenever the user asks to "clean up", "tidy", "streamline" or "polish" a week's .qmd file, wants a consistency pass across chapters before a content rewrite, asks to check a chapter for typos or broken links, or wants the material "fresh" ahead of doing real content work. This is a hygiene pass only — it does NOT rewrite what a chapter teaches, restructure its pedagogy, or change explanations for style. If the user's request is actually about changing course content (what's taught, in what order, with what examples, or anything about a "start of session" live-demo section or the shape of the Homework task), that's a different, separate task — don't reach for this skill for that.
---

# Page clean

A chapter in this repo (any `.qmd` file, `00-index.qmd` through `05-spatial2.qmd`) can accumulate
small rough edges over time — inconsistent chunk-option formatting, trailing whitespace, a typo in a
code comment, a link that's quietly started 404ing. This skill is a repeatable pass to sand those down
*before* anyone does the harder work of touching actual teaching content. Keeping the two separate
matters: a hygiene diff should be easy to skim and trust ("nothing here changes what's taught"), and
mixing it with content changes makes that impossible to verify at a glance.

Read `CLAUDE.md` at the repo root first if you haven't already this session — it documents standing
conventions for this repo (see "Editing conventions" and the environment/reproducibility notes) and
should stay in sync with whatever this skill treats as "the convention."

## Before touching anything

Conventions in this repo were established by the existing `.qmd` files, not by general style
preference. Before "fixing" any formatting choice, confirm it's actually inconsistent by checking
against one or two other chapters — grep for the pattern rather than assuming. Confirmed conventions
(as of 2026-08-20, cross-checked across all seven `.qmd` files):

- Code fences open with `` ```{r} `` — no trailing space.
- Chunk options in order for a **teaching chunk** (`echo: True`, student-run code): `label` first,
  then `fig-cap` immediately after it *when the chunk produces a figure*, then `classes:
  styled-output`, `echo: True`, `eval: True`, `output: False` (only when the chunk's console output
  should be suppressed), `tidy: True`, and `filename: "R code"` last.
- Chunk options for a **display-only chunk** (`knitr::include_graphics(...)`, a screenshot the
  student looks at rather than runs): `label`, `echo: False`, `cache: True`, `fig-cap: "..."` —
  always quoted, always present (these chunks exist specifically to show a captioned image). No
  `classes`, no `filename`, no `tidy` — confirmed across all 15 instances in `04-spatial1.qmd` and
  `05-spatial2.qmd`.
- **Chunk-option string values must be single-quoted** (`filename: 'R code'`, and `fig-cap` when it
  needs quoting at all). As found (2026-08-20), every `.qmd` file here actually used double quotes
  (`filename: "R code"`) — the opposite of GEOG0030's convention. **Decided (2026-08-20): harmonise
  to GEOG0030's single-quote style rather than keep GEOG0018's own** — the user's explicit preference
  is cross-repo consistency over preserving whatever GEOG0018 happened to do already. Treat every
  double-quoted `#|` option value as a fix-on-sight during the pass, not something to leave alone as
  "the existing convention." This is a different layer from R string literals *inside* the code
  itself (`read_csv('data/...')`, `filter(str_detect(x, 'Camden'))`), which already use single quotes
  throughout and don't need touching.
- `fig-cap` is sometimes quoted and sometimes bare (`fig-cap: Quick histogram.` vs. `fig-cap: 'The
  London boroughs together with the crime dataset.'`) — roughly a 2:1 split toward quoted. Not
  confirmed which is "correct"; treat as a genuinely open inconsistency to flag rather than silently
  normalise in one direction. (This is orthogonal to the quote-*character* fix above — a bare
  `fig-cap` has no quotes to convert.)
- `#| echo: True` / `False` — **capitalised `True`/`False`, deliberately, not R's own `TRUE`/`FALSE`**.
  Never "correct" it.
- A short, lowercase, present-tense comment (`# load libraries`, `# inspect columns`) precedes
  teaching-code chunks. Display-only chunks don't get one.
- Only **one** knitr "tidy" mechanism is actually used in this repo: `` #| tidy: True `` (YAML-style
  chunk option), which needs the `formatR` package. GEOG0030 also has an inline `` {r
  tidy='styler'} `` mechanism (needing `styler`) — confirmed absent from every `.qmd` file here
  (`grep -rn "tidy='styler'" *.qmd` returns nothing). Don't assume GEOG0018 needs `styler` on this
  basis alone; `CLAUDE.md`'s environment notes currently list both packages as hidden dependencies
  and should be corrected to `formatR` only next time that section is touched.
- **Known recurring formatting bug, already spotted, safe to fix on sight**: 14 of the 15
  display-only chunks across `04-spatial1.qmd`/`05-spatial2.qmd` have a trailing space after `#|
  echo: False` (`#| echo: False ` — note the space before the line break); the 15th (the last chunk
  in `04-spatial1.qmd`) is clean. Strip the trailing space to match. Also check heading lines
  themselves for the same issue — `## Reading list ` (trailing space) appears in most week files,
  while `04-spatial1.qmd`'s `## Reading list` does not.

If you find a formatting pattern not covered above, check its prevalence across at least 2-3 other
chapters before treating it as a bug. A pattern that's genuinely everywhere is still worth flagging to
the user as a possible separate wider pass — just don't silently fix it repo-wide as a side effect of
cleaning one file.

## The pass

Work through these in order on the target file. Use `Read` for the file itself and `Grep`/`Bash`
(`grep`, `curl`) for cross-checks — don't guess at conventions or link validity.

### 1. Prose
Read the chapter's prose fully. Fix only genuine issues: misspellings, accidental word duplication,
grammar errors, obviously broken markdown (unclosed bold/italic, malformed links). Do **not**:
rephrase working sentences for style, swap in fancier vocabulary, restructure paragraphs, or change
the author's voice. If a sentence is awkward but comprehensible and not actually wrong, leave it —
that's content-pass territory, not hygiene. Apply the repo's standing prose-style rule from
`CLAUDE.md` (British English, no contractions, minimal em dashes) only when *fixing* a sentence you'd
already touch for another reason — this is not licence to rewrite existing prose wholesale.

### 2. Code chunks
For every chunk, check it against the confirmed conventions above: fence formatting, option order,
quoting, `True`/`False` capitalisation, trailing whitespace, comment presence/absence. Fix formatting
only — never change what the code actually does. If you spot an apparent *logic* bug (not a
formatting issue) while reading, don't fix it silently — flag it to the user instead. A typo'd
identifier or argument name that can be cross-checked against a sibling chunk/file (proving what the
"correct" version looks like) is safe to fix directly, the same way a straightforward misspelling in
prose is — there's no judgement call left once the intended form is demonstrably confirmed elsewhere.
Anything that changes what gets computed is a design question, not a typo — flag it, don't fix it.

**After running any bulk find/replace across a whole file, re-`git diff` and actually read it before
declaring the pass done** — don't trust that a mechanical substitution did only what you intended.
Avoid `sed`'s `\t`-in-brackets idiom for trailing whitespace on macOS/BSD `sed` (`[ \t]*$` is
unreliable there); use `sed -E 's/[[:blank:]]+$//'` instead.

### 3. Spelling
Check spelling in both prose and code comments — comments are easy to skip and are exactly where a
real typo turned up during the first scan of this repo (`# load eployment data` in
`02-statistics1.qmd`, should read `employment`). Fix only actual misspellings, not word choice.

### 4. Links
Check every link in the file:
- **External URLs**: verify with `curl -s -o /dev/null -L -w "%{http_code}" --max-time 15 "<url>"`.
  `200` is good. `403`/`417` on institutional/Microsoft-auth-gated URLs (Moodle, Kortext, Outlook
  booking links) are expected, not broken — don't flag those. Publisher/DOI links and sites that
  bot-wall `curl` (Cloudflare/Zendesk-style JS challenges) can also return `403` while being alive —
  for `doi.org` links specifically, confirm via
  `curl -s -o /dev/null -w "%{http_code}" "https://api.crossref.org/works/<doi>"` (just the
  `10.xxxx/...` part) instead of the publisher landing page. Anything that's a genuine `404`,
  timeout, or DNS failure is worth surfacing. If a site has restructured (a `404` on an otherwise
  live, legitimate site), check its own root/nav for a working equivalent before assuming the
  resource is gone.
- **Internal references**: `{{< var ... >}}`-style references resolve via `_variables.yml` — confirm
  the referenced value/file actually exists. `@fig-`/`@tbl-` cross-references need a matching
  `#| label: fig-...`/`tbl-...` somewhere in the project — check with
  `grep -rn "<label>" *.qmd` before renaming any label, since these can be cross-referenced from
  anywhere in the project, not just their own file.
- Report broken links found; fix straightforward cases (typo'd URL, wrong file reference) but ask
  before changing a link's actual target if it's ambiguous which target was intended.

### 5. Structural consistency
Compare the chapter's heading structure against 2-3 other chapters. The confirmed pattern for the
weekly chapters (`01-recap.qmd` through `05-spatial2.qmd`) is: title → `## Lecture slides` → `##
Reading list` → main content sections (`##`/`###`) → `## Homework task` → `## Before you leave`.
`00-index.qmd` (module overview) and `00-installation.qmd` (getting started) are structural
exceptions and don't follow this pattern — that's expected, not a bug. Note deviations from the
weekly pattern, but **flag them rather than restructuring** — reordering sections or renaming
headings changes how the chapter reads and is closer to a content decision than a hygiene one.
Surface what you found and let the user decide. This check is about heading *shape and order* only —
it says nothing about what should live inside "Homework task" or any other section; that's pedagogy,
out of scope for this skill entirely.

## Output

Don't silently rewrite the file and move on. After the pass:
1. Show a concise summary of what changed and why, grouped by the five checks above (skip empty
   categories).
2. Show the actual diff (`git diff <file>`) so it can be reviewed at a glance.
3. Wait for a go-ahead before staging/committing anything — this repo's standing policy (see
   `CLAUDE.md`) is review-before-merge for anything touching the live site, and a hygiene pass is no
   exception even though the risk is low.

## Running across all chapters

This skill operates on one file per invocation. To clean the whole set, run it once per `.qmd` file
(`00-index.qmd` through `05-spatial2.qmd`) — doing them one at a time keeps each review small and
means a bad call on one chapter doesn't get buried in a multi-file mega-diff. Commit after each
chapter is approved, not in one batch at the end, so a revert (if ever needed) stays scoped to one
file's changes.
