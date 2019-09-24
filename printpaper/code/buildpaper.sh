#!bin/bash

module load texlive
pdflatex paper.tex
pdflatex paper.tex
rm paper.log paper.aux paper.out
mv paper.pdf ../output/
module unload texlive
