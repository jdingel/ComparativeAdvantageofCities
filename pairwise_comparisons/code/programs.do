/****
Created by: Luis Costa/Jonathan Dingel
****/

/***********************
** PROGRAMS FOR PROGRAMS
***********************/

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


/***********************
** PROGRAMS FOR CALLS
***********************/

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
		save "`filename'.dta", replace
	}

	use `tforiginal', clear

end




cap program drop pairwisecomparisons_3skills
program define pairwisecomparisons_3skills
syntax, using(string) saveas(string) eduforfile(string) msapopdif(string)

//Prepare file denoting assignments of MSAs to MSA-group bins
tempfile tf_binassignments
use "`using'", clear
drop if substr(msa_name,-7,7)=="PR CMSA"|substr(msa_name,-6,6)=="PR MSA" //Dropping Puerto Rican CMSAs and MSAs
drop if msa == 1010 | msa == 1890 | msa == 2200 | msa == 2340 | msa == 3700 | msa == 6340 //Dropping the six MSAs that are not considered in the CAC paper due to PUMA mapping issues.
keep msa cmsa_pop
gen logpop = log(cmsa_pop)
foreach bin in 2 3 5 10 30 90 270 {
	xtile msagroup`bin' = logpop, nq(`bin')
}
label data "Assignments of MSAs to MSA-group bins"
save `tf_binassignments', replace

tempfile tfus tfall

//Prepare file for US-born observations
use "`eduforfile'", clear
gen edu2 = edu
recode edu2 1=1 2=1 3=1 4=2 5=2 6=3 7=3 8=3 9=3
keep if foreign == 0
collapse (sum) perwt, by(msa edu2)
gen logperwt = log(perwt)
merge m:1 msa using `tf_binassignments', nogen keep(1 3) keepusing(msagroup* cmsa_pop logpop)
label define edu2_aggregated_categories 1 "High school or less" 2 "Some college" 3 "Bachelor's or more"
label values edu2 edu2_aggregated_categories
label data "US-born labor-force participants over age 25 and the MSA population size"
save `tfus', replace
//Prepare file for all-born observations
use "`eduforfile'", clear
gen edu2 = edu
recode edu2 1=1 2=1 3=1 4=2 5=2 6=3 7=3 8=3 9=3
collapse (sum) perwt, by(msa edu2)
gen logperwt = log(perwt)
merge m:1 msa using `tf_binassignments', nogen keep(1 3) keepusing(msagroup* cmsa_pop logpop)
label define edu2_aggregated_categories 1 "High school or less" 2 "Some college" 3 "Bachelor's or more"
label values edu2 edu2_aggregated_categories
label data "All-born labor-force participants over age 25 and the MSA population size"
save `tfall', replace

foreach filetype in us all {
	foreach bin in 2 3 5 10 30 90 270 {
		tempfile tf1 tf`filetype'_bin`bin'
		use `tf`filetype'', clear
		gen msas_in_bin = 1
		collapse (sum) logpop logperwt msas_in_bin, by(edu2 msagroup`bin')
		gen logperwt_avg = logperwt / msas_in_bin
		ren msagroup`bin' msagroup

		supermodularitycheck, x(edu2) y(msagroup) value(logperwt_avg) ///
													xvalue(edu2) yvalue(msagroup) testoutcome(outcome_dummy) ///
													filename("../output/temp")

		use "../output/temp.dta", clear
		gen bins = `bin'
		gen type = "`filetype'"
		egen comparisons = total(missing(outcome_dummy)==0)

		//MERGING WITH MSA POPULATION DIFFERENCES
		merge m:1 bins msagroup_1 msagroup_2 using "`msapopdif'", nogen keep(1 3) keepusing(pop_log_diff)

		//Computing unweighted mean and manually creating weighted means in order to avoid having to collapse and re-merge
		bys edu2_?: egen outcome = mean(outcome_dummy)
		by  edu2_?: egen tot_popdiff = total(pop_log_diff)
		by  edu2_?: egen outcome_popdiff = total(pop_log_diff * outcome_dummy / tot_popdiff)
		collapse (firstnm) outcome outcome_popdiff comparisons, by(bin type edu2_?)

		save `tf`filetype'_bin`bin'', replace

	}
}

clear
foreach filetype in us all {
	foreach bin in 2 3 5 10 30 90 270 {
		append using `tf`filetype'_bin`bin''
	}
}

ren outcome outcome1
ren outcome_popdiff outcome2
reshape long outcome, i(bins type edu2_1 edu2_2) j(weights)
recode weights 1=0 2=1
gen j = 1*(edu2_1==1 & edu2_2==2) + 2*(edu2_1==1 & edu2_2==3) + 3*(edu2_1==2 & edu2_2==3)
drop edu2_?
bys bins weights type: egen average = mean(outcome)
reshape wide outcome, i(bins type weights) j(j)
label variable outcome1 "Some college vs HS or less "
label variable outcome2 "College vs HS or less "
label variable outcome3 "College vs some college"

sort bins
compress
desc
label data "Pairwise comparisons of 3 educational groups (ILF)"
saveold "../output/`saveas'.dta", replace

use "../output/`saveas'.dta", clear
ren average outcome
keep bins type comparisons outcome weights
reshape wide outcome, i(bins type) j(weights)
ren outcome0 outcome
ren outcome1 outcome_popdiff
save "../output/`saveas'_reshape.dta", replace

end

cap program drop pairwisecomparisons_9skills
program define pairwisecomparisons_9skills
syntax, using(string) saveas(string) eduforfile(string) msapopdif(string)

//Prepare file denoting assignments of MSAs to MSA-group bins
tempfile tf_binassignments
use "`using'", clear
drop if substr(msa_name,-7,7)=="PR CMSA"|substr(msa_name,-6,6)=="PR MSA" //Dropping Puerto Rican CMSAs and MSAs
drop if msa == 1010 | msa == 1890 | msa == 2200 | msa == 2340 | msa == 3700 | msa == 6340 //Dropping the six MSAs that are not considered in the CAC paper due to PUMA mapping issues.
keep msa cmsa_pop
gen logpop = log(cmsa_pop)
foreach bin in 2 3 5 10 30 90 270 {
	xtile msagroup`bin' = logpop, nq(`bin')
}
label data "Assignments of MSAs to MSA-group bins"
save `tf_binassignments', replace

//Prepare education share weights file for weights
tempfile tf_weights_all_edushares tf_edu_1 tf_edu_2
use "`eduforfile'", clear
collapse (sum) perwt, by(edu)
egen total = total(perwt)
gen edushare = perwt / total
generatepairwise, id(edu) covariates(edushare)
gen edu_share_weight = edushare_1 * edushare_2
keep edu_? edu_share_weight
label data "Education-share weights"
save `tf_weights_all_edushares', replace

//Prepare education share weights file for US-born weights
tempfile tf_weights_us_edushares tf_edu_1 tf_edu_2
use "`eduforfile'", clear
drop if foreign==1
collapse (sum) perwt, by(edu)
egen total = total(perwt)
gen edushare = perwt / total
generatepairwise, id(edu) covariates(edushare)
gen edu_share_weight = edushare_1 * edushare_2
keep edu_? edu_share_weight
label data "Education-share weights for US-born"
save `tf_weights_us_edushares', replace

tempfile tfus tfall

//Prepare file for US-born observations
use "`eduforfile'", clear
keep if foreign == 0
collapse (sum) perwt, by(msa edu)
gen logperwt = log(perwt)
merge m:1 msa using `tf_binassignments', nogen keep(1 3) keepusing(msagroup* cmsa_pop logpop)
label data "US-born labor-force participants over age 25 and the MSA population size"
save `tfus', replace
//Prepare file for all-born observations
use "`eduforfile'", clear
collapse (sum) perwt, by(msa edu)
gen logperwt = log(perwt)
merge m:1 msa using `tf_binassignments', nogen keep(1 3) keepusing(msagroup* cmsa_pop logpop)
save `tfall', replace

foreach filetype in us all {
	foreach bin in 2 3 5 10 30 90 270 {
		tempfile tf1 tf`filetype'_bin`bin'
		use `tf`filetype'', clear
		gen msas_in_bin = 1
		collapse (sum) logpop logperwt msas_in_bin, by(edu msagroup`bin')
		gen logperwt_avg = logperwt / msas_in_bin
		ren msagroup`bin' msagroup

		supermodularitycheck, x(edu) y(msagroup) value(logperwt_avg) ///
										xvalue(edu) yvalue(msagroup) testoutcome(outcome_dummy) ///
										filename("../output/temp")

		use "../output/temp.dta", clear
		gen bins = `bin'
		gen type = "`filetype'"
		egen comparisons = total(missing(outcome_dummy)==0)

		//MERGING WITH EDUCATIONAL GROUP DIFFERENCES AND MSA POPULATION DIFFERENCES//
		merge m:1 bins msagroup_1 msagroup_2 using "`msapopdif'", nogen keep(1 3) keepusing(pop_log_diff)
		merge m:1 edu_1 edu_2 using `tf_weights_`filetype'_edushares', nogen keep(1 3) keepusing(edu_share_weight)

		//Computing unweighted mean
		egen outcome = mean(outcome_dummy)

		//MANUALLY CREATING WEIGHTED MEANS IN ORDER TO AVOID HAVING TO COLLAPSE AND RE-MERGE
		egen tot_popdiff = total(pop_log_diff)
		egen outcome_popdiff = total(pop_log_diff * outcome_dummy / tot_popdiff)

		gen edusharepopdiffweight = edu_share_weight*pop_log_diff
		egen tot_edusharepopdiffweight = total(edusharepopdiffweight)
		egen outcome_popedu = total(edusharepopdiffweight * outcome_dummy / tot_edusharepopdiffweight)
		save `tf1', replace

		collapse (firstnm) outcome outcome_popdiff outcome_popedu comparisons, by(bin type)

		save `tf`filetype'_bin`bin'', replace

	}
}

clear
foreach filetype in us all {
	foreach bin in 2 3 5 10 30 90 270 {
		append using `tf`filetype'_bin`bin''
	}
}

sort bin
compress
desc
label data "Pairwise comparisons of 9 educational groups (ILF)"
saveold "../output/`saveas'.dta", replace

end




cap program drop pairwisecomparisons_occupations
program define pairwisecomparisons_occupations

syntax, using(string) saveas(string) skillint(string) msapopdif(string) secusing(string)

//Prepare file denoting assignments of MSAs to MSA-group bins
tempfile tf_binassignments
use "`using'", clear
drop if substr(msa_name,-7,7)=="PR CMSA"|substr(msa_name,-6,6)=="PR MSA" //Dropping Puerto Rican CMSAs and MSAs
keep msa cmsa_pop
gen logpop = log(cmsa_pop)
foreach bin in 2 3 5 10 30 90 276 {
	xtile msagroup`bin' = logpop, nq(`bin')
}
label data "Assignments of MSAs to MSA-group bins"
save `tf_binassignments', replace

//Generate skill difference weights
tempfile tf_skill1 tf_skill2 tf_skilldifference
use "`skillint'", clear
generatepairwise, id(occ_code) covariates(skillintensity)
gen skillintensity_difference = abs(skillintensity_1 - skillintensity_2)
save `tf_skilldifference', replace

//Load employment data, merge with skill intensities and population sizes
tempfile tf_holdon
use "`secusing'", clear
merge m:1 msa using "`using'", keepusing(cmsa_pop)

keep occ_code msa emp_occgeo cmsa_pop
merge m:1 occ_code using "`skillint'", nogen keep(3) keepusing(skillintensity)
ren msa msa
merge m:1 msa using `tf_binassignments', nogen keep(1 3) keepusing(msagroup* cmsa_pop logpop)
//Generate skill-intensity ranks
tempfile tf1 tf2
save `tf1', replace
collapse (firstnm) skillintensity, by(occ_code)
egen skillintensityrank = rank(skillintensity)
save `tf2', replace
use `tf1', clear
merge m:1 occ_code using `tf2', keepusing(skillintensityrank) nogen
save `tf_holdon', replace

foreach bin in 2 3 5 10 30 90 276 { //
	tempfile tf_`bin'bin
	use `tf_holdon', clear
	gen msas_in_bin = 1
	collapse (sum) emp_occgeo msas_in_bin (first) skillintensityrank, by(occ_code msagroup`bin')
	gen emp_occgeo_average = emp_occgeo / msas_in_bin
	ren msagroup`bin' msagroup
	supermodularitycheck, x(occ_code) y(msagroup) value(emp_occgeo_average) ///
							xvalue(skillintensityrank) yvalue(msagroup) testoutcome(outcome) ///
							logsupermodular filename("../output/LSM_temp")
	use "../output/LSM_temp.dta", clear
	gen bins = `bin'
	egen comparisons = total(missing(outcome)==0)
	merge m:1 bins msagroup_1 msagroup_2 using "`msapopdif'", keep(1 3) nogen keepusing(pop_log_diff)
	tempvar tv_numer tv_denom tv_numer2 tv_denom2
	egen `tv_numer' = total(outcome * pop_log_diff)
	egen `tv_denom' = total(pop_log_diff)
	gen outcome_popdiff = `tv_numer' / `tv_denom'
	merge m:1 occ_code_1 occ_code_2 using `tf_skilldifference', keep(1 3) nogen keepusing(skillintensity_difference)
	egen `tv_numer2' = total(outcome * pop_log_diff * skillintensity_difference)
	egen `tv_denom2' = total(pop_log_diff * skillintensity_difference)
	gen outcome_popdiffskilldiff = `tv_numer2' / `tv_denom2'
	collapse (mean) outcome (firstnm) outcome_popdiff* bins comparisons
	save `tf_`bin'bin', replace
}

use `tf_2bin', clear
foreach bin in 3 5 10 30 90 276 {
	append using `tf_`bin'bin'
}

save "../output/`saveas'_occupations.dta", replace

end

cap program drop pairwisecomparisons_industries //CAC_table12
program define pairwisecomparisons_industries //CAC_table12
syntax, using(string) saveas(string) ///
	skillint(string) secusing(string) msapopdif(string)

//Prepare file denoting assignments of MSAs to MSA-group bins
tempfile tf_binassignments
use "`using'", clear
drop if substr(msa_name,-7,7)=="PR CMSA"|substr(msa_name,-6,6)=="PR MSA" //Dropping Puerto Rican CMSAs and MSAs
keep msa cmsa_pop
gen logpop = log(cmsa_pop)
foreach bin in 2 3 5 10 30 90 276 {
	xtile msagroup`bin' = logpop, nq(`bin')
}
label data "Assignments of MSAs to MSA-group bins"
save `tf_binassignments', replace

//Generate skill difference weights
tempfile tf_skill1 tf_skill2 tf_skilldifference
use "`skillint'", clear
generatepairwise, id(naics) covariates(skillintensity)
gen skillintensity_difference = abs(skillintensity_1 - skillintensity_2)
save `tf_skilldifference', replace

//Load employment data, merge with skill intensities and population sizes
tempfile tf_holdon
use "`secusing'", clear
rename aggreg_emp emp_indgeo
rename cmsa_pop pop
keep naics msa emp_indgeo pop censored
drop if naics==95 | naics==99
merge m:1 naics using "`skillint'", nogen keep(3) keepusing(skillintensity) //This drops naics==95 is auxiliary establishments in CBP; naics==99 is unclassified
ren msa msa
merge m:1 msa using `tf_binassignments', nogen keep(1 3) keepusing(msagroup* cmsa_pop logpop)
//Generate skill-intensity ranks
tempfile tf1 tf2
save `tf1', replace
collapse (firstnm) skillintensity, by(naics)
egen skillintensityrank = rank(skillintensity)
save `tf2', replace
use `tf1', clear
merge m:1 naics using `tf2', keepusing(skillintensityrank) nogen
save `tf_holdon', replace

foreach bin in 2 3 5 10 30 90 276 { //
	tempfile tf_`bin'bin
	use `tf_holdon', clear
	gen msas_in_bin = 1
	collapse (sum) emp_indgeo msas_in_bin (first) skillintensityrank, by(naics msagroup`bin')
	gen emp_indgeo_average = emp_indgeo / msas_in_bin
	ren msagroup`bin' msagroup
	supermodularitycheck, x(naics) y(msagroup) value(emp_indgeo_average) ///
						xvalue(skillintensityrank) yvalue(msagroup) testoutcome(outcome) ///
						logsupermodular filename("../output/LSM_temp")
	use "../output/LSM_temp.dta", clear
	gen bins = `bin'
	egen comparisons = total(missing(outcome)==0)
	merge m:1 bins msagroup_1 msagroup_2 using "`msapopdif'", keep(1 3) nogen keepusing(pop_log_diff)
	tempvar tv_numer tv_denom tv_numer2 tv_denom2
	egen `tv_numer' = total(outcome * pop_log_diff)
	egen `tv_denom' = total(pop_log_diff)
	gen outcome_popdiff = `tv_numer' / `tv_denom'
	merge m:1 naics_1 naics_2 using `tf_skilldifference', keep(1 3) nogen keepusing(skillintensity_difference)
	egen `tv_numer2' = total(outcome * pop_log_diff * skillintensity_difference)
	egen `tv_denom2' = total(pop_log_diff * skillintensity_difference)
	gen outcome_popdiffskilldiff = `tv_numer2' / `tv_denom2'
	collapse (mean) outcome (firstnm) outcome_popdiff* bins comparisons
	save `tf_`bin'bin', replace
}

use `tf_2bin', clear
foreach bin in 3 5 10 30 90 276 {
	append using `tf_`bin'bin'
}

save "../output/`saveas'_naics2.dta", replace
end



cap program drop permutation_results
program define permutation_results

syntax, resultstable(string) permutationstem(string) filename(string) [thirdweight(string)] highestbin(integer) [keepif(string)] [extravar(string)]

	if "`thirdweight'"~="" local outcomethirdweight = "outcome_`thirdweight'"

	foreach b in 2  3 5 10  30  90 `highestbin' {
	foreach w in outcome outcome_popdiff `outcomethirdweight' {
			tempfile tf1
			use "`permutationstem'`b'.dta", clear
			duplicates drop `w', force

			save `tf1', replace
			tempfile tf`b'_`w'
			use "`resultstable'", clear
			if "`keepif'"~="" keep if `keepif'
			keep if bins == `b'	//This restricts attention to the relevant set of results

			nearmrg using `tf1', nearvar(`w') lower
			keep if bins == `b'	//This retains only successful merges
			if "`w'" == "outcome"               keep bins `extravar' emp_pctile
			if "`w'" == "outcome_popdiff"       keep bins `extravar' emp_pctile_popdiff
			if "`w'" == "`outcomethirdweight'" keep bins `extravar' emp_pctile_`thirdweight'
			gen `w'_pvalue = 1 - emp_pctile

			save `tf`b'_`w'', replace

		}

		tempfile tf`b'
		clear
		foreach w in outcome outcome_popdiff `outcomethirdweight' {
			append using `tf`b'_`w''
			collapse (firstnm) outcome*, by(bins `extravar')
		}
		save `tf`b'', replace
	}
	tempfile tf_resultstable_keepif
	use "`resultstable'", clear
	if "`keepif'"~="" keep if `keepif'
	save `tf_resultstable_keepif', replace
	clear
	foreach b in 2 3 5 10 30 90 `highestbin' {
		append using `tf`b'',
	}
	duplicates drop
	merge 1:1 bins `extravar' using `tf_resultstable_keepif', nogen

compress
desc
label data "Table with pvalues from permutation test included"
saveold "`filename'", replace

end



//Combines p-values for all-inclusive and us-born-only permutation tests for three and nine educational groups.
cap program drop combineusforeign
program define combineusforeign
syntax, saveas_3skill(string) saveas_9skill(string)

tempfile tf1
use "../output/`saveas_3skill'_all_pvalues.dta", clear
keep if type=="all"
save `tf1', replace
use "../output/`saveas_3skill'_US_pvalues.dta", clear
keep if type=="us"
append using `tf1'
sort bins type
order bins type outcome outcome_pvalue outcome_popdiff outcome_popdiff_pvalue
save "../output/`saveas_3skill'_pvalues.dta", replace

tempfile tf2
use "../output/`saveas_9skill'_all_pvalues.dta", clear
keep if type=="all"
save `tf2', replace
use "../output/`saveas_9skill'_US_pvalues.dta", clear
keep if type=="us"
append using `tf2'
sort bins type
order bins type outcome outcome_pvalue outcome_popdiff outcome_popdiff_pvalue outcome_popedu outcome_popedu_pvalue
save "../output/`saveas_9skill'_pvalues.dta", replace

end


cap program drop pairwisecomp_edu_appendix_tex
program define pairwisecomp_edu_appendix_tex
syntax using/, tabnum(integer) filename(string)

use `using', clear

if `tabnum'==4 {

	reshape wide outcome outcome_pvalue outcome_popdiff outcome_popdiff_pvalue, i(bins) j(type, string)
	order bins comparisons outcomeall outcome_pvalueall outcomeus outcome_pvalueus outcome_popdiffall outcome_popdiff_pvalueall outcome_popdiffus outcome_popdiff_pvalueus
	foreach var of varlist outcome* {
	  generate `var'_str = string(`var',"%9.2f")
	  replace `var'_str = subinstr(`var'_str,"0.",".",1)
	}
	drop  outcomeall outcomeus outcome_popdiffall outcome_popdiffus  outcome_pvalueus outcome_popdiff_pvalueus outcome_pvalueall outcome_popdiff_pvalueall
	foreach var of varlist outcomeall_str - outcome_popdiff_pvalueus_str {
	  local newname = substr("`var'",1,strpos("`var'","_str")-1)
	  rename `var' `newname'
	}
	foreach var of varlist outcome_pvalueus outcome_popdiff_pvalueus  outcome_pvalueall outcome_popdiff_pvalueall  {
	  replace `var' = "("+`var'+")"
	}
	expand 2
	quietly bysort bins comparisons:  gen dup = cond(_N==1,0,_n)
	order bins dup
	sort  bins dup
	foreach var of varlist bins comparisons  {
	  replace `var'=. if dup==2
	}
	foreach var of varlist outcomeall outcomeus outcome_popdiffall outcome_popdiffus  {
	  replace `var'="" if dup==2
	}
	replace outcomeall = outcome_pvalueall if dup==2
	drop outcome_pvalueall
	replace outcomeus = outcome_pvalueus if dup==2
	drop outcome_pvalueus
	replace outcome_popdiffall = outcome_popdiff_pvalueall if dup==2
	drop outcome_popdiff_pvalueall
	replace outcome_popdiffus = outcome_popdiff_pvalueus if dup==2
	drop outcome_popdiff_pvalueus
	drop dup

	listtex bins comparisons outcomeall outcomeus outcome_popdiffall outcome_popdiffus  ///
	using "`filename'_appendix.tex", replace rstyle(tabular) ///
	head("\begin{tabular}{cccccc}" "\multicolumn{6}{c}{Pairwise comparisons of three skill groups} \\ \hline" ///
	"&Total          & \multicolumn{2}{c}{Unweighted} & \multicolumn{2}{c}{Pop-diff-weighted}  \\" ///
	"Bins&comparisons& All  & US-born & All  & US-born  \\ \hline") ///
	foot("\hline \end{tabular}")

	listtex bins comparisons  outcome_popdiffall outcome_popdiffus  ///
	using "`filename'_main.tex", replace rstyle(tabular) ///
	head("\begin{tabular}{cccc}" "\multicolumn{4}{c}{Pairwise comparisons of three skill groups} \\ \hline" ///
	"&Total          & \multicolumn{2}{c}{Pop-diff-weighted}  \\" ///
	"Bins&comparisons& All  & US-born  \\ \hline") ///
	foot("\hline \end{tabular}")

}

if `tabnum'==6 {

	reshape wide outcome outcome_pvalue outcome_popdiff outcome_popdiff_pvalue outcome_popedu outcome_popedu_pvalue, i(bins) j(type, string)
	order bins comparisons outcomeall outcome_pvalueall outcomeus outcome_pvalueus outcome_popdiffall outcome_popdiff_pvalueall outcome_popdiffus outcome_popdiff_pvalueus ///
	outcome_popeduall outcome_popedu_pvalueall outcome_popeduus outcome_popedu_pvalueus
	foreach var of varlist outcome* {
		generate `var'_str = string(`var',"%9.2f")
		replace `var'_str = subinstr(`var'_str,"0.",".",1)
	}
	drop  outcomeall outcomeus outcome_popdiffall outcome_popdiffus outcome_popeduall outcome_popeduus outcome_pvalueus outcome_popdiff_pvalueus outcome_popedu_pvalueus outcome_pvalueall outcome_popdiff_pvalueall outcome_popedu_pvalueall
	foreach var of varlist outcomeall_str - outcome_popedu_pvalueus_str {
		local newname = substr("`var'",1,strpos("`var'","_str")-1)
		rename `var' `newname'
	}
	foreach var of varlist outcome_pvalueus outcome_popdiff_pvalueus outcome_popedu_pvalueus outcome_pvalueall outcome_popdiff_pvalueall outcome_popedu_pvalueall {
		replace `var' = "("+`var'+")"
	}
	expand 2
	quietly bysort bins comparisons:  gen dup = cond(_N==1,0,_n)
	order bins dup
	sort  bins dup
	foreach var of varlist bins comparisons  {
		replace `var'=. if dup==2
	}
	foreach var of varlist outcomeall outcomeus outcome_popdiffall outcome_popdiffus outcome_popeduall outcome_popeduus {
		replace `var'="" if dup==2
	}
	replace outcomeall = outcome_pvalueall if dup==2
	drop outcome_pvalueall
	replace outcomeus = outcome_pvalueus if dup==2
	drop outcome_pvalueus
	replace outcome_popdiffall = outcome_popdiff_pvalueall if dup==2
	drop outcome_popdiff_pvalueall
	replace outcome_popdiffus = outcome_popdiff_pvalueus if dup==2
	drop outcome_popdiff_pvalueus
	replace outcome_popeduall = outcome_popedu_pvalueall if dup==2
	drop outcome_popedu_pvalueall
	replace outcome_popeduus = outcome_popedu_pvalueus if dup==2
	drop outcome_popedu_pvalueus
	drop dup

	listtex bins comparisons outcomeall outcomeus outcome_popdiffall outcome_popdiffus outcome_popeduall outcome_popeduus ///
	using "`filename'_appendix.tex", replace rstyle(tabular) ///
	head("\begin{tabular}{cccccccc}" "\multicolumn{8}{c}{Pairwise comparisons of nine skill groups} \\ \hline" ///
	"&Total          & \multicolumn{2}{c}{Unweighted} & \multicolumn{2}{c}{Pop-diff-weighted} & \multicolumn{2}{c}{Pop-diffxedu-share} \\" ///
	"Bins&comparisons& All  & US-born & All  & US-born & All  & US-born \\ \hline") ///
	foot("\hline \end{tabular}")

	listtex bins comparisons outcome_popeduall outcome_popeduus ///
	using "`filename'_main.tex", replace rstyle(tabular) ///
	head("\begin{tabular}{cccc}" "\multicolumn{4}{c}{Pairwise comparisons of nine skill groups} \\ \hline" ///
	"&Total          & \multicolumn{2}{c}{Pop-diffxedu-share} \\" ///
	"Bins&comparisons& All  & US-born \\ \hline") ///
	foot("\hline \end{tabular}")

}

end


cap program drop pairwisecomp_indocc_pvalues_tex
program define pairwisecomp_indocc_pvalues_tex

syntax using/,  filename(string)

use `using', clear

//Convert all numbers to strings and reshape so p-values appear below success rates
ren outcome_popdiffskilldiff outcome_popskilldiff
ren outcome_popdiffskilldif_pvalue outcome_popskilldiff_pvalue
foreach var of varlist outcome* {
	generate `var'_str = string(`var',"%9.2f")
	replace `var'_str = subinstr(`var'_str,"0.",".",1)
}
rename outcome_str outcome_str1
rename outcome_pvalue_str outcome_str2
rename outcome_popdiff_str outcome_popdiff_str1
rename outcome_popdiff_pvalue_str outcome_popdiff_str2
rename outcome_popskilldiff_str outcome_popskilldiff_str1
rename outcome_popskilldiff_pvalue_str outcome_popskilldiff_str2
reshape long outcome_str outcome_popdiff_str outcome_popskilldiff_str, i(bins) j(j)
foreach var of varlist outcome*str {
	replace `var' = "\footnotesize{(" + `var' + ")}" if j==2
}

//Create column headers and format table for TeX output
local obs = _N + 2
set obs `obs'
replace bins = 0 if _n==`obs'
replace bins = -1 if _n==`obs' - 1
sort bins j
foreach var of varlist bins comparisons {
	generate `var'_str = string(`var',"%9.0fc")
}
replace bins_str = "\begin{tabular}{lcccc} \hline" if bins==-1
replace bins_str = "Bins" if bins==0
replace comparisons_str             = "Total"                 if bins==-1
replace comparisons_str             = "comparisons"           if bins==0
replace outcome_str                 = "Unweighted"            if bins==-1
replace outcome_str                 = "success rate"          if bins==0
replace outcome_popdiff_str         = "Pop-diff weighted"     if bins==-1
replace outcome_popdiff_str         = "weighted success rate"          if bins==0
replace outcome_popskilldiff_str 			= "Pop-diff x skill-diff"  if bins==-1
replace outcome_popskilldiff_str 			= "weighted success rate" if bins==0
foreach var of varlist bins_str comparisons_str {
	replace `var' = "" if j==2
}
gen str lineender = "\\"
replace lineender = "\\ \hline" if bins==0
replace lineender = "\\ \hline\end{tabular}" if bins==276 & j==2
replace outcome_popskilldiff_str = outcome_popskilldiff_str + lineender

export delimited bins_str comparisons_str outcome_str outcome_popdiff_str outcome_popskilldiff_str using "`filename'_appendix.tex", delimiter("&") replace novarnames
replace outcome_popskilldiff_str 			= " \\"  if bins==-1
replace outcome_popskilldiff_str 			= "Success rate\\ \hline" if bins==0
export delimited bins_str comparisons_str outcome_popskilldiff_str using "`filename'_main.tex", delimiter("&") replace novarnames

end


capture program drop pairwisebigger
program define pairwisebigger

	//SKILLS
		use "../input/CAC_msaedufor_obs.dta", clear
		collapse (sum) perwt, by(msa edu) //Combine foreign-born and US-born
		merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keep(1 3) keepusing(logpop)
		generatepairwise2, id(msa) id2(edu) covariates(logpop perwt)
		//Is the bigger city bigger in all skill categories?
		keep if logpop_1 > logpop_2
		gen biggerisbigger = (perwt_1 >= perwt_2 & logpop_1 > logpop_2) | (perwt_1 <= perwt_2 & logpop_1 < logpop_2)
		collapse (mean) biggerisbigger , by(edu)
		summ biggerisbigger
		sort biggerisbigger
		list


	//OCCUPATIONS
		use "../input/OCCSOC2000.dta", clear
		keep occ_code msa emp_occgeo
		//Fill in zero-employment observations
		fillin occ_code msa
		recode emp_occgeo . = 0 if _fillin==1
		//Get populations and skill intensities
		merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keep(1 3) keepusing(logpop)
		merge m:1 occ_code using "../input/occ_skillintensities.dta", nogen keep(1 3) keepusing(skillintensity)
		generatepairwise2, id(msa) id2(occ_code) covariates(logpop emp_occgeo)
		//Is the bigger city bigger in occupational employment?
		keep if logpop_1 > logpop_2
		gen biggerisbigger = (emp_occgeo_1 >= emp_occgeo_2 & logpop_1 > logpop_2) | (emp_occgeo_1 <= emp_occgeo_2 & logpop_1 < logpop_2)
		collapse (mean) biggerisbigger , by(occ_code)
		summ biggerisbigger
		sort biggerisbigger
		list

	//INDUSTRIES
		use "../input/CAC_CBP2000_naics2.dta", clear
		rename aggreg_emp emp_indgeo
		keep naics msa emp_indgeo
		//Fill in zero-employment observations
		fillin naics msa
		recode emp_indgeo . = 0 if _fillin==1
		//Get populations and skill intensities
		merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keep(1 3) keepusing(logpop)
		merge m:1 naics using "../input/naics2_skillintensities.dta", nogen keep(1 3) keepusing(skillintensity)
		generatepairwise2, id(msa) id2(naics) covariates(logpop emp_indgeo)
		//Is the bigger city bigger in occupational employment?
		keep if logpop_1 > logpop_2
		gen biggerisbigger = (emp_indgeo_1 >= emp_indgeo_2 & logpop_1 > logpop_2) | (emp_indgeo_1 <= emp_indgeo_2 & logpop_1 < logpop_2)
		collapse (mean) biggerisbigger , by(naics)
		summ biggerisbigger
		sort biggerisbigger
		list

end


cap program drop pairwisecomparisons_msapop
program define pairwisecomparisons_msapop
syntax, saveas(string)

use "../input/MSA_POPDIF276_2000.dta", clear
keep if bins == 276
duplicates drop pop_log_diff, force
drop if pop_log_diff == 0

histogram pop_log_diff, start(0) width(.10) density xtitle("Difference in log population") graphregion(color(white)) ylabel(,nogrid)
graph export "../output/`saveas'.pdf", replace as(pdf)

end

cap program drop pairwisecomparisons_occskill
program define pairwisecomparisons_occskill
syntax, saveas(string)

tempfile tf_skill1 tf_skill2
//Creating occupational category skill differences
use "../input/occ_skillintensities.dta", clear
ren occ_code occ_1
ren skillintensity skillintensity_1
save `tf_skill1', replace
use "../input/occ_skillintensities.dta", clear
ren occ_code occ_2
ren skillintensity skillintensity_2
save `tf_skill2', replace
keep occ_2
gen occ_1 = occ_2
fillin occ_?
drop _fillin
merge m:1 occ_1 using `tf_skill1', nogen keep(1 3)
merge m:1 occ_2 using `tf_skill2', nogen keep(1 3)
gen skillintensity_difference = abs(skillintensity_1 - skillintensity_2)
keep occ_? skillintensity_difference
ren skillintensity_difference skill_diff
duplicates drop skill_diff, force
drop if skill_diff == 0

histogram skill_diff , density xtitle("Difference in schooling") graphregion(color(white)) ylabel(,nogrid)
graph export "../output/`saveas'.pdf", replace as(pdf)

end


cap program drop pairwisecomparisons_naicskill
program define pairwisecomparisons_naicskill
syntax, saveas(string)

tempfile tf_skill1 tf_skill2 tf_skilldifference
use "../input/naics2_skillintensities.dta", clear
ren naics naics_1
ren skillintensity skillintensity_1
save `tf_skill1', replace
use "../input/naics2_skillintensities.dta", clear
ren naics naics_2
ren skillintensity skillintensity_2
save `tf_skill2', replace
keep naics_2
gen naics_1 = naics_2
fillin naics_?
drop _fillin
merge m:1 naics_1 using `tf_skill1', nogen keep(1 3)
merge m:1 naics_2 using `tf_skill2', nogen keep(1 3)
gen skillintensity_difference = abs(skillintensity_1 - skillintensity_2)
keep naics_? skillintensity_difference
duplicates drop skillintensity_difference, force
drop if skillintensity_difference == 0

histogram skillintensity_difference, density xtitle("Difference in schooling") graphregion(color(white)) ylabel(,nogrid)
graph export "../output/`saveas'.pdf", replace as(pdf)

end
