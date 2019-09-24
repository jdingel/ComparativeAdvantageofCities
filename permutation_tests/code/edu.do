qui do programs.do

cap program drop permutation_shuffle
program define permutation_shuffle
syntax using/, iteration(integer) filename3(string) filename9(string) [stub(string)]

  //Shuffling data randomly
	use "`using'.dta", clear
	drop msa cmsa_pop
  set seed `iteration'
	gen double shuffle = runiform()
	sort shuffle
	gen Rperwt = sum(perwt)

  do msarecode`stub'.do
  drop fakemsa* Rperwt
  ren new_pop Rperwt
  merge m:1 Rperwt using "`using'_popthresh.dta", assert(match) keepusing(msa) nogen
  ren Rperwt cmsa_pop

  // collapse at 9 edu groups
	collapse (sum) perwt (firstnm) edu2, by(msa edu)
	gen logperwt = log(perwt)
	merge m:1 msa using "`using'_binassignments.dta", nogen keep(1 3) keepusing(msagroup* cmsa_pop logpop)
	save "`filename9'", replace

  // collapse at 3 edu groups
	drop logperwt
	collapse (sum) perwt (first) msagroup* cmsa_pop logpop, by(msa edu2)
	gen logperwt = log(perwt)
	save "`filename3'", replace

end


cap program drop permutation_test
program define permutation_test
syntax, filename(string) weights(string) edugroups(integer) educationvar(string) ///
        shuffle(string) iteration(integer) bin(integer)

  confirm file `shuffle'
	use `shuffle', clear
	gen msas_in_bin = 1
	collapse (sum) logpop logperwt msas_in_bin, by(`educationvar' msagroup`bin')
	gen logperwt_avg = logperwt / msas_in_bin
	gen logpop_avg = logpop / msas_in_bin
	ren msagroup`bin' msagroup

  tempfile tf_temp
	supermodularitycheck, x(`educationvar') y(msagroup) value(logperwt_avg) ///
                        xvalue(`educationvar') yvalue(msagroup) ///
                        testoutcome(outcome_dummy) filename(`tf_temp')
	use `tf_temp', clear

	//MERGING WITH MSA POPULATION DIFFERENCES
	gen bins = `bin'
	merge m:1 bins msagroup_1 msagroup_2 using "../input/MSA_POPDIF270_2000.dta", nogen keep(1 3) keepusing(pop_log_diff)

	//Computing unweighted mean and manually creating weighted means in order to avoid having to collapse and re-merge
  tempvar tv_numer tv_denom
	egen `tv_numer' = total(outcome_dummy * pop_log_diff)
	egen `tv_denom' = total(pop_log_diff)
	gen outcome_popdiff = `tv_numer' / `tv_denom'
	if "`educationvar'"=="edu" {
		merge m:1 edu_1 edu_2 using "`weights'", keep(1 3) nogen keepusing(edu_share_weight)
		tempvar tv_numer2 tv_denom2
		egen `tv_numer2' = total(outcome_dummy * pop_log_diff * edu_share_weight)
		egen `tv_denom2' = total(pop_log_diff * edu_share_weight)
		gen outcome_popedu = `tv_numer2' / `tv_denom2'
	}

	collapse (mean) outcome = outcome_dummy (firstnm) outcome_pop* bins
	gen iteration = `iteration'
	tempfile tf_instance
	save `tf_instance', replace
  confirm file `filename'
	use `filename', clear
	append using `tf_instance'
	save `filename', replace

end
//** END OF PROGRAM TO PERFORM PERMUTATION TEST ON EDUCATIONAL GROUPS **//

local startiter = `1'
local enditer = `2'

// prepare temp files
foreach edu in 3 9 {
 *shuffled individual files
 tempfile tf_shuffled_US_edu`edu' tf_shuffled_edu`edu'
 foreach bin in 2 3 5 10 30 90 270 {
  quietly {
  clear
  gen outcome = .
  *collecter files for permutation tests
  tempfile tf_`edu'_collecter`bin' tf_`edu'_US_collecter`bin'
  di "`tf_`edu'_collecter`bin'' and `tf_`edu'_US_collecter`bin'' ""
  save `tf_`edu'_collecter`bin''
  save `tf_`edu'_US_collecter`bin''
  }
 }
}

forvalues i = `startiter'/`enditer' {
 qui permutation_shuffle using "../input/CAC_binned_edu_US", filename3(`tf_shuffled_US_edu3') filename9(`tf_shuffled_US_edu9') iteration(`i') stub("_US")
 qui permutation_shuffle using "../input/CAC_binned_edu", filename3(`tf_shuffled_edu3') filename9(`tf_shuffled_edu9') iteration(`i')
 foreach edu in 3 9 {
  if `edu'==3 local educationvar="edu2"
  if `edu'==9 local educationvar="edu"
  foreach bin in 2 3 5 10 30 90 270 {

   qui permutation_test, filename(`tf_`edu'_US_collecter`bin'') ///
                         weights("../input/CAC_binned_edu_US_weights_edushares.dta") ///
                         shuffle(`tf_shuffled_US_edu`edu'') ///
                         edugroups(`edu') ///
                         educationvar(`educationvar') ///
                         iteration(`i') bin(`bin')

   qui permutation_test, filename(`tf_`edu'_collecter`bin'') ///
                         weights("../input/CAC_binned_edu_weights_edushares.dta") ///
                         shuffle(`tf_shuffled_edu`edu'') ///
                         edugroups(`edu') ///
                         educationvar(`educationvar') ///
                         iteration(`i') bin(`bin')

  }
 }
}

foreach stub in "_US" "" {
 foreach edu in 3 9 {
  foreach bin in 2 3 5 10 30 90 270 {
   use `tf_`edu'`stub'_collecter`bin'', clear
   save "../output/edu`edu'`stub'_`bin'_`startiter'.dta", replace
  }
 }
}
