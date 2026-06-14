# AGENTS.md — Miquel CV (LaTeX)

## Repo is flattened, docs are stale

- `README.md` & `Makefile` describe `shared/`, `es/`, `en/` subdirectories.
- **Actual layout**: everything at root. `es/`, `en/`, `shared/` dirs do not exist.
- Template is in `cv-latex.tar.gz` (the original structure).

## Build

Makefile targets exist but *will fail* because they `cd` into missing dirs.

**Working commands** (compile directly):

```sh
lualatex cv_en.tex
lualatex cv_es.tex
```

Or use `latexmk`:

```sh
latexmk -pdf -pdflatex="lualatex -interaction=nonstopmode -halt-on-error" cv_en.tex
```

Requires `latexmk`, `lualatex`, and TeX Live with: `fontawesome5`, `paracol`, `tikz`, `geometry`, `xcolor`, `parskip`, `hyperref`, `graphicx`, `enumitem`, `microtype`, `ifthen`, `etoolbox`, `dashrule`, `calc`.

## Class file

`miquelcv.cls` — custom class defining colors, layout, and commands.

### `\cventry` signature

```tex
\cventry{date}{location}{dot-color}{title}{company}{description}
```

- `dotgreen` — current job
- `dotgray` — past job

### Photo

Makefile expects `shared/photo.jpg`. Actual file is `Miquel.png`. The `.tex` files reference `Miquel.png` directly.

## Entrypoints

| File | Purpose |
|---|---|
| `cv_en.tex` | English CV content |
| `cv_es.tex` | Spanish CV content |
| `miquelcv.cls` | Layout/color definitions |
| `Miquel.png` | Profile photo |

## State

- No commits yet (empty git history on `main`).
- MIT License.
- `.gitignore` has `*.pdf` **commented out** — PDFs will be tracked if committed.
- Clean artifacts: `make clean` also won't work without dirs. Manual: `rm *.aux *.log *.out *.synctex.gz *.fdb_latexmk *.fls` or `latexmk -C`.

## Style conventions

- `\cvsection{Title}` — blue uppercase section header with rule.
- `\skillrow{Level}{techs...}` — skill list.
- `\contactitem{label}{value}` — contact field.
- `cvlist` environment — bullet list (right column).
- Two-column layout via `paracol` with `\columnratio{0.63}`.
- Right column has shaded bg via TikZ overlay (`cvbgright`).
- Layout skill (tuning guide) at `.opencode/skills/cv-layout/SKILL.md`.
