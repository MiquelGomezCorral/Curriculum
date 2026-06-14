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

\usetikzlibrary{shapes.geometric, positioning}

%% ─── COLORS ─────────────────────────────────────────────────────────────────
\definecolor{cvblue}{RGB}{70, 130, 180}       % Section titles / headings
\definecolor{cvdarkblue}{RGB}{31, 73, 125}    % Name
\definecolor{cvgray}{RGB}{100, 100, 100}      % Date/location text
\definecolor{cvlightgray}{RGB}{220, 220, 220} % Lines/rules
\definecolor{cvbgright}{RGB}{240, 245, 252}   % Right column background
\definecolor{dotgreen}{RGB}{92, 184, 92}      % Active/current job dot
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
\setlength{\parskip}{2pt}

%% ─── FONTS ──────────────────────────────────────────────────────────────────
\renewcommand{\familydefault}{\sfdefault}

%% ─── SECTION STYLE ──────────────────────────────────────────────────────────
% Section title with blue text and full-width rule underneath
\newcommand{\cvsection}[1]{%
  \vspace{6pt}%
  {\color{cvblue}\large\bfseries\MakeUppercase{#1}}%
  \vspace{2pt}%
  {\color{cvlightgray}\hrule height 0.8pt}%
  \vspace{4pt}%
}

%% ─── TIMELINE DOT ───────────────────────────────────────────────────────────
% \cvdot[color] — the circle on the timeline
\newcommand{\cvdot}[1][dotgray]{%
  \tikz[baseline=-0.5ex]\draw[fill=#1, draw=#1] (0,0) circle (4pt);%
}

%% ─── EXPERIENCE / EDUCATION ENTRY ───────────────────────────────────────────
% Usage: \cventry{date}{location}{dot-color}{title}{company}{description}
\newcommand{\cventry}[6]{%
  \begin{tabular}{p{3.1cm} c p{8.5cm}}
    {\small\color{cvgray}#2 \newline \textit{\small #1}} &
    \cvdot[#3] &
    {\small\textbf{#4}%
    \ifthenelse{\equal{#5}{}}{}{\textit{ #5}}%
    \newline {\footnotesize #6}}
  \end{tabular}%
  \vspace{3pt}%
}

%% ─── CONTACT ITEM ───────────────────────────────────────────────────────────
\newcommand{\contactitem}[2]{%
  {\small\textbf{#1}}\newline
  {\small #2}\par\vspace{4pt}%
}

%% ─── RIGHT SECTION TITLE ────────────────────────────────────────────────────
\newcommand{\rightsection}[1]{%
  \vspace{6pt}%
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
