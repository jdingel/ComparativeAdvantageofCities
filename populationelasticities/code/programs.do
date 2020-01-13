
/**************************************
** LABELING and TeX output PROGRAMS
**************************************/

cap program drop popelast_3skill_regandlabels
program define popelast_3skill_regandlabels
forvalues i = 1/3 {
	gen logpopXedu_`i' = logpop * (edu==`i')
}
tab edu, gen(edu_)
label var logpopXedu_1 "\$\beta_{\omega 1}\$ High school or less \$\times\$ log population"
label var logpopXedu_2 "\$\beta_{\omega 2}\$ Some college \$\times\$ log population"
label var logpopXedu_3 "\$\beta_{\omega 3}\$ Bachelor's or more \$\times\$ log population"
end

cap program drop popelast_9skill_regandlabels
program define popelast_9skill_regandlabels
forvalues i = 1/9 {
	gen logpopXedu_`i' = logpop * (edu==`i')
}
tab edu, gen(edu_)
label var logpopXedu_1 "\$\beta_{\omega 1}\$ Less than high school \$\times\$ log population"
label var logpopXedu_2 "\$\beta_{\omega 2}\$ High school dropout \$\times\$ log population"
label var logpopXedu_3 "\$\beta_{\omega 3}\$ High school graduate \$\times\$ log population"
label var logpopXedu_4 "\$\beta_{\omega 4}\$ College dropout \$\times\$ log population"
label var logpopXedu_5 "\$\beta_{\omega 5}\$ Associate's degree \$\times\$ log population"
label var logpopXedu_6 "\$\beta_{\omega 6}\$ Bachelor's degree \$\times\$ log population"
label var logpopXedu_7 "\$\beta_{\omega 7}\$ Master's degree \$\times\$ log population"
label var logpopXedu_8 "\$\beta_{\omega 8}\$ Professional degree \$\times\$ log population"
label var logpopXedu_9 "\$\beta_{\omega 9}\$ PhD \$\times\$ log population"
end


cap program drop popelast_3skill_regandlabels
program define popelast_3skill_regandlabels
forvalues i = 1/3 {
	gen logpopXedu_`i' = logpop * (edu==`i')
}
tab edu, gen(edu_)
label var logpopXedu_1 "\$\beta_{\omega 1}\$ High school or less \$\times\$ log population"
label var logpopXedu_2 "\$\beta_{\omega 2}\$ Some college \$\times\$ log population"
label var logpopXedu_3 "\$\beta_{\omega 3}\$ Bachelor's or more \$\times\$ log population"
end

cap program drop popelast_9skill_fails_regandlabs
program define popelast_9skill_fails_regandlabs
forvalues i = 1/9 {
	gen logpopXedu_`i' = logpop * (edu==`i')
}
tab edu, gen(edu_)
label var logpopXedu_1 "\$\beta_{\omega 1}\$ Less than high school \$\times\$ log population"
label var logpopXedu_2 "\$\beta_{\omega 2}\$ High school dropout \$\times\$ log population"
label var logpopXedu_3 "\$\beta_{\omega 3}\$ High school graduate \$\times\$ log population"
label var logpopXedu_4 "\$\beta_{\omega 4}\$ College dropout \$\times\$ log population"
label var logpopXedu_5 "\$\beta_{\omega 5}\$ Associate's degree \$\times\$ log population"
label var logpopXedu_6 "\$\beta_{\omega 6}\$ Bachelor's degree \$\times\$ log population"
label var logpopXedu_7 "\$\beta_{\omega 7}\$ Master's degree \$\times\$ log population"
label var logpopXedu_8 "\$\beta_{\omega 8}\$ Professional degree \$\times\$ log population"
label var logpopXedu_9 "\$\beta_{\omega 9}\$ PhD \$\times\$ log population"
end

cap program drop popelast_9skills_1980_regandlabs
program define popelast_9skills_1980_regandlabs
forvalues i = 1/7 {
	gen logpopXedu_`i' = logpop * (edu==`i')
}
tab edu, gen(edu_)
label var logpopXedu_1 "\$\beta_{\omega 1}\$ Less than high school \$\times\$ log population"
label var logpopXedu_2 "\$\beta_{\omega 2}\$ High school dropout \$\times\$ log population"
label var logpopXedu_3 "\$\beta_{\omega 3}\$ Grade 12 \$\times\$ log population"
label var logpopXedu_4 "\$\beta_{\omega 4}\$ 1 year college \$\times\$ log population"
label var logpopXedu_5 "\$\beta_{\omega 5}\$ 2-3 years college \$\times\$ log population"
label var logpopXedu_6 "\$\beta_{\omega 6}\$ 4 years college \$\times\$ log population"
label var logpopXedu_7 "\$\beta_{\omega 7}\$ 5+ years college \$\times\$ log population"
end


cap program drop popelasticities_3skills
program define popelasticities_3skills
syntax, saveas(string)

//COLUMN 1: In labor force in IPUMS
use "../input/CAC_msaedufor_obs.dta", clear
recode edu 1=1 2=1 3=1 4=2 5=2 6=3 7=3 8=3 9=3
collapse (sum) perwt, by(year msa edu)
merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keep(1 3) keepusing(logpop)
generate edupop = log(perwt)
popelast_3skill_regandlabels
regress edupop logpopXedu_? edu_?, vce(cluster msa)
outreg2 using "../output/`saveas'.tex", tex(pr landscape frag) replace keep(logpopXedu*) label ctitle(All) nocons noaster nor2 noobs nonotes

//COLUMN 2: In labor force IPUMS, only US-born people
use "../input/CAC_msaedufor_obs.dta", clear
keep if foreign==0
recode edu 1=1 2=1 3=1 4=2 5=2 6=3 7=3 8=3 9=3
collapse (sum) perwt, by(year msa edu)
merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keep(1 3) keepusing(logpop)
generate edupop = log(perwt)
popelast_3skill_regandlabels
regress edupop logpopXedu_? edu_?, vce(cluster msa)
outreg2 using "../output/`saveas'.tex", tex(pr landscape frag) append keep(logpopXedu*) label ctitle(US-born)   nocons noaster nor2 noobs nonotes

end

cap program drop popelast_9skills_countfails //CAC_table4_countfails
program define popelast_9skills_countfails //CAC_table4_countfails

mat fails = (0)
forvalues x = 1/9{
	forvalues y = `x'/9{
		if _b[logpopXedu_`x'] > _b[logpopXedu_`y'] {
			qui test (logpopXedu_`x' = logpopXedu_`y')
			local result = r(p)
			if `result' <= .05 mat fails = fails + (1)
			if `result' <= .05 test (logpopXedu_`x' = logpopXedu_`y')
		}
	}
}
mat list fails

end

cap program drop popelasticities_9skills
program define popelasticities_9skills
syntax, saveas(string)

//COLUMN 1: In labor force in IPUMS
use "../input/CAC_msaedufor_obs.dta", clear
collapse (sum) perwt, by(year msa edu)
merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keep(1 3) keepusing(logpop)
generate edupop = log(perwt)
popelast_9skill_fails_regandlabs
regress edupop logpopXedu_? edu_?, vce(cluster msa)
outreg2 using "../output/`saveas'.tex", tex(pr landscape frag) replace keep(logpopXedu*) label ctitle(All) nocons noaster nor2 noobs nonotes
//How often are column 1 elasticities in wrong order?
popelast_9skills_countfails

//COLUMN 2: In labor force IPUMS, only US-born people
use "../input/CAC_msaedufor_obs.dta", clear
keep if foreign==0
collapse (sum) perwt, by(year msa edu)
merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keep(1 3) keepusing(logpop)
generate edupop = log(perwt)
popelast_9skill_fails_regandlabs
regress edupop logpopXedu_? edu_?, vce(cluster msa)
outreg2 using "../output/`saveas'.tex", tex(pr landscape frag) append keep(logpopXedu*) label ctitle(US-born)   nocons noaster nor2 noobs nonotes
//How often are column 2 elasticities in wrong order?
popelast_9skills_countfails

end

cap program drop popelast_7skills_1980
program define popelast_7skills_1980
syntax, saveas(string)

//COLUMN 1: In labor force in IPUMS
use "../input/PREP_CAC_1980.dta", clear
generate logpop = log(pop_msa)
collapse (first) logpop (sum) perwt, by(year msa edu)
generate edupop = log(perwt)
popelast_9skills_1980_regandlabs
regress edupop logpopXedu_? edu_?, vce(cluster msa)
outreg2 using "../output/`saveas'.tex", tex(pr landscape frag) replace keep(logpopXedu*) label ctitle(All) nocons noaster nor2 noobs nonotes

//COLUMN 2: In labor force IPUMS, only US-born people
use "../input/PREP_CAC_1980.dta", clear
keep if foreign==0
generate logpop = log(pop_msa)
collapse (first) logpop (sum) perwt, by(year msa edu)
generate edupop = log(perwt)
popelast_9skills_1980_regandlabs
regress edupop logpopXedu_? edu_?, vce(cluster msa)
outreg2 using "../output/`saveas'.tex", tex(pr landscape frag) append keep(logpopXedu*) label ctitle(US-born)   nocons noaster nor2 noobs nonotes

end

cap program drop popelast_7skills_1980_shares
program define popelast_7skills_1980_shares
syntax, saveas(string)

//Generate statistics
use "../input/PREP_CAC_1980.dta", clear
collapse (sum) perwt, by(edu foreign)
bys edu: egen total = total(perwt)
by  edu: egen numer = total(perwt*(foreign==0))
gen usborn = numer / total
collapse (sum) perwt (first) usborn, by(edu)
egen total = total(perwt)
gen share = perwt / total
keep edu share usborn
foreach var of varlist share usborn {
	generate `var'_str = string(`var',"%9.2f")
	replace `var'_str = subinstr(`var'_str,"0.",".",1)
}
local obs = _N + 2
set obs `obs'
recode edu .=0  if _n==_N
recode edu .=-1 if _n==_N-1
expand 2
bys edu: gen j = _n
recode edu -1=100 if j==2
sort edu j
foreach var of varlist *_str {
	replace `var' = "" if j==2
}
replace usborn_str = "Percent" if edu==-1 & j==1
replace usborn_str = "US-born" if edu==0 & j==1
replace share_str = "Population" if edu==-1 & j==1
replace share_str = "share" if edu==0 & j==1

gen str blank_str = ""
keep *str
order share usborn blank_str
export delimited *_str using "../output/`saveas'_append.tex", replace delimiter("&") novarnames

end



cap program drop popelasticities_occupations
program define popelasticities_occupations
syntax, figure(integer) tabsaveas(string) figsaveas(string)

use "../input/OCCSOC2000.dta", clear
merge m:1 msa using "../input/CMSA_POP2000.dta", keepusing(cmsa_pop)

keep occ_code msa emp_occgeo cmsa_pop
generate logpop = log(cmsa_pop)
generate logemp = log(emp_occgeo)

merge m:1 occ_code using "../input/occ_skillintensities.dta", nogen keep(1 3)

//Generate skill-intensity ranks
tempfile tf1 tf2
save `tf1', replace
collapse (firstnm) skillintensity, by(occ_code)
drop if missing(skillintensity)
egen skillintensityrank = rank(skillintensity)
save `tf2', replace
use `tf1', clear
merge m:1 occ_code using `tf2', keepusing(skillintensityrank) nogen
merge m:1 occ_code using "../input/occ_labels.dta", nogen keep(1 3) keepusing(occ_title)

//Generate regressors
summ skillintensityrank
local groups = r(max)
forvalues x = 1/`groups'{
	gen logpop_`x' = logpop * (skillintensityrank==`x')
	gsort -logpop_`x'
	local occlabel = occ_title[1]
	label var logpop_`x' "\$\beta_{\sigma`x'}\$ `occlabel'"
}
//Regression including all observations
areg logemp logpop_* , vce(cluster msa) absorb(occ_code)
outreg2 using "../output/`tabsaveas'_occupations.tex", replace label nocons noaster nonotes addtext(Occupation fixed effects, Yes) tex(pr landscape frag)
mat fails = (0)
forvalues x = 1/`groups'{
	forvalues y = `x'/`groups'{
		if _b[logpop_`x'] > _b[logpop_`y'] {
			qui test (logpop_`x' = logpop_`y')
			local result = r(p)
			if `result' <= .05 mat fails = fails + (1)
		}
	}
}
mat list fails

if `figure' == 1{
//Scatterplot with results of regression
areg logemp logpop_* , vce(cluster msa) absorb(occ_code)
parmest, norestore
drop if parm=="_cons"
ren estimate populationelasticity
gen str skillintensityrank=subinstr(parm,"logpop_","",1) if substr(parm,1,7)=="logpop_"
destring skillintensityrank, replace
merge 1:1 skillintensityrank using `tf2', nogen keep(1 3) keepusing(occ_code skillintensity)
merge 1:1 occ_code using "../input/occ_labels.dta", nogen keep(1 3) keepusing(occ_title)
replace occ_title = subinstr(occ_title,"Building and Grounds Cleaning and Maintenance Occupations","Cleaning and Maintenance",1) //Brevity for scatterplot purposes
replace occ_title = subinstr(occ_title," Occupations","",.) //Brevity for scatterplot purposes
replace occ_title = subinstr(occ_title, " and ", " & ",.) //Brevity for scatterplot purposes
gen labelposition = 3
replace labelposition = 9 if occ_code==35|occ_code==37|occ_code==13 //|occ_code==27
replace labelposition = 10 if occ_code==53|occ_code==43
replace labelposition = 4 if occ_code==21
replace labelposition = 7 if occ_code==47
replace labelposition = 2 if occ_code==25|occ_code==17|occ_code==19
twoway (scatter populationelasticity skillintensity, xlab(6(2)20) mlabel(occ_title) mlabvposition(labelposition) mlabsize(vsmall) mlabcolor(gs8) msymbol(Oh) mcolor(black)), xtitle("Skill intensity (employees' average years of schooling)") graphregion(color(white)) ylabel(,nogrid)
graph export "../output/`figsaveas'_occupations.pdf", as(pdf) replace
}
end

cap program drop popelasticities_industries //CAC_table11
program define popelasticities_industries //CAC_table11

syntax using/, figure(integer) tabsaveas(string) figsaveas(string) naics_digit(real)

use "`using'", clear
rename aggreg_emp emp_indgeo
keep naics msa emp_indgeo cmsa_pop censored
generate logpop = log(cmsa_pop)
generate logemp = log(emp_indgeo)

drop if naics==95 | naics==99 //naics==95 is auxiliary establishments in CBP; naics==99 is unclassified
merge m:1 naics using "../input/naics`naics_digit'_skillintensities.dta", nogen keep(1 3)

//Generate skill-intensity ranks
tempfile tf1 tf2
save `tf1', replace
collapse (firstnm) skillintensity, by(naics)
drop if missing(skillintensity)
egen skillintensityrank = rank(skillintensity)
save `tf2', replace
use `tf1', clear
merge m:1 naics using `tf2', keepusing(skillintensityrank) nogen
merge m:1 naics using "../input/naics_labels.dta", nogen keep(1 3) keepusing(naicsdescription)

//Generate regressors
summ skillintensityrank
local groups = r(max)
forvalues x = 1/`groups'{
	gen logpop_`x' = logpop * (skillintensityrank==`x')
	gsort -logpop_`x'
	local naicslabel = naicsdescrip[1]
	label var logpop_`x' "\$\beta_{\sigma`x'}\$ `naicslabel'"
}
//Regression including all observations
areg logemp logpop_* , vce(cluster msa) absorb(naics)
outreg2 using "../output/`tabsaveas'_naics`naics_digit'.tex", replace label nocons noaster nonotes tex(pr landscape frag)  ctitle(All) addtext(Industry fixed effects, Yes)
mat fails = (0)
forvalues x = 1/`groups'{
	forvalues y = `x'/`groups'{
		if _b[logpop_`x'] > _b[logpop_`y'] {
			qui test (logpop_`x' = logpop_`y')
			local result = r(p)
			if `result' <= .05 mat fails = fails + (1)
		}
	}
}
mat list fails

//Regression including only uncensored observations
areg logemp logpop_* if censored == 0, vce(cluster msa) absorb(naics)
outreg2 using "../output/`tabsaveas'_naics`naics_digit'.tex", append label nocons noaster nonotes tex(pr landscape frag) ctitle(Uncensored) addtext(Industry fixed effects, Yes, Only uncensored observations, Yes)
mat fails = (0)
forvalues x = 1/`groups'{
	forvalues y = `x'/`groups'{
		if _b[logpop_`x'] > _b[logpop_`y'] {
			qui test (logpop_`x' = logpop_`y')
			local result = r(p)
			if `result' <= .05 mat fails = fails + (1)
		}
	}
}
mat list fails

if `figure' == 1{
//Regression including all observations: Scatterplot
areg logemp logpop_* , vce(cluster msa) absorb(naics)
parmest, norestore
drop if parm=="_cons"
ren estimate populationelasticity
gen str skillintensityrank=subinstr(parm,"logpop_","",1) if substr(parm,1,7)=="logpop_"
destring skillintensityrank, replace
merge 1:1 skillintensityrank using `tf2', nogen keep(1 3) keepusing(naics skillintensity)
merge 1:1 naics using "../input/naics_labels.dta", nogen keep(1 3) keepusing(naicsdescription)
gen labelposition = 3
replace labelposition = 9 if naics==61|naics==54|naics==55|naics==72|naics==48
replace labelposition = 8 if naics==42
replace labelposition = 2 if naics==52|naics==51
replace labelposition = 1 if naics==56
replace labelposition = 11 if naics==52
twoway (scatter populationelasticity skillintensity, mlabel(naicsdescription) mlabvposition(labelposition) mlabsize(vsmall) mlabcolor(gs8) msymbol(Oh) mcolor(black)), xtitle("Skill intensity (employees' average years of schooling)") graphregion(color(white)) ylabel(,nogrid)
graph export "../output/`figsaveas'_naics`naics_digit'.pdf", as(pdf) replace
}
end


cap program drop edupop_graph
program define edupop_graph
syntax, saveas(string)

use "../input/CAC_msaedufor_obs.dta", clear
collapse (sum) perwt, by(year msa edu)
merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keep(1 3) keepusing(logpop)
gen edupop = log(perwt)

//De-meaning educational group populations
egen mean_edu = mean(edupop), by(edu)
generate demean_edupop = edupop-mean_edu

capture graph drop Fig1A
capture graph drop Fig1B

//Generating graphs
twoway (scatter demean_edupop logpop if edu == 6, msymbol(sh) mcolor(gray)) ///
(scatter demean_edupop logpop if edu == 4, msymbol(th) mcolor(blue)) ///
(scatter demean_edupop logpop if edu == 3, msymbol(oh) mcolor(red)), ylabel(,nogrid) ///
ytitle("Log skill population (deviation from mean)") xtitle("Metropolitan log population") graphregion(color(white)) ylab(-2(1)4, nogrid) xlab(10(2)18, nogrid)  ///
legend(region(color(white)) cols(1) rows(3) lab(1 "Bachelor's degree") lab(2 "College dropout") lab(3 "High school graduate")) name(Fig1A)

twoway (lpoly demean_edupop logpop if edu == 6, lcolor(gray)) ///
(lpoly demean_edupop logpop if edu == 4, lcolor(blue)) ///
(lpoly demean_edupop logpop if edu == 3, lcolor(red)), ylabel(,nogrid) ///
ytitle("Log skill population (deviation from mean)") xtitle("Metropolitan log population") graphregion(color(white)) ylab(-2(1)4, nogrid) xlab(10(2)18, nogrid)  ///
legend(region(color(white)) cols(1) rows(3) lab(1 "Bachelor's degree") lab(2 "College dropout") lab(3 "High school graduate")) name(Fig1B)

graph combine Fig1A Fig1B, col(2) row(1)  graphregion(color(white))
graph export "../output/`saveas'.pdf", as(pdf) replace

end


cap program drop occpop_graph
program define occpop_graph
syntax, saveas(string)

use "../input/OCCSOC2000.dta", clear
merge m:1 msa using "../input/CMSA_POP2000.dta", keepusing(cmsa_pop)

generate logpop = log(cmsa_pop)

//De-meaning educational group populations
egen mean_logemp = mean(logemp), by(occ_code)
generate demean_emppop = logemp-mean_logemp

capture graph drop fig2A
capture graph drop fig2B

//Generating graphs
twoway (scatter demean_emppop logpop if occ_code == 15, msymbol(sh) mcolor(gray)) ///
(scatter demean_emppop logpop if occ_code == 43, msymbol(th) mcolor(blue)) ///
(scatter demean_emppop logpop if occ_code == 49, msymbol(oh) mcolor(red)), ///
ytitle("Log employment (deviation from mean)") xtitle("Metropolitan log population") graphregion(color(white)) ylab(-4(1)5, nogrid) xlab(10(2)18, nogrid) ///
legend(region(color(white)) cols(1) rows(3) lab(3 "Installation, maintenance and repair") lab(2 "Office and administrative support") lab(1 "Computer and mathematical")) name(fig2A)

twoway (lpoly demean_emppop logpop if occ_code == 15, lcolor(gray)) ///
(lpoly demean_emppop logpop if occ_code == 43, lcolor(blue)) ///
(lpoly demean_emppop logpop if occ_code == 49, lcolor(red)), ///
ytitle("Log employment (deviation from mean)") xtitle("Metropolitan log population") graphregion(color(white)) ylab(-4(1)5, nogrid) xlab(10(2)18, nogrid) ///
legend(region(color(white)) cols(1) rows(3) lab(3 "Installation, maintenance and repair") lab(2 "Office and administrative support") lab(1 "Computer and mathematical")) name(fig2B)

graph combine fig2A fig2B, col(2) row(1)  graphregion(color(white))
graph export "../output/`saveas'.pdf", replace as(pdf)

end


cap program drop naicspop_graph
program define naicspop_graph
syntax, saveas(string)

use "../input/CAC_CBP2000_naics2.dta", clear
ren aggreg_emp emp_indgeo
generate logemp = log(emp_indgeo)

summ logemp
local minner = r(min)
fillin naics msa
tempvar tvar1
bys msa: egen `tvar1' = mode(logpop)
replace logpop = `tvar1' if _fillin==1
replace logemp = `minner'-1 if _fillin==1

keep if naics == 31 | naics == 52 | naics == 54

egen mean_logemp = mean(logemp), by(naics)
generate demean_logemp = logemp - mean_logemp

capture graph drop Fig3A
capture graph drop Fig3B

twoway (scatter demean_logemp logpop if naics == 54, msymbol(sh) mcolor(gray)) ///
(scatter demean_logemp logpop if naics == 52, msymbol(th) mcolor(blue)) ///
(scatter demean_logemp logpop if naics == 31, msymbol(oh) mcolor(red)), ///
ytitle("Log employment (deviation from mean)") xtitle("Metropolitan log population") graphregion(color(white)) ///
ylab(-4(1)5, nogrid) yscale(titlegap(*15)) xscale(titlegap(*5)) xlab(10(2)18, nogrid) name(Fig3A) ///
legend(region(color(white)) cols(1) rows(3) lab(3 "Manufacturing") lab(2 "Finance & Insurance") lab(1 "Professional, Scientific & Technical Services"))

twoway  (lpoly demean_logemp logpop if naics == 54, lcolor(gray)) ///
(lpoly demean_logemp logpop if naics == 52, lcolor(blue)) ///
(lpoly demean_logemp logpop if naics == 31, lcolor(red)), ///
ytitle("Log employment (deviation from mean)") xtitle("Metropolitan log population") graphregion(color(white)) ///
ylab(-4(1)5, nogrid) yscale(titlegap(*15)) xscale(titlegap(*5)) xlab(10(2)18, nogrid) name(Fig3B) ///
legend(region(color(white)) cols(1) rows(3) lab(3 "Manufacturing") lab(2 "Finance & Insurance") lab(1 "Professional, Scientific & Technical Services") symxsize(*0.5))

graph combine Fig3A Fig3B, col(2) row(1) graphregion(color(white))
graph export "../output/`saveas'.pdf", replace as(pdf)

end


cap program drop popelast_3skills_alternative
program define popelast_3skills_alternative
syntax, saveas(string)

/** SF3 column **/
//Total population data
tempfile tf1
use "../input/CMSA_POP2000.dta", clear
save `tf1', replace
//Educational attainment population data
use "../input/MSA_EDU_2000SF3.dta", clear
drop if msa == 1010 | msa == 1890 | msa == 2200 | msa == 2340 | msa == 3700 | msa == 6340 //Dropping the six MSAs that are not considered in the CAC paper due to PUMA mapping issues.
merge 1:1 msa using `tf1', nogen keep(1 3) keepusing(logpop)
expand 3
bys msa: gen edu = _n
gen edupop 		= log(lessgrade9 + grade9to12 + hs) if edu==1
replace edupop 	= log(somecollege + associate)      if edu==2
replace edupop 	= log(ba + master + prof + phd)     if edu==3

popelast_3skill_regandlabels
regress edupop logpopXedu_? edu_?, vce(cluster msa)
outreg2 using "../output/`saveas'.tex", tex(pr landscape frag) replace keep(logpopXedu*) label ctitle(SF3,All) nocons noaster nor2 noobs nonotes

/** FTFY columns **/

//COLUMN 2: Full-time, full-year, 25+ in IPUMS
use "../input/CAC_FTFY_msaedufor_obs.dta", clear
recode edu 1=1 2=1 3=1 4=2 5=2 6=3 7=3 8=3 9=3
collapse (sum) perwt, by(msa edu)
merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keep(1 3) keepusing(logpop)
generate edupop = log(perwt)
popelast_3skill_regandlabels
regress edupop logpopXedu_? edu_?, vce(cluster msa)
outreg2 using "../output/`saveas'.tex", tex(pr landscape frag) append keep(logpopXedu*) label ctitle(IPUMS FTFY, All) nocons noaster nor2 noobs nonotes

//COLUMN 3: Full-time, full-year, 25+ in IPUMS, only US-born people
use "../input/CAC_FTFY_msaedufor_obs.dta", clear
keep if foreign==0
recode edu 1=1 2=1 3=1 4=2 5=2 6=3 7=3 8=3 9=3
collapse (sum) perwt, by(msa edu)
merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keep(1 3) keepusing(logpop)
generate edupop = log(perwt)
popelast_3skill_regandlabels
regress edupop logpopXedu_? edu_?, vce(cluster msa)
outreg2 using "../output/`saveas'.tex", tex(pr landscape frag) append keep(logpopXedu*) label ctitle(IPUMS FTFY, US-born)   nocons noaster nor2 noobs nonotes

end

cap program drop popelast_9skills_alternative
program define popelast_9skills_alternative
syntax, saveas(string)

/** SF3 column **/
//Total population data
tempfile tf1
use "../input/CMSA_POP2000.dta", clear
save `tf1', replace
//Educational attainment population data
use "../input/MSA_EDU_2000SF3.dta", clear
drop if msa == 1010 | msa == 1890 | msa == 2200 | msa == 2340 | msa == 3700 | msa == 6340 //Dropping the six MSAs that are not considered in the CAC paper due to PUMA mapping issues.
merge 1:1 msa using `tf1', nogen keep(1 3) keepusing(logpop)
expand 9
bys msa: gen edu = _n
gen edupop = .
replace edupop 	= log(lessgrade9)      if edu==1
replace edupop 	= log(grade9to12)      if edu==2
replace edupop 	= log(hs)              if edu==3
replace edupop 	= log(somecollege)     if edu==4
replace edupop 	= log(associate)       if edu==5
replace edupop 	= log(ba)              if edu==6
replace edupop 	= log(master)          if edu==7
replace edupop 	= log(prof)            if edu==8
replace edupop 	= log(phd)             if edu==9

popelast_9skill_regandlabels
regress edupop logpopXedu_? edu_?, vce(cluster msa)
outreg2 using "../output/`saveas'.tex", tex(pr landscape frag) replace keep(logpopXedu*) label ctitle(SF3,All) nocons noaster nor2 noobs nonotes

//How often are column 1 elasticities in wrong order?
popelast_9skillsalt_fails

//COLUMN 2: In labor force in IPUMS
use "../input/CAC_FTFY_msaedufor_obs.dta", clear
collapse (sum) perwt, by(msa edu)
merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keep(1 3) keepusing(logpop)
generate edupop = log(perwt)
popelast_9skill_regandlabels
regress edupop logpopXedu_? edu_?, vce(cluster msa)
outreg2 using "../output/`saveas'.tex", tex(pr landscape frag) append keep(logpopXedu*) label ctitle(IPUMS FTFY, All) nocons noaster nor2 noobs nonotes

//How often are column 2 elasticities in wrong order?
popelast_9skillsalt_fails

//COLUMN 3: In labor force IPUMS, only US-born people
use "../input/CAC_FTFY_msaedufor_obs.dta", clear
keep if foreign==0
collapse (sum) perwt, by(msa edu)
merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keep(1 3) keepusing(logpop)
generate edupop = log(perwt)
popelast_9skill_regandlabels
regress edupop logpopXedu_? edu_?, vce(cluster msa)
outreg2 using "../output/`saveas'.tex", tex(pr landscape frag) append keep(logpopXedu*) label ctitle(IPUMS FTFY, US-born)   nocons noaster nor2 noobs nonotes

//How often are column 3 elasticities in wrong order?
popelast_9skillsalt_fails

end

cap program drop popelast_9skillsalt_fails
program define popelast_9skillsalt_fails

mat fails = (0)
forvalues x = 1/9{
	forvalues y = `x'/9{
		if _b[logpopXedu_`x'] > _b[logpopXedu_`y'] {
			qui test (logpopXedu_`x' = logpopXedu_`y')
			local result = r(p)
			if `result' <= .05 mat fails = fails + (1)
			if `result' <= .05 test (logpopXedu_`x' = logpopXedu_`y')
		}
	}
}
mat list fails

end
