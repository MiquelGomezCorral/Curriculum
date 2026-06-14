# CV — Miquel Gómez Corral

LaTeX source for my CV in **Spanish** (`es/`) and **English** (`en/`).

## Repo Structure

```
cv-latex/
├── shared/
│   ├── miquelcv.cls   ← Custom class (colors, layout, commands)
│   └── photo.jpg      ← Profile photo (place yours here)
├── es/
│   └── cv_es.tex      ← Spanish version
├── en/
│   └── cv_en.tex      ← English version
├── Makefile
├── .gitignore
└── README.md
```

## Requirements

- A TeX distribution with **LuaLaTeX** (TeX Live / MiKTeX)
- Packages: `fontawesome5`, `paracol`, `tikz`, `geometry`, `xcolor`, `parskip`, `hyperref`, `graphicx`, `enumitem`, `microtype`, `ifthen`, `etoolbox`, `dashrule`, `calc`

> All packages are included in a standard **TeX Live** full install.

## Build

```bash
# Both languages
make

# Single language
make es
make en

# Clean build artifacts
make clean
```

PDFs are output to `es/cv_es.pdf` and `en/cv_en.pdf`.

## Photo

Place your profile photo as `shared/photo.jpg`.  
The Makefile copies it automatically into each language folder before building.

## Customisation

- **Colors / layout** → `shared/miquelcv.cls`
- **Content** → `es/cv_es.tex` or `en/cv_en.tex`
- Each `\cventry` call follows the signature:
  ```latex
  \cventry{date}{location}{dot-color}{title}{company}{description}
  ```
  Use `dotgreen` for current job, `dotgray` for past ones.
