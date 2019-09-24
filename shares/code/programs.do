
cap program drop skillgroups_summarystats
program define skillgroups_summarystats
syntax, saveas(string)

//Generate statistics
use "../input/CAC_msaedufor_obs.dta", clear
gen edu2 = edu
recode edu2 1=1 2=1 3=1 4=2 5=2 6=3 7=3 8=3 9=3
label define edu2_aggregated_categories 1 "High school or less" 2 "Some college" 3 "Bachelor's or more"
label values edu2 edu2_aggregated_categories
collapse (sum) perwt, by(edu edu2 foreign)
bys edu: egen total = total(perwt)
by  edu: egen numer = total(perwt*(foreign==0))
bys edu2: egen total2 = total(perwt)
by  edu2: egen numer2 = total(perwt*(foreign==0))
gen usborn = numer / total
gen usborn2 = numer2 / total2
collapse (sum) perwt (first) usborn usborn2, by(edu2 edu)
egen total = total(perwt)
bys edu2: egen perwt2 = total(perwt)
gen share = perwt / total
gen share2 = perwt2 / total
keep edu edu2 share share2 usborn usborn2
save "../output/`saveas'.dta", replace

//Generate LaTeX table: Shorter code
use "../output/`saveas'.dta", clear
foreach var of varlist share share2 usborn usborn2 {
	tostring `var', replace format(%3.2f) force
	replace `var' = subinstr(`var',"0.",".",1)
}
sort edu2 edu
by edu2: gen i = _n
replace edu2 = . if i~=1
foreach var of varlist share2 usborn2 {
	replace `var' = "" if i~=1
}
listtex edu2 share2 usborn2 edu share usborn using "../output/`saveas'.tex", replace ///
rstyle(tabular) head("\begin{tabular}{|lcc|lcc|} \hline" "&Population&Share&&Population&Share \\" "Skill (3 groups) &share&US-born&Skill (9 groups) &share&US-born \\ \hline") foot("\hline \end{tabular}")

end


cap program drop alternativeskillgroups_summary
program define alternativeskillgroups_summary
syntax, saveas(string)

tempfile tf1

//Generate shares for SF3 stuff
use "../input/MSA_EDU_2000SF3.dta", clear
drop if msa == 1010 | msa == 1890 | msa == 2200 | msa == 2340 | msa == 3700 | msa == 6340 //Dropping the six MSAs that are not considered in the CAC paper due to PUMA mapping issues.
collapse (sum) pop25plus lessgrade9 grade9to12 hs somecollege associate ba master prof phd
#delimit ;
ren lessgrade9 pop1; ren grade9to12 pop2; ren hs pop3; ren somecollege pop4; ren associate pop5; ren ba pop6; ren master pop7; ren prof pop8; ren phd pop9;
#delimit cr
reshape long pop, i(pop25plus) j(edu)
gen share_sf3 = pop / pop25plus
gen edu2 = edu
recode edu2 1=1 2=1 3=1 4=2 5=2 6=3 7=3 8=3 9=3
bys edu2: egen total2 = total(pop)
gen share2_sf3 = total2 / pop25plus
keep edu edu2 share_sf3 share2_sf3
save `tf1', replace


//Generate statistics for FTFY sample
use "../input/CAC_FTFY_msaedufor_obs.dta", clear
gen edu2 = edu
recode edu2 1=1 2=1 3=1 4=2 5=2 6=3 7=3 8=3 9=3
label define edu2_aggregated_categories 1 "High school or less" 2 "Some college" 3 "Bachelor's or more"
label values edu2 edu2_aggregated_categories
collapse (sum) perwt, by(edu edu2 foreign)
bys edu: egen total = total(perwt)
by  edu: egen numer = total(perwt*(foreign==0))
bys edu2: egen total2 = total(perwt)
by  edu2: egen numer2 = total(perwt*(foreign==0))
gen usborn = numer / total
gen usborn2 = numer2 / total2
collapse (sum) perwt (first) usborn usborn2, by(edu2 edu)
egen total = total(perwt)
bys edu2: egen perwt2 = total(perwt)
gen share = perwt / total
gen share2 = perwt2 / total
keep edu edu2 share share2 usborn usborn2

merge 1:1 edu edu2 using `tf1',

//Generate LaTeX table
foreach var of varlist share_sf3 share2_sf3 share share2 usborn usborn2 {
	generate `var'_str = string(`var',"%3.2f")
	replace `var'_str = subinstr(`var'_str,"0.",".",1)
	drop `var'
}
decode edu, gen(edu_str)
decode edu2, gen(edu2_str)
local obs = _N + 2
set obs `obs'
replace edu2 = -1 if _n == `obs' - 1
replace edu2 = 0 if _n == `obs'
sort edu2 edu
replace edu2_str = "Skill (3 groups)" if edu2==0
replace share2_sf3_str = "Summary File 3" if edu2==-1
replace share2_sf3_str = "population share"  if edu2==0
replace share2_str = "IPUMS FTFY" if edu2==-1
replace share2_str = "population share"  if edu2==0
replace usborn2_str = "Share " if edu2==-1
replace usborn2_str = "US-born"  if edu2==0
replace edu_str = "Skill (9 groups)" if edu2==0
replace share_sf3_str = "Summary File 3" if edu2==-1
replace share_sf3_str = "population share"  if edu2==0
replace share_str = "IPUMS FTFY" if edu2==-1
replace share_str = "population share"  if edu2==0
replace usborn_str = "Share " if edu2==-1
replace usborn_str = "US-born"  if edu2==0

sort edu2 edu
by edu2: gen i = _n
foreach var of varlist edu2_str share2_sf3_str share2_str usborn2_str {
	replace `var' = "" if i~=1
}

forvalues i = 1/7 {
	gen str colsep`i' = "&"
}
gen str lineender = "\\"
replace lineender = "\\ \hline" if edu2==0|edu==3|edu==5|edu==9
replace edu2_str = "\begin{tabular}{|lccc|lccc|} \hline" if edu2==-1
replace lineender = "\\ \hline\end{tabular}" if edu==9

keep edu2_str share2_sf3_str share2_str usborn2 edu_str share_sf3_str share_str usborn_str  colsep? lineender
order edu2_str colsep6 share2_sf3_str colsep1 share2_str colsep2 usborn2 colsep3 edu_str colsep4 share_sf3_str colsep7 share_str colsep5 usborn_str lineender
outfile * using "../output/`saveas'.tex", replace noquote nolabel wide

end



cap program drop shares_1980
program define shares_1980
syntax using/, saveas(string)

use "`using'", clear

tempfile tf_share tf_usborn
preserve
collapse (sum) perwt, by(edu)
egen denom = total(perwt)
gen share = perwt/denom
save `tf_share', replace
restore
collapse (mean) foreign [aw=perwt], by(edu)
gen usborn = 1-foreign
keep edu usborn
save `tf_usborn', replace

merge 1:1 edu using `tf_share', assert(match) keepusing(share) nogen
decode edu, gen(edu_label)
replace edu_label = "Less than high school" if edu_label=="Less than grade 9"
replace edu_label = "High school dropout" if edu_label=="Grades 9 to 11"

save "../output/`saveas'.dta", replace

end
