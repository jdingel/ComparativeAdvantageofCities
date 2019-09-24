qui do programs.do

//**START OF CODE TO COMPUTE PAIRWISE DIFFERENCES IN LOG POPULATION**//
cap program drop MSA_POPDIF_2000
program define MSA_POPDIF_2000
syntax, maxbin(integer)

	tempfile tf1
	//Loading population data
	use "../input/CMSA_POP2000.dta", clear
	drop if substr(msa_name,-7,7)=="PR CMSA"|substr(msa_name,-6,6)=="PR MSA" //Dropping Puerto Rican CMSAs and MSAs
	if `maxbin' == 270 {
	drop if msa == 1010 | msa == 1890 | msa == 2200 | msa == 2340 | msa == 3700 | msa == 6340 //Dropping the six MSAs that are not considered in the CAC paper due to PUMA mapping issues.
	}
	keep msa cmsa_pop
	//Save characteristics for first element of MSA pair
	generatepairwise, id(msa) covariates(cmsa_pop)
	save `tf1', replace

	foreach bin in 2 3 5 10 30 90 `maxbin' {
		tempfile tf_bins`bin'
		use `tf1', clear
		xtile msagroup_1 = cmsa_pop_1, nq(`bin')
		xtile msagroup_2 = cmsa_pop_2, nq(`bin')
		gen logpop_1 = log(cmsa_pop_1)
		gen logpop_2 = log(cmsa_pop_2)
		collapse (sum) logpop_?, by(msagroup_?)
		//Calculate pairwise characteristic
		gen pop_log_diff = abs(logpop_1 - logpop_2)
		//Save
		keep msagroup_? pop_log_diff
		gen bins = `bin'
		save `tf_bins`bin'', replace
	}

	clear
	foreach bin in 2 3 5 10 30 90 `maxbin' {
		append using `tf_bins`bin''
	}

	saveold "../output/MSA_POPDIF`maxbin'_2000.dta", replace

end
//**END OF CODE TO COMPUTE PAIRWISE DIFFERENCES IN LOG POPULATION**//

MSA_POPDIF_2000, maxbin(276)
MSA_POPDIF_2000, maxbin(270)
