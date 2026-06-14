%% miquelcv.cls — Custom CV class for Miquel Gómez Corral
%% Compatible with both Spanish and English versions
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{miquelcv}[2025/01/01 Miquel CV Class]

\LoadClass[10pt,a4paper]{article}

%% ─── PACKAGES ──────────────────────────────────────────────────────────────
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage[a4paper, top=1.2cm, bottom=1.2cm, left=1.2cm, right=1.2cm]{geometry}
\RequirePackage{xcolor}
\RequirePackage{tikz}
\RequirePackage{array}
\RequirePackage{tabularx}
\RequirePackage{multirow}
\RequirePackage{enumitem}
\RequirePackage{fontawesome5}
\RequirePackage{hyperref}
\RequirePackage{graphicx}
\RequirePackage{paracol}
\RequirePackage{parskip}
\RequirePackage{microtype}
\RequirePackage{lmodern}
\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{etoolbox}
\RequirePackage{dashrule}
\RequirePackage{eso-pic}

\usetikzlibrary{shapes.geometric, positioning}

%% ─── COLORS ─────────────────────────────────────────────────────────────────
\definecolor{cvblue}{RGB}{70, 130, 180}       % Section titles / headings
\definecolor{cvlightblue}{RGB}{194, 208, 227}       % Section titles / headings
\definecolor{cvlighterblue}{RGB}{216, 232, 250}       % Section titles / headings
\definecolor{cvdarkblue}{RGB}{31, 73, 125}    % Name
\definecolor{cvgray}{RGB}{100, 100, 100}      % Date/location text
\definecolor{cvlightgray}{RGB}{220, 220, 220} % Lines/rules
\definecolor{cvbgright}{RGB}{221, 234, 248}   % Right column background
\definecolor{dotgreen}{RGB}{123, 201, 122}      % Active/current job dot
\definecolor{dotlightgreen}{RGB}{176, 232, 162}      % Active/current job dot
\definecolor{dotgray}{RGB}{180, 180, 180}     % Past job dot

%% ─── HYPERREF SETUP ─────────────────────────────────────────────────────────
\hypersetup{
  colorlinks=true,
  urlcolor=cvblue,
  linkcolor=cvblue,
  pdfborder={0 0 0}
}

%% ─── NO PAGE NUMBERS ────────────────────────────────────────────────────────
\pagestyle{empty}
\setlength{\parindent}{0pt}
\setlength{\parskip}{0pt}

%% ─── FONTS ──────────────────────────────────────────────────────────────────
\renewcommand{\familydefault}{\sfdefault}

%% ─── SECTION STYLE ──────────────────────────────────────────────────────────
% Section title with blue text and full-width rule underneath
\newcommand{\cvsection}[1]{%
  \vspace{6pt}%
  {\color{cvblue}\large\bfseries\MakeUppercase{#1}}%
  \vspace{4pt}%
  {\color{cvlightgray}\hrule height 0.8pt}%
  \vspace{4pt}%
}

%% ─── TIMELINE ────────────────────────────────────────────────────────────────
\newcounter{cventrycount}
\newcounter{cvlineid}

\newcommand{\cvdot}[1][cvblue]{%
  \stepcounter{cventrycount}%
  \begin{tikzpicture}[baseline={([yshift=-3.0pt] cvdot-\thecvlineid-\thecventrycount.center)}, remember picture]
    \ifstrequal{#1}{dotgreen}{%
      \node[circle, fill=dotlightgreen, draw=dotgreen, line width=1.2pt, inner sep=0pt, minimum size=10pt] (cvdot-\thecvlineid-\thecventrycount) at (0,0) {};
    }{%
      \node[circle, fill=cvlighterblue, draw=cvlightblue, line width=1.2pt, inner sep=0pt, minimum size=10pt] (cvdot-\thecvlineid-\thecventrycount) at (0,0) {};
    }%
  \end{tikzpicture}%
}

\newcommand{\newtimeline}{%
  \setcounter{cventrycount}{0}%
  \stepcounter{cvlineid}%
}

\newcommand{\drawtimelinelines@draw}[3]{%
  \AddToShipoutPictureBG{%
    \begin{tikzpicture}[remember picture, overlay]
      \draw[cvlightblue, line width=1.5pt] (cvdot-#1-1.center) -- (cvdot-#1-#2.center);
    \end{tikzpicture}%
  }%
}

\newcommand{\drawtimelinelines}[1][cvlightgray]{%
  \ifnum\value{cventrycount}>1
    \begingroup
      \edef\temp{%
        \noexpand\drawtimelinelines@draw{\thecvlineid}{\thecventrycount}{#1}%
      }%
      \temp
    \endgroup
  \fi
  \setcounter{cventrycount}{0}%
}

%% ─── EXPERIENCE / EDUCATION ENTRY ───────────────────────────────────────────
% Usage: \cventry{date}{location}{dot-color}{title}{company}{description}
\newcommand{\cventry}[6]{%
\vspace{4pt}
  \begin{tabular}[t]{p{3.1cm} c p{8.5cm}}
    {\phantom{.}\small\color{cvgray}#2 \newline \phantom{.}\textit{\small #1}} &
    \cvdot[#3] &
    {\small\textbf{#4}%
    \ifthenelse{\equal{#5}{}}{}{\textit{ #5}}%
    \newline {\footnotesize #6}}
  \end{tabular}%
  \vspace{0pt}%
}

%% ─── CONTACT ITEM ───────────────────────────────────────────────────────────
\newcommand{\contactitem}[2]{%
  {\small\textbf{#1}}\newline
  {\small #2}\par\vspace{4pt}%
}

%% ─── RIGHT SECTION TITLE ────────────────────────────────────────────────────
\newcommand{\rightsection}[1]{%
  \vspace{16pt}%
  {\color{cvblue}\normalsize\bfseries\MakeUppercase{#1}}%
  \vspace{2pt}%
  {\color{cvlightgray}\hrule height 0.6pt}%
  \vspace{4pt}%
}

%% ─── BULLET LIST (right column) ─────────────────────────────────────────────
\newenvironment{cvlist}{%
  \begin{itemize}[leftmargin=1em, itemsep=1pt, topsep=0pt, parsep=0pt]
  \small
}{%
  \end{itemize}
}

%% ─── SKILLS ROW ─────────────────────────────────────────────────────────────
% \skillrow{Level}{techs...}
\newcommand{\skillrow}[2]{%
  \textbf{\small #1:} {\small #2}\par\vspace{2pt}%
}
