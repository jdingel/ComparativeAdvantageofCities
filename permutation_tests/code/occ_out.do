cap program drop permutation_occ_out
program define permutation_occ_out
syntax, filename(string) iterations(integer)

  foreach bin in 2 3 5 10 30 90 276 {
  	use "../output/occ_`bin'.dta", clear
    preserve
  	tempvar tv1 tv2 tv3
  	count
  	local total = r(N)
  	egen `tv1' = rank(outcome), track
  	egen `tv2' = rank(outcome_popdiff), track
  	egen `tv3' = rank(outcome_popdiffskilldiff), track
  	gen emp_pctile = `tv1' / `total'
  	gen emp_pctile_popdiff = `tv2' / `total'
  	gen emp_pctile_popdiffskilldiff = `tv3' / `total'
  	drop `tv1' `tv2' `tv3'
  	save `filename'_bin`bin'.dta, replace

  	tempfile tf_percentile`bin'
  	restore
  	egen outcome_p95 = pctile(outcome), p(95)
  	egen outcome_p99 = pctile(outcome), p(99)
  	egen outcome_popdiff_p95 = pctile(outcome_popdiff), p(95)
  	egen outcome_popdiff_p99 = pctile(outcome_popdiff), p(99)
  	egen outcome_popdiffskilldiff_p95 = pctile(outcome_popdiffskilldiff), p(95)
  	egen outcome_popdiffskilldiff_p99 = pctile(outcome_popdiffskilldiff), p(99)
  	collapse (firstnm) *_p9?
  	gen bins = `bin'
  	gen iterations = `iterations'
  	save `tf_percentile`bin'', replace
  }

  clear
  foreach bin in 2 3 5 10 30 90 276 {
  	append using `tf_percentile`bin''
  }
  save `filename'.dta, replace

  list

end
// end of program

local iter = `1'

// append parallelized permutations
foreach bin in 2 3 5 10 30 90 276 {
 local filelist: dir "../output" files "occ_`bin'_*.dta"
 tempfile tf_collect
 foreach file in `filelist' {
  use "../output/`file'", clear
  cap append using `tf_collect'
  save `tf_collect', replace
 }
 use `tf_collect', clear
 save "../output/occ_`bin'.dta", replace
}
qui permutation_occ_out, iterations(`iter') filename(../output/cdf_occ)
