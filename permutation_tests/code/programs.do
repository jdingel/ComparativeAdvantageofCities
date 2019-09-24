//This program generates pairs of observations that are indexed by "id" and have covariates.
//Use this program to generate pairs of cities for population differences or pairs of occupations for skill-intensity differences
cap program drop generatepairwise
program define generatepairwise

syntax, id(varname) covariates(varlist)

tempfile tf0 tf1 tf2
save `tf0', replace
foreach var of varlist `id' `covariates' {
	ren `var' `var'_1
}
save `tf1', replace
use `tf0', clear
foreach var of varlist `id' `covariates' {
	ren `var' `var'_2
}
save `tf2', replace
keep `id'_2
gen `id'_1 = `id'_2
fillin `id'_?
merge m:1 `id'_1 using `tf1', nogen keepusing(`covariates')
merge m:1 `id'_2 using `tf2', nogen keepusing(`covariates')
drop _fillin
order `id'_1 `id'_2 *_1 *_2
sort `id'_1 `id'_2

end

cap program drop generatepairwise2
program define generatepairwise2

syntax, id(varname) [id2(varname)] covariates(varlist)

tempfile tf0 tf1 tf2
save `tf0', replace
foreach var of varlist `id' `covariates' {
	ren `var' `var'_1
}
save `tf1', replace
use `tf0', clear
foreach var of varlist `id' `covariates' {
	ren `var' `var'_2
}
save `tf2', replace
keep `id'_2 `id2'
gen `id'_1 = `id'_2
fillin `id'_? `id2'
merge m:1 `id'_1 `id2' using `tf1', nogen keepusing(`covariates')
merge m:1 `id'_2 `id2' using `tf2', nogen keepusing(`covariates')
drop _fillin
order `id'_1 `id'_2 `id2' *_1 *_2
sort `id'_1 `id'_2 `id2'

end

//MLR TEST
//Version: 0.65
//Author: Jonathan Dingel (jonathan.dingel at gmail)
//Date: 27 March 2016 (0.65), 29 Dec 2015 (0.6), 1 October 2014 (0.5)
//Updates: Version 0.6 added quotation marks in save "`filename'.dta", replace
//Updates: Version 0.65 uses clonevar rather than gen "`var'_2 = `var'_1"
//Purpose: Indicate whether observations satisfies the inequality that defines supermodularity

	//This program checks whether value(xvalue,yvalue) is a supermodular function
	//It supports looking at value(x,y), where x and y may index units without ordering them (e.g. x = msa, xvalue = msa population)
	//To check log-supermodularity, use the "logsupermodular" option
	//If you're investigating log-supermodularity, but your observations are already log values, then just check supermodularity of the log values
	//The program assumes that the data consist of a series of observations of value(x,y); the program will generating all the pairwise combinations to check supermodularity

cap program drop supermodularitycheck
program define supermodularitycheck
	syntax [if], x(varname) y(varname) value(varname) [xvalue(varname) yvalue(varname)] [testoutcome(string) filename(string)] [logsupermodular]

	//As of this version, the program doesn't verify that the inputs are of valid form!
	tempfile tforiginal tf0 tf1 tf2 tf3
	save `tforiginal', replace						//Preserve data in memory at time of program call
	if "`if'"~="" keep `if'								//Impose the if condition when specified
	keep `x' `y' `xvalue' `yvalue' `value'				//Keep only variables needed for MLR test
	save `tf0', replace

	//If xvalue or yvalue not specified, rank by x or y
	if "`xvalue'"=="" local xvalue = "`x'"
	if "`yvalue'"=="" local yvalue = "`y'"

	//Create all pairwise combinations to make comparisons
	keep `x' `y'
	tempfile tf_cross
	ren (`x' `y') (`x'_2 `y'_2)
	save `tf_cross', replace
	ren (`x'_2 `y'_2) (`x'_1 `y'_1)
	cross using `tf_cross'

	//Retain pairs in which xvalue2>xvalue1 and yvalue2>yvalue1
	if ("`x'"~="`xvalue'")|("`y'"~="`yvalue'") {
		forvalues i=1/2 {
			gen `x' = `x'_`i'
			gen `y' = `y'_`i'
			qui merge m:1 `x' `y' using `tf0', keep(1 3) nogen keepusing (`xvalue' `yvalue')
			drop `x' `y'
			if "`x'"~="`xvalue'" ren `xvalue' `xvalue'_`i'
			if "`y'"~="`yvalue'" ren `yvalue' `yvalue'_`i'
		}
	}
	keep if `xvalue'_2 > `xvalue'_1 & `yvalue'_2 > `yvalue'_1 & (`xvalue'_2 ~=. & `xvalue'_1 ~=. & `yvalue'_2 ~=. & `yvalue'_1 ~=.)
	keep `x'_1 `y'_1 `x'_2 `y'_2

	//Load f(x,y) data and check whether f(x1,y1)+f(x2,y2)>=f(x1,y2)+f(x2,y1)
	forvalues i=1/2 {
		forvalues j=1/2 {
			gen `x' = `x'_`i'
			gen `y' = `y'_`j'
			qui merge m:1 `x' `y' using `tf0', keep(1 3) nogen keepusing(`value')
			ren `value' `value'_`i'`j'
			drop `x' `y'
		}
	}

	if "`logsupermodular'"==""				 	gen `testoutcome' = (`value'_22 + `value'_11 >= `value'_21 + `value'_12) if (`value'_22~=. & `value'_11~=. & `value'_21~=. & `value'_12~=. )
	if "`logsupermodular'"=="logsupermodular"	gen `testoutcome' = (`value'_22 * `value'_11 >= `value'_21 * `value'_12) if (`value'_22~=. & `value'_11~=. & `value'_21~=. & `value'_12~=. )
	//Reports results
	if "`filename'"=="" summ `testoutcome'	//Display the average success if we aren't recording results for each observation
	if "`filename'"~="" {
		keep `x'_? `y'_? `testoutcome'
		save `filename', replace
	}

	use `tforiginal', clear

end
