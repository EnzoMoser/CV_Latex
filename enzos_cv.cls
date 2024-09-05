\ProvidesClass{enzos_cv}[2024/08/22 Enzo Moser's Class for CV]
\NeedsTeXFormat{LaTeX2e}

%% --- Inherit options of article
\DeclareOption*{
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}

\setlength{\parindent}{0pt} % Remove indenting
\pagenumbering{gobble} % Remove page numbering

%% -- Setup required packages
\RequirePackage{fontawesome5} % For extra icons

\RequirePackage{tabularx} % For tables
\RequirePackage{multirow} % For having multiple rows in one table row
\RequirePackage{makecell} % For making dynamic columns
\RequirePackage{ifthen} % For Ifelse statement when checking width of columns

\RequirePackage{fontspec} % For changing the font
\setmainfont{Nimbus Roman} % The default font
\newcommand{\square}{\hspace{0.5em}▪\hspace{0.5em}}

\RequirePackage{graphicx} % For changing font size relative to default

\RequirePackage{enumitem} % For lists
\setitemize{noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt} % Remove any spaces in lists
\setlist[itemize, 1]{left=0pt, label=\scalebox{1}{\square}} % Change the item from a bulletpoint to a different symbol.

\RequirePackage{setspace} % Setting the line spacing
\RequirePackage{ragged2e} % Needed to handle text alignment
\RequirePackage[dvipsnames]{xcolor} % For color
\definecolor{gray}{gray}{0.2}
\definecolor{blue}{RGB}{70, 70, 238}

\RequirePackage[hidelinks, unicode]{hyperref} % Needed for hyperlinks

\RequirePackage{geometry} % Needed to configure page layout
\geometry{left=1.5cm, top=1cm, right=1.5cm, bottom=1.5cm, footskip=.5cm}

\usepackage[super]{nth} % For making 1st, 2nd, 3rd, etc. superscript.

% Underlining
\RequirePackage{contour}
\RequirePackage{ulem}

\renewcommand{\ULdepth}{0.4em}
\contourlength{0.8pt}

\newcommand{\myuline}[1]{%
  \uline{\phantom{#1}}%
  \llap{\contour{white}{#1}}%
}

\RequirePackage[misc]{ifsym} % Used for letter symbol.

\def\vhrulefill#1{\leavevmode\leaders\hrule\@height#1\hfill \kern\z@}

%% -- Commands

% Change the \b macro to bolden text instead.
\renewcommand{\b}[1]{\textbf{#1}}

% Cleans up any text inside using automatic line breaks.
\newcommand{\autolinebreak}[1]{{% Use a second parenthesis to contain everything in a group.
    \raggedleft%
    \hyphenpenalty=10000%
    \exhyphenpenalty=10000%
    #1%
}}

% Usage: \section{<Name>}
\renewcommand{\section}[1]{
  \autolinebreak{
  \renewcommand{\ULthickness}{0.1em}
  \renewcommand{\ULdepth}{0.2em}
  \uline{\scalebox{1.2}{\textbf{\uppercase{#1}}}\hfill} \begin{spacing}{1.5}\end{spacing}
  } 
}

% Used for the \header command:
\newcommand{\addheaderentry}[1]{& #1\\}
\newcommand{\addheaderlinkentry}[1]{& \href{https://#1}{#1}\\}
\newcommand{\addheadergithub}[1]{& \href{https://#1}{\faGithub\hspace{0.5em}#1}\\}
\newcommand{\addheadermailentry}[1]{& \href{mailto:#1}{\Letter\hspace{0.5em}#1}\\}

% Usage: \header{<Name>}{
  % Use the following commands to add entries (there is no limit):
    % \add{<example text>}
    % \addlink{<example link (do not include "https". It is added automatically)>}
    % \addmail{<example mail>}
% }
\newcommand{\header}[2]{{
  \newlength{\myl}
  \settowidth{\myl}{\scalebox{3}{\textbf{\color{black}#1}}}
  \color{gray}
  \newcommand{\add}{\addheaderentry}
  \newcommand{\addgithub}{\addheadergithub}
  \newcommand{\addlink}{\addheaderlinkentry}
  \newcommand{\addmail}{\addheadermailentry}
  \begin{tabularx}{2\myl}{X l}
  \multirow{3}{*}{\parbox{\myl}{\scalebox{2.5}{\textbf{\color{black}#1}}}}
    & \vspace{-0.4em} \\
    #2
  \end{tabularx}
} \vspace{-0.4em}\\\section{} }


\newlength{\tempwidth}
\newcommand{\insideItem}[1]{%
    \settowidth{\tempwidth}{#1}%
    \ifthenelse{\lengthtest{\tempwidth > \linewidth}}{%
        \begin{tabular}{@{}p{\linewidth}@{}}\square#1\end{tabular}%
    }{%
        \begin{tabular}{@{}l@{}}\square#1\end{tabular}%
    }%
}

\newcommand{\insideItemNewLine}[1]{\insideItem{#1}\\}

\newcommand{\fourColumnRowOriginal}[4]{\textbf{#1}&\makecell[tl]{#2}&\makecell[tr]{#3}&\makecell[tr]{#4}\\}
\newcommand{\fourColumnRowItemized}[4]{\insideItem{\textbf{#1}}&\makecell[tl]{#2}&\makecell[tr]{#3}&\makecell[tr]{#4}\\}
\newcommand{\fourColumnRow}{\fourColumnRowOriginal}

% Usage: \fourcolumns{<Bold, Left aligned>}{<Right aligned>}{<Right aligned>}{<Right aligned}
\newcommand{\fourcolumns}[1]{
  \newcommand{\row}{\fourColumnRow}
  \begin{tabular}{@{}l>{\raggedleft\arraybackslash}l>{\raggedleft\arraybackslash}l>{\raggedleft\arraybackslash}l@{}}
    #1
  \end{tabular}
  
}

% Usage: \fourcolumns{<Bold, Left aligned>}{<Right aligned>}{<Right aligned>}{<Right aligned}
\newcommand{\twocolumns}[2]{
  \begin{tabularx}{\linewidth}{@{}l>{\raggedleft\arraybackslash}X@{}}
    \textbf{#1}&#2
  \end{tabularx}
}

% Usage: \infolist{<Top Left>}{<Top Right>}{<Bottom Left>}{<Bottom Right>}{<List of items (use \-)>}
% Example: \infolist{Job title}{Company}{Location}{Date}{\- This is an item \- Another item}
\newcommand{\infolist}[5]{
  {
    \def\@tsize{1.1}
    \def\@bmult{0.98}
    \begin{tabularx}{\textwidth}{@{}Xr@{}}
      \scalebox{\@tsize}{\textbf{#1}} & \scalebox{\@tsize}{\textbf{#2}} \\
      % If the third and fourth arguements are empty, do not print the empty line.
      \if\relax\detokenize{#3}\relax
        \if\relax\detokenize{#4}\relax
        \else%
          \scalebox{\@bmult}{\scalebox{\@tsize}{#3}} & \scalebox{\@bmult}{\scalebox{\@tsize}{#4}} \\
        \fi%
      \else
        \scalebox{\@bmult}{\scalebox{\@tsize}{#3}} & \scalebox{\@bmult}{\scalebox{\@tsize}{#4}} \\
      \fi%
    \end{tabularx}
      \renewcommand{\-}{\insideItem}
      \renewcommand{\fourColumnRow}{\fourColumnRowItemized}
      #5
    \vspace{0.5em}
  }
}