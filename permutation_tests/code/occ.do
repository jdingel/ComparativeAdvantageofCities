qui do programs.do

//** START OF PROGRAM TO PERFORM PERMUTATION TEST ON OCCUPATIONAL CATEGORIES **//
cap program drop permutation_occ_shuffle
program define permutation_occ_shuffle
syntax using/, iteration(integer) filename(string)

	//Shuffling data randomly.
	use "`using'.dta", clear
	drop msa cmsa_pop
  set seed `iteration'
	gen double shuffle = runiform()
	sort shuffle
	gen Rperwt = sum(perwt)

  do msarecode_occ.do
  drop fakemsa* Rperwt
  ren new_pop Rperwt
  merge m:1 Rperwt using "`using'_popthresh.dta", assert(match) keepusing(msagroup* msa) nogen
  ren Rperwt cmsa_pop

	save "`filename'", replace

end


cap program drop permutation_occ_bins
program define permutation_occ_bins
syntax, shuffle(string) iteration(integer) bin(integer) filename(string) [keepif(string)]

	confirm file `shuffle'
	use `shuffle', clear
	summ skillintensityrank
	collapse (sum) emp_occgeo = perwt (first) msagroup`bin' skillintensityrank, by(occ_code msa)
	gen msas_in_bin = 1
	collapse (sum) emp_occgeo msas_in_bin (first) skillintensityrank, by(occ_code msagroup`bin')
	gen emp_occgeo_average = emp_occgeo / msas_in_bin

  tempfile tf_temp
	supermodularitycheck, x(occ_code) y(msagroup`bin') value(emp_occgeo_average) ///
                        xvalue(skillintensityrank) yvalue(msagroup`bin') ///
                        testoutcome(outcome) logsupermodular filename(`tf_temp')

	use `tf_temp', clear
	ren msagroup`bin'_1 msagroup_1
	ren msagroup`bin'_2 msagroup_2

	//MERGING WITH MSA POPULATION DIFFERENCES
	gen bins = `bin'
	merge m:1 bins msagroup_1 msagroup_2 using "../input/MSA_POPDIF276_2000.dta", nogen keep(1 3) keepusing(pop_log_diff)

	tempvar tv_numer tv_denom tv_numer2 tv_denom2
	egen `tv_numer' = total(outcome * pop_log_diff)
	egen `tv_denom' = total(pop_log_diff)
	gen outcome_popdiff = `tv_numer' / `tv_denom'
	merge m:1 occ_code_1 occ_code_2 using "../input/CAC_binned_occ_skilldiff.dta", keep(1 3) nogen keepusing(skilldiff)
	egen `tv_numer2' = total(outcome * pop_log_diff * skilldiff)
	egen `tv_denom2' = total(pop_log_diff * skilldiff)
	gen outcome_popdiffskilldiff = `tv_numer2' / `tv_denom2'
	collapse (mean) outcome (firstnm) outcome_popdiff*
	gen iteration = `iteration'
	tempfile tf_instance
	save `tf_instance', replace
	confirm file `filename'
	use `filename', clear
	append using `tf_instance'
	save `filename', replace

end
//** END OF PROGRAM TO PERFORM PERMUTATION TEST ON OCCUPATIONAL CATEGORIES **//

local startiter = `1'
local enditer = `2'

foreach bin in 2 3 5 10 30 90 276 {
  tempfile tf_occ_collecter`bin'
  clear
  gen outcome = .
  save `tf_occ_collecter`bin'', replace
}

tempfile tf_shuffled_occ
forvalues i = `startiter'/`enditer' {
 qui permutation_occ_shuffle using "../input/CAC_binned_occ", filename(`tf_shuffled_occ') iteration(`i')
 foreach bin in 2 3 5 10 30 90 276 {
  qui permutation_occ_bins, shuffle(`tf_shuffled_occ') iteration(`i') bin(`bin') filename(`tf_occ_collecter`bin'')
 }
}

foreach bin in 2 3 5 10 30 90 276 {
 use `tf_occ_collecter`bin'', clear
 save "../output/occ_`bin'_`startiter'.dta", replace
}
