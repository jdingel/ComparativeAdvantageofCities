
// load education population shares
tempfile tf_edu3_shares tf_edu9_shares
use "../input/table1.dta", clear
preserve
keep *2
duplicates drop
decode edu2, gen(edu2_label)
save `tf_edu3_shares', replace
restore
keep edu usborn share
decode edu, gen(edu_label)
replace edu_label = "PhD" if edu_label=="Doctorate"
save `tf_edu9_shares', replace


// 3 skill groups
import delim using "../output/table3.txt", clear
drop v1
split v2, parse($)
ren v23 edu2_label
replace edu2_label = trim(edu2_label)
gen row = _n
merge m:1 edu2_label using `tf_edu3_shares', nogen keepusing(usborn2 share2)
sort row
drop v2? edu2_label row
drop in 1/3
count
drop in `r(N)'
order v* share2 usborn2
format share2 usborn2 %3.2f
listtex * using "../output/table3_clean.tex", replace rstyle(tabular) ///
head("\begin{center}" "\begin{tabular}{lcccc} \toprule" ///
                                       "& (1) &   (2)   &Population&Share \\" ///
"Dependent variable: $\ln f(\omega,c)$ & All & US-born & share & US-born \\ \hline") ///
foot("\bottomrule \end{tabular}" "\end{center}")


// 9 skill groups
import delim using "../output/table5.txt", clear
split v2, parse($)
ren v23 edu_label
replace edu_label = trim(edu_label)
gen row = _n
merge m:1 edu_label using `tf_edu9_shares', nogen keepusing(usborn share)
sort row
drop row v1 v2? edu_label
drop in 1/3
count
drop in `r(N)'
order v* share usborn
format share usborn %3.2f
listtex * using "../output/table5_clean.tex", replace rstyle(tabular) ///
head("\begin{center}" "\begin{tabular}{lcccc} \toprule" ///
                                       "& (1) &   (2)   &Population&Share \\" ///
"Dependent variable: $\ln f(\omega,c)$ & All & US-born & share & US-born \\ \hline") ///
foot("\bottomrule \end{tabular}" "\end{center}")


// Table E.1 (1980 population elasticities)
import delim using "../output/tableE1.txt", clear
ds v*
local table `r(varlist)'
split v2, parse($)
ren v23 edu_label
replace edu_label = trim(edu_label)
keep `table' edu_label
gen row = _n
merge m:1 edu_label using "../input/tableE1_shares_1980.dta", keepusing(share usborn) nogen
sort row
drop row edu_label v1
format usborn share %3.2f
keep in 4/17
listtex v* share usborn using "../output/tableE1_withshares.tex", replace rstyle(tabular) ///
head("\begin{center}" "\begin{tabular}{lcc|cc} \toprule" ///
                                      "& (1) & (2) & Population & Share \\" ///
"Dependent variable: $\ln f(\omega,c)$ & All & US-born & share & US-born \\ \hline") ///
foot("\bottomrule \end{tabular}" "\end{center}")


// Table E.2 (occupations)
import delim using "../output/tableE2_occupations.txt", clear
keep v2 v3
ds v*
local vars `r(varlist)'
tempfile tf_panel1 tf_panel2
preserve
keep in 4/25
ren (`vars') (lab_left beta_left)
gen id = _n
save `tf_panel1', replace
restore
keep in 26/47
ren (`vars') (lab_right beta_right)
gen id = _n
save `tf_panel2', replace

use `tf_panel1', clear
merge 1:1 id using `tf_panel2', assert(match) nogen
drop id
listtex * using "../output/tableE2_occupations_clean.tex", replace rstyle(tabular) ///
head("\begin{tabular}{lclc} \toprule") ///
foot("\bottomrule \end{tabular}")

