#!/bin/sh

cat ../output/wagebins_table.tex | \
sed 's/VARIABLES//' | sed 's/\\begin{footnotesize}\\end{footnotesize}//g' | \
sed 's/\\begin{center}//' | sed 's/\\end{center}//' | \
sed 's/All \& US-born/\\multicolumn{2}{c}{productivity interpretation} \& \\multicolumn{2}{c}{amenity interpretation} \\\\ \\cmidrule(lr){2-3} \\cmidrule(lr){4-5} \n \& All \& US-born/' \
> ../output/wagebins_table_clean.tex
