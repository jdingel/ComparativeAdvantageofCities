//CREATE PERMUTATION BIN MASTER FILE
cap program drop permutation_data_naics
program define permutation_data_naics
syntax, filename(string)

  //Generate industry-pair skill-intensity differences for use as weights
  tempfile tf1 tf2
  use "../input/naics2_skillintensities.dta", clear
  ren naics naics_1
  ren skillintensity skillintensity_1
  save `tf1', replace
  use "../input/naics2_skillintensities.dta", clear
  ren naics naics_2
  ren skillintensity skillintensity_2
  save `tf2', replace
  drop skillintensity_2
  gen naics_1 = naics_2
  fillin naics_?
  merge m:1 naics_1 using `tf1', nogen keepusing(skillintensity_1)
  merge m:1 naics_2 using `tf2', nogen keepusing(skillintensity_2)
  gen skilldiff = abs(skillintensity_1 - skillintensity_2)
  keep naics_1 naics_2 skilldiff
  save "`filename'_skilldiff.dta", replace

  //Load up a data set of employment in chunks of 20 people so that it can be shuffled, etc
  use "../input/CAC_CBP2000_naics2.dta", clear
  rename aggreg_emp emp_indgeo
  keep naics msa emp_indgeo cmsa_pop censored
  local chunk = 20
  gen expander = ceil(emp_indgeo/`chunk')
  expand expander, gen(novel)
  gen perwt = `chunk'*(novel==1) + (emp_indgeo - `chunk'*(expander-1))*(novel==0)
  bys msa naics: egen checksum = total(perwt)
  count if checksum~=emp_indgeo
  keep msa naics perwt
  merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keepusing(msa cmsa_pop)
  merge m:1 naics using "../input/naics2_skillintensities.dta", nogen keep(3) keepusing(skillintensity)
  egen skillintensityrank = rank(skillintensity)
  sort cmsa_pop
  label data ""
  save "`filename'.dta", replace

  //GENERATING THRESHOLDS FOR CLASSIFICATION ON PERMUTED DATA//
  egen Rperwt = max(sum(perwt)), by(msa)
  collapse (firstnm) Rperwt cmsa_pop, by(msa)
  foreach bin in 2 3 5 10 30 90 276 {
    xtile msagroup`bin' = cmsa_pop, nq(`bin')	//Generating bins at the city level
  }
  save "`filename'_popthresh.dta", replace

end

qui permutation_data_naics, filename("../output/CAC_binned_naics")
