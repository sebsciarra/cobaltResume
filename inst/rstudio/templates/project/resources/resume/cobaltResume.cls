%% Start of file `cobaltResume.cls'.
% cobaltResumeClass File
%
% Author:
% Sebastian Sciarra <seb@sciarra.io>
% http://www.sebastiansciarra.com
%
% Notes:
% 1) This class file defines the structure and layout of the template file (cobaltResume.tex).
%
% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl)
%

%-------------------------------------------------------------------------------
%                Identification
%-------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cobaltResume}[2023/05/08]

%-------------------------------------------------------------------------------
%                Class options
%-------------------------------------------------------------------------------

%preliminary declarations (set defaults of already-existing classes)
\LoadClass[]{article}



%-------------------------------------------------------------------------------
%                Declarations
%-------------------------------------------------------------------------------
\RequirePackage{multicol}
\RequirePackage{xcolor}
\RequirePackage[]{geometry}
\RequirePackage[breaklinks=true, hidelinks]{hyperref}
\RequirePackage{paracol}
\footnotelayout{m} %necessary so that paracol does not cause footnotes to print in the text
\RequirePackage{tikz}
\RequirePackage[color=white,opacity=1,angle=0,scale=1]{background}
\RequirePackage{fontawesome5}
\RequirePackage{fancyhdr}
\RequirePackage{setspace}
\RequirePackage{lipsum}
\RequirePackage{calc}
\usetikzlibrary{fit}
\RequirePackage{xstring}
\RequirePackage{amsmath}
\RequirePackage{array} %required for right alignment in tabular columns

\RequirePackage{titlesec}
\RequirePackage{amssymb}
\RequirePackage{sectsty}
\RequirePackage[normalem]{ulem}
\RequirePackage{enumitem}
\RequirePackage{xparse}
\RequirePackage{needspace}
\RequirePackage{xpatch}


\definecolor{bandcolor}{HTML}{002241}
\definecolor{homecolor}{HTML}{d170c7}
\definecolor{simcolor}{HTML}{C7547D}
\definecolor{techcolor}{HTML}{33c304}
\definecolor{codecolor}{HTML}{e38f01}
\definecolor{resourcescolor}{HTML}{52aafa}
\definecolor{aboutcolor}{HTML}{d4bd04}


%-------------------------------------------------------------------------------
%                Commands and Environments
%-------------------------------------------------------------------------------
\newlength{\leftcolumnwidth}
\setlength{\leftcolumnwidth}{0.35\textwidth}

\newlength{\leftHeaderColumnWidth}
\setlength{\leftHeaderColumnWidth}{0.37\textwidth}

\newlength{\rightHeaderColumnWidth}
\setlength{\rightHeaderColumnWidth}{0.565\textwidth}

\renewcommand*{\date}[1]{\def\@date{#1}}
\newcommand*{\position}[1]{\def\@position{#1}}
\newcommand*{\firstName}[1]{\def\@firstName{#1}}
\newcommand*{\lastName}[1]{\def\@lastName{#1}}
\newcommand*{\email}[1]{\def\@email{#1}}
\newcommand*{\skills}[1]{\def\@skills{#1}}
\newcommand*{\citizenship}[1]{\def\@citizenship{#1}}
\newcommand*{\shortDescription}[1]{\def\@shortDescription{#1}}

%Personal website variables
\def\personalWebsite#1{\gdef \@personalWebsite{#1} \@personalWebsitetrue}
\global\let\@personalWebsite\@empty
\newif\if@personalWebsite
\@personalWebsitefalse


%Github variables
\def\githubName#1{\gdef \@githubName{#1} \@githubNametrue}
\global\let\@githubName\@empty
\newif\if@githubName
\@githubNamefalse

\def\githubLink#1{\gdef \@githubLink{#1} \@githubLinktrue}
\global\let\@githubLink\@empty
\newif\if@githubLink
\@githubLinkfalse

%LinkedIn variables
\def\linkedinName#1{\gdef \@linkedinName{#1} \@linkedinNametrue}
\global\let\@linkedinName\@empty
\newif\if@linkedinName
\@linkedinNamefalse

\def\linkedinLink#1{\gdef \@linkedinLink{#1} \@linkedinLinktrue}
\global\let\@linkedinLink\@empty
\newif\if@linkedinLink
\@linkedinLinkfalse


\newcommand{\printSocial}[3]{
  \ifx#1\@empty\else
    \ifx#2\@empty\else
      \href{https://#1}{\textcolor{#3}{#2}} &
     % \vspace{.6cm}
    \fi
  \fi
}

\newcommand{\printIcon}[4]{
  \ifx#1\@empty\else
    \ifx#2\@empty\else
      \href{https://#1}{\textcolor{#3}{\fontsize{14}{14}\selectfont#4}}
      %\vspace{.6cm}
    \fi
  \fi
}


\newcommand{\dotSubstitute}{%
  \StrSubstitute{\@skills}{,}{\space$\cdot$}
}

\newcommand{\cobaltLastName}{\textcolor{bandcolor}{\@lastName\ $\boldsymbol{\cdot}$ Résumé}}


\renewcommand{\section}[1]{%}
\vspace{0.65cm}
  \noindent \begin{tikzpicture}
    \node[font=\fontsize{14}{14}\selectfont\bfseries, inner sep=0pt, text width=\textwidth, align=left] (A) {\textbf{#1}};
    \draw[line width = 0.75pt, draw = bandcolor, text width = 0.335cm]([yshift=-0.25ex]A.south west) -- ([yshift=-0.25ex]A.south east) -- ++(0em,0em) node[inner sep=0pt,outer sep=0pt,font=\tiny, yshift = 0.35ex, text = bandcolor] {$\blacksquare$} -- ++(-\textwidth,0cm) -- cycle;
  \end{tikzpicture}
  \vspace*{-0.5cm}
}
%section header only prints on same page if 4\baselineskip can be fit on same page
\xpretocmd{\section}{\needspace{4\baselineskip}}{}{}



\newcommand{\printValueIfNotEmpty}[1]{%
  \IfValueT{#1}{\if\relax\detokenize{#1}\relax\else\item #1\fi}%
}

\columnratio{0.25}

\NewDocumentEnvironment{resumeEntry}{m m m o o o o o o}{%

    \columnratio{0.65}
    \begin{paracol}{2}
        \par\setstretch{1.5}\noindent%
        {\fontsize{11}{11}\selectfont\bfseries #1} \\%
        {\fontsize{10}{10}\selectfont\textit{#2}}\par%

        \switchcolumn

        \raggedleft
        {\color{bandcolor}\fontsize{9}{9}\bfseries #3}

    \end{paracol}


    \vspace*{0.1cm}


   \IfValueT{#4}{\if\relax\detokenize{#4}\relax\else
  \begin{itemize}[noitemsep,topsep=0pt,partopsep=0pt,parsep=0pt, leftmargin = 11.6pt,
  label=\raisebox{0.04cm}{\fontsize{7pt}{7pt}$\blacksquare$}]
  \setstretch{1.25}
  \fontsize{10}{10}\selectfont
    \item #4
    \printValueIfNotEmpty{#5}
    \printValueIfNotEmpty{#6}
    \printValueIfNotEmpty{#7}
    \printValueIfNotEmpty{#8}
    \printValueIfNotEmpty{#9}
  \end{itemize}
  \vspace*{0.12cm}
  \fi
}
      %only add vertical space if not at end of page
  \ifdim\pagetotal=\pagegoal
  \else
    \vspace*{0.5cm}
  \fi
  }%
{}




%-------------------------------------------------------------------------------
%                Page layout
%-------------------------------------------------------------------------------
%%repeat left band on every page with skills & socials
%%https://tex.stackexchange.com/questions/270195/how-to-repeat-box-every-page
\backgroundsetup{
    contents={
      \begin{tikzpicture}[remember picture, overlay]
        \fill [bandcolor] (current page.north west) rectangle ++(\leftcolumnwidth+0.25cm,-2\textheight);
        \node[font=\fontsize{10.5pt}{10.5pt}\selectfont, text width=\leftcolumnwidth, align = right]
          (skills)
           at ([xshift = 2.75cm, yshift=8.28cm]current page.west) %8.08
          {\parbox[t][0pt][t]{\linewidth}
          {\raggedleft \setstretch{2} \fontsize{14pt}{14pt}\selectfont\underline{Skills} \\ \fontsize{10.5pt}{10.5pt}\selectfont{\dotSubstitute}}};
        \node[font=\ttfamily\fontsize{12pt}{12pt}\bfseries\selectfont, text width=\leftcolumnwidth, align = right]
          (socials)
           at ([xshift = 2.75cm, yshift=-6cm]current page.west)
           {
           \setlength{\tabcolsep}{0pt}
           \renewcommand{\arraystretch}{2}
          \begin{tabular}%
          {>{\raggedleft\arraybackslash}p{0.85\leftcolumnwidth}%
           >{\raggedleft\arraybackslash}p{0.15\leftcolumnwidth}%
          }
            \ifnum\value{page}>1  \printSocial{\@email}{\@email}{simcolor}   \printIcon{\@email}{\@email}{simcolor}{\faEnvelope} \\ \fi
            \printSocial{\@personalWebsite}{\@personalWebsite}{aboutcolor}  \printIcon{\@personalWebsite}{\@personalWebsite}{aboutcolor}{\faHome} \\
            \printSocial{\@githubLink}{\@githubName}{techcolor}  \printIcon{\@githubLink}{\@githubName}{techcolor}{\faGithubSquare} \\
            \printSocial{\@linkedinLink}{\@linkedinName}{resourcescolor}  \printIcon{\@linkedinLink}{\@linkedinName}{resourcescolor}{\faLinkedin} \\
          \end{tabular}
            };
        \node[font=\fontsize{9pt}{9pt}\selectfont, text width=\leftcolumnwidth, align = right]
          (date)
           at ([xshift = 2.75cm, yshift=-12.65cm]current page.west)
           {{\@date} \\
           {Citizenship: \@citizenship}};
      \end{tikzpicture}},
    opacity=1,
    scale=1,
    angle=0,
    position={0,0},
    vshift=0pt,
}

\usepackage{longfbox}
\newcommand\makesquare[1]{%
  \setlength\unitlength{1pt}%
  \begin{picture}(0,0)% make it occupy no space
    \color{bandcolor}%
    \put(0,#1){$\blacksquare$}%
  \end{picture}%
}


\newcommand{\fancybox}[1]{%
  \begin{longfbox}[
    width = \leftHeaderColumnWidth,
    render-insert-after=\makesquare{0cm},
    %border-style = none,
    height = 2.5cm,
    border-color = bandcolor,
    padding-left = 0.25cm,
    padding-right = 0.1cm,
    border-left-width = 0.1cm,
    border-right-width = 0cm,
    border-top-width = 0cm,
    border-bottom-width = 0cm
  ]
    \frenchspacing %remove large word spacing
    {\it #1}
    %
  \end{longfbox}%
}

%% Define page style
\fancypagestyle{cobaltHeader}{%
  \fancyhf{}% Clear header/footer
  \renewcommand{\headrulewidth}{0pt}% Remove header rule
  \renewcommand{\footrulewidth}{0pt}% Remove footer rule
   \fancyfoot[R]{\thepage}% Page number in bottom right
  \fancyfoot[C]{\cobaltLastName}%
  \chead{% Centered header
   \setlength{\tabcolsep}{0pt}
    \begin{tabular}{@{} p{\leftHeaderColumnWidth} p{\rightHeaderColumnWidth} @{}}
      \vspace*{1.25cm}
      \setstretch{1.5}%
\fancybox{\@shortDescription}
      &
      % Content for the right column
       \raggedleft
       \setstretch{2}%
       \vspace*{1.25cm}
       \textcolor{bandcolor}{\fontsize{25}{25}\selectfont\bfseries{\@firstName\ \@lastName}} \\ \vspace*{0.15cm}
       \textcolor{bandcolor}{\fontsize{10}{10}\selectfont\@position}\\ \vspace*{0.3cm}
       \ttfamily\fontsize{11pt}{11pt}\selectfont\textcolor{simcolor}{\href{\@email}{\@email\ \faEnvelope \hspace*{0.01cm}}}
    \end{tabular}
  }%
}





\fancypagestyle{cobaltFooter}{%
  %\setlength{\headheight}{0cm}
  \fancyhf{}% Clear header/footer
  \renewcommand{\headrulewidth}{0pt}% Remove header rule
  \renewcommand{\footrulewidth}{0pt}% Remove footer rule
  \fancyfoot[R]{\thepage}% Page number in bottom right
  \fancyfoot[C]{\cobaltLastName}%
}




%mandatory components that all LaTeX classes must specify
\renewcommand{\normalsize}{\fontsize{8}{8}\selectfont}
\setlength{\textwidth}{17.5cm}
\setlength{\textheight}{24cm}
\setcounter{secnumdepth}{0}
\usepackage[]{footnote}  %removes indentation in footnotes


\geometry{
  left=\leftcolumnwidth + 1.2cm,
  right=1cm,
  top=1.5cm,
  bottom=1cm,
  includehead = false,
  includefoot = true
}









%default color in document
\color{bandcolor}
