
cap program drop wagebins_estarray
program define wagebins_estarray

syntax, saveas(string) [deflate]

use year statefip puma edu foreign perwt age empstat gq incwage wkswork1 uhrswork using "../input/IPUMS2000.dta", clear
keep if age >= 25 & empstat<=2  //Labor-force participants over age 25
keep if wkswork>=40 & uhrswork>=35 //Full-time full-year specification only
drop if gq == 3 | gq == 4
gen hourlywage = incwage/(wkswork1*uhrswork)
keep if hourlywage>2 //Drop people who make less than $2/hour
if "`deflate'"=="deflate" {
	merge m:1 statefip puma using "../input/PUMA2000-MSA2000.dta", assert(match) nogen keepusing(msa_code)
	bys msa_code: egen deflator = pctile(hourlywage), p(5)
	replace hourlywage = hourlywage / deflator
	drop msa_code
}
egen hourlywage_group = cut(hourlywage), group(20)
replace hourlywage_group = hourlywage_group + 1 //label deciles 1 to 10 instead of 0 to 9
keep year statefip puma hourlywage_group foreign perwt
merge m:1 statefip puma using "../input/PUMA2000-MSA2000.dta", assert(match) nogen keepusing(msa_code)
drop if missing(msa_code) | msa_code==9999 //This drops individuals who are located in PUMAs that are not assigned to any CBSA.
drop statefip puma
ren msa_code msa
merge m:1 msa using "../input/CMSA_POP2000.dta", nogen assert(using match) keep(match) keepusing(cmsa_pop)
collapse (sum) perwt, by(year msa hourlywage_group foreign)
label data "Full-time full-year employees over age 25"
save "`saveas'", replace

end

cap program drop popelast_wagebins_countfails //CAC_table4_countfails
program define popelast_wagebins_countfails //CAC_table4_countfails

mat fails = (0)
forvalues x = 1/10{
	forvalues y = `x'/10{
		if _b[logpopXwagebin_`x'] > _b[logpopXwagebin_`y'] {
			qui test (logpopXwagebin_`x' = logpopXwagebin_`y')
			local result = r(p)
			if `result' <= .05 mat fails = fails + (1)
			if `result' <= .05 test (logpopXwagebin_`x' = logpopXwagebin_`y')
		}
	}
}
mat list fails

end

cap program drop popelasticities_wagebins
program define popelasticities_wagebins
syntax using/, saveas(string) [append]

if "`append'"=="" local append = "replace"

//COLUMN 1: In labor force in IPUMS
use "`using'", clear
collapse (sum) perwt, by(year msa hourlywage_group)
merge m:1 msa using "../input/CMSA_POP2000.dta", assert(using match) keep(match) keepusing(logpop) nogen
generate wagepop = log(perwt)
qui summ hourlywage_group
local group = "group"
if `r(max)'==10 local group = "decile"
if `r(max)'==20 local group = "ventile"
forvalues i = 1/`r(max)' {
	gen logpopXwagebin_`i' = logpop * (hourlywage_group==`i')
	label var logpopXwagebin_`i' "\$\beta_{\omega `i'}\$ wage `group' `i' \$\times\$ log population"
}
tab hourlywage_group, gen(wagegroup_)
regress wagepop logpopXwagebin_* wagegroup_*, vce(cluster msa)
outreg2 using "`saveas'.tex", tex(pr landscape frag) `append' keep(logpopXwagebin_*) label ctitle(All) nocons noaster nor2 noobs nonotes
//How often are column 1 elasticities in wrong order?
popelast_wagebins_countfails

//COLUMN 2: In labor force IPUMS, only US-born people
use "`using'", clear
keep if foreign==0
collapse (sum) perwt, by(year msa hourlywage_group)
merge m:1 msa using "../input/CMSA_POP2000.dta", assert(using match) keep(match) keepusing(logpop) nogen
generate wagepop = log(perwt)
qui summ hourlywage_group
local group = "group"
if `r(max)'==10 local group = "decile"
if `r(max)'==20 local group = "ventile"
forvalues i = 1/`r(max)' {
	gen logpopXwagebin_`i' = logpop * (hourlywage_group==`i')
	label var logpopXwagebin_`i' "\$\beta_{\omega `i'}\$ wage `group' `i' \$\times\$ log population"
}
tab hourlywage_group, gen(wagegroup_)
regress wagepop logpopXwagebin_* wagegroup_*, vce(cluster msa)
outreg2 using "`saveas'.tex", tex(pr landscape frag) append keep(logpopXwagebin_*) label ctitle(US-born)   nocons noaster nor2 noobs nonotes
//How often are column 2 elasticities in wrong order?
popelast_wagebins_countfails

end
