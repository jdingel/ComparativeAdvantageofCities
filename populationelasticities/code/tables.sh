#!/bin/bash

echo '\begin{tabular}{lcclcc} \toprule &(1)&(2)&&(1)&(2)\\ \hline ' > header.tex
sed -n '6,25p' ../output/tableE3_naics2.tex | sed 's/\\\\$/\&/' > firstcolumn.tex
cat <(sed -n '26,43p' ../output/tableE3_naics2.tex) <(echo '\\ ') <(echo '\\ ') > secondcolumn.tex
cat <(paste <(grep 'bservations' ../output/tableE3_naics2.tex | sed 's/\\\\/\&/' | sed 's/\\hline//') <(grep 'bservations' ../output/tableE3_naics2.tex | sed 's/\\hline/\\bottomrule/')) \
<(sed -n '49p' ../output/tableE3_naics2.tex) > footer.tex

cat header.tex <(paste firstcolumn.tex secondcolumn.tex) footer.tex > ../output/tableE3_naics2_clean.tex
rm header.tex firstcolumn.tex secondcolumn.tex footer.tex
