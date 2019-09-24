cap program drop permutation_out
program define permutation_out
syntax, edugroups(integer) filename(string) iterations(integer)

if `edugroups'==3 local educationvar="edu2"
if `edugroups'==9 local educationvar="edu"

  foreach bin in 2 3 5 10 30 90 270 {
  	use "../output/edu`edugroups'_`bin'.dta", clear
    preserve
  	tempvar tv1 tv2 tv3
  	count
  	local total = r(N)
  	egen `tv1' = rank(outcome), track
  	egen `tv2' = rank(outcome_popdiff), track
  	gen emp_pctile = `tv1' / `total'
  	gen emp_pctile_popdiff = `tv2' / `total'
  	drop `tv1' `tv2'
  	if "`educationvar'"=="edu" {
  		egen `tv3' = rank(outcome_popedu) , track
  		gen emp_pctile_popedu = `tv3' / `total'
  		drop `tv3'
    }
  	save `filename'_bin`bin'.dta, replace

  	tempfile tf_percentile`bin'
    restore
  	egen outcome_p95 = pctile(outcome), p(95)
  	egen outcome_p99 = pctile(outcome), p(99)
  	egen outcome_popdiff_p95 = pctile(outcome_popdiff), p(95)
  	egen outcome_popdiff_p99 = pctile(outcome_popdiff), p(99)
  	if "`educationvar'"=="edu" egen outcome_popedu_p95 = pctile(outcome_popedu), p(95)
  	if "`educationvar'"=="edu" egen outcome_popedu_p99 = pctile(outcome_popedu), p(99)
  	collapse (firstnm) *_p9? bins
  	gen iterations = `iterations'
  	save `tf_percentile`bin'', replace
  }

  clear
  foreach bin in 2 3 5 10 30 90 270 {
  	append using `tf_percentile`bin''
  }
  save `filename'.dta, replace

  list

end
// end of program

local iter = `1'

// append parallelized permutations
foreach stub in "" "_US" {
 foreach edu in 3 9 {
  foreach bin in 2 3 5 10 30 90 270 {
   local filelist: dir "../output" files "edu`edu'`stub'_`bin'_*.dta"
   tempfile tf_collect
   foreach file in `filelist' {
    use "../output/`file'", clear
    cap append using `tf_collect'
    save `tf_collect', replace
   }
   use `tf_collect', clear
   save "../output/edu`edu'`stub'_`bin'.dta", replace
  }
  qui permutation_out, edugroups(`edu') filename(../output/cdf_edu`edu'`stub') iterations(`iter')
 }
}
