# ─── Makefile ────────────────────────────────────────────────────────────────
# Build both CV versions.
# Requires: latexmk + lualatex (or xelatex)
# Usage:
#   make         → build both
#   make es      → build Spanish only
#   make en      → build English only
#   make clean   → remove build artifacts

LATEX    = lualatex
FLAGS    = -interaction=nonstopmode -halt-on-error
LATEXMK  = latexmk -pdf -pdflatex="$(LATEX) $(FLAGS)"

.PHONY: all es en clean

all: es en

es:
	@echo "── Building Spanish CV ──"
	cp shared/miquelcv.cls es/miquelcv.cls
	cp shared/photo.jpg es/photo.jpg 2>/dev/null || true
	cd es && $(LATEXMK) cv_es.tex
	@echo "✓ es/cv_es.pdf done"

en:
	@echo "── Building English CV ──"
	cp shared/miquelcv.cls en/miquelcv.cls
	cp shared/photo.jpg en/photo.jpg 2>/dev/null || true
	cd en && $(LATEXMK) cv_en.tex
	@echo "✓ en/cv_en.pdf done"

clean:
	cd es && latexmk -C && rm -f miquelcv.cls photo.jpg
	cd en && latexmk -C && rm -f miquelcv.cls photo.jpg
