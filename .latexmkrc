#!/usr/bin/env perl
$pdf_mode     = 1; # generate a pdf version of the document using pdflatex.
$bibtex_use   = 2; # run BibTeX or biber whenever it appears necessary to update the bbl files, without testing for the existence of the bib files.
$pdflatex     = 'pdflatex --shell-escape -synctex=1 -interaction=nonstopmode -halt-on-error %O %S';
