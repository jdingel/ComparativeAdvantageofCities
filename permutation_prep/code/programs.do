//This program generates pairs of observations that are indexed by "id" and have covariates.
//Use this program to generate pairs of cities for population differences or pairs of occupations for skill-intensity differences
cap program drop generatepairwise
program define generatepairwise

syntax, id(varname) covariates(varlist)

tempfile tf0 tf1 tf2
save `tf0'.dta, replace
foreach var of varlist `id' `covariates' {
	ren `var' `var'_1
}
save `tf1'.dta, replace
use `tf0'.dta, clear
foreach var of varlist `id' `covariates' {
	ren `var' `var'_2
}
save `tf2'.dta, replace
keep `id'_2
gen `id'_1 = `id'_2
fillin `id'_?
merge m:1 `id'_1 using `tf1'.dta, nogen keepusing(`covariates')
merge m:1 `id'_2 using `tf2'.dta, nogen keepusing(`covariates')
drop _fillin
order `id'_1 `id'_2 *_1 *_2
sort `id'_1 `id'_2

end

cap program drop generatepairwise2
program define generatepairwise2

syntax, id(varname) [id2(varname)] covariates(varlist)

tempfile tf0 tf1 tf2
save `tf0'.dta, replace
foreach var of varlist `id' `covariates' {
	ren `var' `var'_1
}
save `tf1'.dta, replace
use `tf0'.dta, clear
foreach var of varlist `id' `covariates' {
	ren `var' `var'_2
}
save `tf2'.dta, replace
keep `id'_2 `id2'
gen `id'_1 = `id'_2
fillin `id'_? `id2'
merge m:1 `id'_1 `id2' using `tf1'.dta, nogen keepusing(`covariates')
merge m:1 `id'_2 `id2' using `tf2'.dta, nogen keepusing(`covariates')
drop _fillin
order `id'_1 `id'_2 `id2' *_1 *_2
sort `id'_1 `id'_2 `id2'

end
