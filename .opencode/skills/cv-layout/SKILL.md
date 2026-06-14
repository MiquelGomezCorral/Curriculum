# CV Layout Guide — Miquel Gómez Corral

A complete reference for understanding and tuning every part of the LaTeX layout.

---

## Big Picture

The CV is built on **three nested systems** that must stay in sync:

```
Page margins  →  paracol columns  →  tabular inside each entry
```

If you change one, the others may need adjusting. This guide covers each layer.

---

## 1. Page Margins (`miquelcv.cls`)

```latex
\RequirePackage[a4paper, top=1.2cm, bottom=1.2cm, left=1.2cm, right=1.2cm]{geometry}
```

This defines the **usable area** of the page. Everything else fits inside it.

| Parameter | Effect |
|-----------|--------|
| `top` / `bottom` | Vertical breathing room. Reduce if content overflows to a second page. |
| `left` / `right` | Horizontal space. Keep symmetric unless you want a binding margin. |

**Usable width formula:**
```
usable_width = 21cm (A4) - left - right = 21 - 1.2 - 1.2 = 18.6cm
```
This number feeds into everything below. **Write it down when you change margins.**

---

## 2. Two-Column Split (`paracol`)

```latex
\columnratio{0.63}
\begin{paracol}{2}
  % left column content
\switchcolumn
  % right column content
\end{paracol}
```

`\columnratio{0.63}` means:
- Left column = 63% of usable width → `18.6 × 0.63 ≈ 11.7cm`
- Right column = 37% of usable width → `18.6 × 0.37 ≈ 6.9cm`

### Column gap

```latex
\setlength{\columnsep}{0.8cm}
```

This is the **gutter** between left and right columns. It comes out of the usable width, so the actual column widths shrink slightly:
```
real_left  = usable_width × ratio  - columnsep/2
real_right = usable_width × (1-ratio) - columnsep/2
```

> **Rule:** if text in the left column is getting clipped or wrapping too early, first check `columnsep` — it may be eating more space than you think.

---

## 3. Right Column Background (TikZ)

```latex
\begin{tikzpicture}[remember picture, overlay]
  \fill[cvbgright] (current page.north east)
    rectangle ([xshift=-0.37\paperwidth] current page.south east);
\end{tikzpicture}
```

This draws a **full-height shaded rectangle** anchored to the right edge of the physical page — it ignores margins entirely and works in absolute page coordinates.

The `xshift` controls how far left the shading extends from the right edge:
```
xshift = -(1 - columnratio) × paperwidth
       = -(1 - 0.63) × 21cm
       = -0.37 × 21cm ≈ -7.77cm from the right edge
```

### ⚠️ Critical sync rule

The TikZ rectangle uses **full paperwidth** (`\paperwidth = 21cm`), but `paracol` uses **usable width** (margins excluded). They are **not the same coordinate system**.

So the formula to keep them visually aligned is:

```
xshift_fraction = (right_margin + right_column_usable_width) / paperwidth
```

Example with default settings:
```
= (1.2cm + 6.9cm) / 21cm ≈ 0.386 → use -0.387\paperwidth
```

If the shading doesn't line up with the column boundary, this is why. Tweak the `xshift` value until the edge of the fill aligns with the column separator visually.

---

## 4. Entry Layout (`\cventry` tabular)

```latex
\begin{tabular}{p{3.1cm} c p{8.5cm}}
  date/location  &  dot  &  title + description
\end{tabular}
```

Three columns inside every experience/education entry:

| Column | Width | Contains |
|--------|-------|----------|
| `p{3.1cm}` | fixed | Date + location (left-aligned, small text) |
| `c` | auto (~0.4cm) | The `\cvdot` circle |
| `p{8.5cm}` | fixed | Bold title, company in italic, description text |

### Sizing the description column

The description column must not exceed the available left column width:
```
max_description = real_left - date_col - dot_col - inter-column-tabular-padding
                ≈ 11.7cm    - 3.1cm   - 0.4cm   - ~0.4cm
                ≈ 7.8cm
```

Use `8.5cm` as a starting point; if text overflows sideways, reduce it to `7.5cm` or less.

> If you change page margins or `\columnratio`, **always recalculate this value.**

---

## 5. Timeline Dots (`\cvdot`)

```latex
\newcommand{\cvdot}[1][dotgray]{%
  \tikz[baseline=-0.5ex]\draw[fill=#1, draw=#1] (0,0) circle (4pt);%
}
```

- Default color: `dotgray` (past/inactive)
- Active job: pass `dotgreen` as argument → `\cvdot[dotgreen]`
- Size: `4pt` radius. Change to `3pt` for smaller, `5pt` for larger.
- `baseline=-0.5ex` vertically centres the dot with the first line of text. If it looks high or low, adjust this value.

### Colors defined in `miquelcv.cls`

```latex
\definecolor{dotgreen}{RGB}{92, 184, 92}
\definecolor{dotgray}{RGB}{180, 180, 180}
```

Change the RGB values to match any brand color.

---

## 6. Section Titles

```latex
\newcommand{\cvsection}[1]{%
  \vspace{6pt}%
  {\color{cvblue}\large\bfseries\MakeUppercase{#1}}%
  \vspace{2pt}%
  {\color{cvlightgray}\hrule height 0.8pt}%
  \vspace{4pt}%
}
```

- `\vspace{6pt}` before: space above the section title. Increase to push sections further apart.
- `\large\bfseries`: font size + bold. Change `\large` to `\normalsize` or `\Large` to taste.
- `\hrule height 0.8pt`: the horizontal rule. Change `height` for thicker/thinner line.
- `\vspace{4pt}` after: space between rule and first entry below.

Right column uses `\rightsection` — same idea but slightly smaller (`\normalsize` instead of `\large`).

---

## 7. Vertical Spacing

LaTeX spacing is cumulative — small values compound across many entries.

| Command | Where | What it controls |
|---------|-------|-----------------|
| `\vspace{Xpt}` | `.tex` files | Manual vertical gap anywhere |
| `itemsep=1pt` | `cvlist` env | Gap between bullet items |
| `topsep=0pt` | `cvlist` env | Space before/after the list |
| `\vspace{3pt}` after `\cventry` | `miquelcv.cls` | Gap between experience entries |
| `\parskip` | `miquelcv.cls` | Default paragraph spacing (set to 2pt) |

If the CV overflows to a second page:
1. First try reducing `\vspace` values inside `\cvsection` (the `6pt` before and `4pt` after).
2. Then reduce the `3pt` after `\cventry`.
3. Last resort: shrink page margins by `0.1–0.2cm`.

---

## 8. Photo (right column)

```latex
\begin{tikzpicture}
  \clip (0,0) circle (1.5cm);
  \node at (0,0) {\includegraphics[width=3cm]{photo}};
\end{tikzpicture}
```

- `circle (1.5cm)`: the clip radius. The photo is cropped to this circle.
- `width=3cm` on `\includegraphics`: the actual image width loaded. Should be `2 × radius` to fill the circle exactly.
- File must be named `Miquel.png` and be in the same folder as the `.tex` when compiling.

---

## 9. Global Color Palette

All colors live in `miquelcv.cls`. Change them once, they update everywhere.

```latex
\definecolor{cvblue}{RGB}{70, 130, 180}       % Section titles
\definecolor{cvdarkblue}{RGB}{31, 73, 125}    % Name (header)
\definecolor{cvgray}{RGB}{100, 100, 100}      % Date/location text
\definecolor{cvlightgray}{RGB}{220, 220, 220} % Horizontal rules
\definecolor{cvbgright}{RGB}{240, 245, 252}   % Right column background
\definecolor{dotgreen}{RGB}{92, 184, 92}      % Current job dot
\definecolor{dotgray}{RGB}{180, 180, 180}     % Past job dot
```

---

## 10. Quick Sync Checklist

When you change **anything structural**, verify these in order:

1. **Margins changed?** → Recalculate `usable_width`.
2. **`\columnratio` changed?** → Update the TikZ `xshift` fraction AND the tabular `p{8.5cm}`.
3. **`\columnsep` changed?** → Recalculate real column widths, then update `p{8.5cm}`.
4. **Content grew?** → Check if it overflows to page 2 and reduce vertical spacing.
5. **TikZ fill misaligned?** → Fine-tune `xshift` in small steps (`±0.01\paperwidth`).

---

## Cheat Sheet — Default Values

```
A4 paperwidth          = 21cm
Page margins           = 1.2cm all sides
Usable width           = 18.6cm
Column ratio           = 0.63 / 0.37
Left column width      ≈ 11.7cm
Right column width     ≈ 6.9cm
Column gap             = 0.8cm
TikZ xshift            = -0.387\paperwidth
Date column            = 3.1cm
Description column     = 8.5cm
Dot radius             = 4pt
Photo clip radius      = 1.5cm
