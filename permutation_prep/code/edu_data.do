qui do programs.do

//CREATE PERMUTATION BIN MASTER FILE
cap program drop permutation_data
program define permutation_data
syntax using/, filename(string) [keepif(string)]

	//Prepare file denoting assignments of MSAs to MSA-group bins
	use "../input/CMSA_POP2000.dta", clear
	drop if substr(msa_name,-7,7)=="PR CMSA"|substr(msa_name,-6,6)=="PR MSA" //Dropping Puerto Rican CMSAs and MSAs
	drop if msa == 1010 | msa == 1890 | msa == 2200 | msa == 2340 | msa == 3700 | msa == 6340 //Dropping the six MSAs that are not considered in the CAC paper due to PUMA mapping issues.
	keep msa cmsa_pop logpop
	foreach bin in 2 3 5 10 30 90 270 {
		xtile msagroup`bin' = logpop, nq(`bin')
	}
	label data "Assignments of MSAs to MSA-group bins"
	save "`filename'_binassignments.dta", replace

	//Prepare education share weights file for weights
	use "`using'", clear
	if "`keepif'"~="" keep if `keepif'
	collapse (sum) perwt, by(edu)
	egen total = total(perwt)
	gen edushare = perwt / total
	generatepairwise, id(edu) covariates(edushare)
	gen edu_share_weight = edushare_1 * edushare_2
	keep edu_? edu_share_weight
	label data "Education-share weights"
	save "`filename'_weights_edushares.dta", replace

	//Prepare file on which data will be shuffled
	use "`using'", clear
	cap drop edu2
	gen edu2 = edu
	recode edu2 1=1 2=1 3=1 4=2 5=2 6=3 7=3 8=3 9=3
	if "`keepif'"~="" keep if `keepif'
	keep perwt edu edu2 msa cmsa_pop
	sort cmsa_pop
	drop if perwt == 0 //Observations that don't get any weighting in the IPUMS. We can ignore these and it makes the code faster.
	label data ""
	save `filename'.dta, replace

	//Generating thresholds for classification on permuted data containing the perwt thresholds for classification of data to MSAs after shuffling.
	egen Rperwt = max(sum(perwt)), by(msa)
	collapse (firstnm) Rperwt cmsa_pop, by(msa)
	gen cum_pop = sum(Rperwt)
	save "`filename'_popthresh.dta", replace

end
// end of program


// CALLS
qui permutation_data using "../input/CAC_forpermutation.dta", filename("../output/CAC_binned_edu")
qui permutation_data using "../input/CAC_forpermutation.dta", keepif(foreign==0) filename("../output/CAC_binned_edu_US")

timer list
