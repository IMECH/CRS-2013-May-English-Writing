\NeedsTeXFormat{LaTeX2e}[1995/01/01]
\ProvidesClass{caspset}
    [2005/03/10 v0.04 CAS Math Dept problem set class]

%%% INITIAL CODE ----------------------------------------------------------

% test whether the document is being compiled with PDFTeX
\RequirePackage{ifpdf}


%%% DECLARATION OF OPTIONS ------------------------------------------------
%% Header Options: header*, no header
\newif\ifcaspset@header

% no header block in upper right hand corner
\DeclareOption{noheader}{%
    \caspset@headerfalse%
}

% do print header block
\DeclareOption{header}{%
    \caspset@headertrue%
}

%% Font Options: palatino*, cm
\newif\ifcaspset@palatino

% use palatino fonts
\DeclareOption{palatino}{%
    \caspset@palatinotrue%
}

% use compuer modern fonts
\DeclareOption{cm}{%
    \caspset@palatinofalse%
}

%% Problem Boxing: boxed*, unboxed
\newif\ifcaspset@boxed

% box problem statements
\DeclareOption{boxed}{%
    \caspset@boxedtrue%
}
   
% don't box problem statements
\DeclareOption{unboxed}{%
    \caspset@boxedfalse%
}
   
% pass remaining options to article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

%%% EXECUTION OF OPTIONS --------------------------------------------------
%% default to:
% including header, 
% loading mathpazo package for palatino fonts,
% boxing problem statements
\ExecuteOptions{header,palatino,boxed}

\ProcessOptions

%%% PACKAGE LOADING -------------------------------------------------------
%% based on std article class
\LoadClass{article}


%% Font loading: Palatino text/math fonts
\ifcaspset@palatino
    \RequirePackage{mathpazo}
\fi

%% AMSLaTeX math environments and symbols
\RequirePackage{amsmath}
\RequirePackage{amssymb}

%% boxed minipage for boxed problem environment
\RequirePackage{boxedminipage}

%%% MAIN CODE -------------------------------------------------------------
%% Tell dvips/pdflatex correct page size
\ifpdf
  \AtBeginDocument{%
    \setlength{\pdfpageheight}{\paperheight}%
    \setlength{\pdfpagewidth}{\paperwidth}%
  }
\else
  \AtBeginDvi{\special{papersize=\the\paperwidth,\the\paperheight}}%
\fi


%% Problem set environments
% boxed problem environment
\newenvironment{problem}[1][]{%
  \ifcaspset@boxed\def\caspset@probenv{boxed}\else\def\caspset@probenv{}\fi%
  \bigskip% put space before problem statement box %
  \noindent\begin{\caspset@probenv minipage}{\columnwidth}%
  \def\@tempa{#1}%
  \ifx\@tempa\empty\else%
    \caspset@probformat{#1}\hspace{0.5em}%
  \fi%
}{%
  \end{\caspset@probenv minipage}%
}
% display optional argument to problem in bold
\let\caspset@probformat\textbf

% solution environment with endmark and optional argument
\newenvironment{solution}[1][]{%
  \begin{trivlist}%
  \def\@tempa{#1}%
  \ifx\@tempa\empty%
    \item[]%
  \else%
    \item[\hskip\labelsep\relax #1]%
  \fi%
}{%
  \mbox{}\penalty10000\hfill\caspset@endmark%
  \end{trivlist}%
}

% default endmark is small black square
\def\caspset@endmark{\ensuremath{\scriptscriptstyle\blacksquare}}

%% Problem set list, for top of document
\newcommand{\problemlist}[1]{\begin{center}\large\sffamily{#1}\end{center}}

%% commands for upper-right id header block
\newcommand{\headerblock}{%
\begin{flushright}
\mbox{\caspset@name}\protect\\
\mbox{\caspset@class}\protect\\
\mbox{\caspset@assignment}\protect\\
\caspset@duedate%
\ifx\caspset@extraline\empty\else\protect\\\caspset@extraline\fi%
\end{flushright}%
}

% put id header block at start of document
\ifcaspset@header\AtBeginDocument{\headerblock}\fi

% internal state for headerblock
\def\caspset@name{}
\def\caspset@class{}
\def\caspset@assignment{}
\def\caspset@duedate{}
\def\caspset@extraline{}

% commands to set header block info
\newcommand{\name}[1]{\def\caspset@name{#1}}
\newcommand{\class}[1]{\def\caspset@class{#1}}
\newcommand{\assignment}[1]{\def\caspset@assignment{#1}}
\newcommand{\duedate}[1]{\def\caspset@duedate{#1}}
\newcommand{\extraline}[1]{\def\caspset@extraline{#1}}
