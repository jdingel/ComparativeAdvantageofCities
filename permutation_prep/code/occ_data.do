//CREATE PERMUTATION BIN MASTER FILE
cap program drop permutation_data_occ
program define permutation_data_occ
syntax, filename(string)

  //Generate occupation-pair skill-intensity differences for use as weights
  tempfile tf1 tf2
  use "../input/occ_skillintensities.dta", clear
  ren skillintensity skill
  ren occ_code occ_code_1
  ren skill skillintensity_1
  save `tf1', replace
  use "../input/occ_skillintensities.dta", clear
  ren skillintensity skill
  ren occ_code occ_code_2
  ren skill skillintensity_2
  save `tf2', replace
  drop skillintensity_2
  gen occ_code_1 = occ_code_2
  fillin occ_code_?
  merge m:1 occ_code_1 using `tf1', nogen keepusing(skillintensity_1)
  merge m:1 occ_code_2 using `tf2', nogen keepusing(skillintensity_2)
  gen skilldiff = abs(skillintensity_1 - skillintensity_2)
  keep occ_code_1 occ_code_2 skilldiff
  save "`filename'_skilldiff.dta", replace

  //Load up a data set of employment in chunks of 20 people so that it can be shuffled, etc
  use "../input/OCCSOC2000.dta", clear
  keep occ_code msa emp_occgeo
  local chunk = 20
  gen expander = ceil(emp_occgeo/`chunk')
  expand expander, gen(novel)
  gen perwt = `chunk'*(novel==1) + (emp_occgeo - `chunk'*(expander-1))*(novel==0)
  bys msa occ_code: egen checksum = total(perwt)
  assert checksum==emp_occgeo
  keep msa occ_code perwt
  merge m:1 msa using "../input/CMSA_POP2000.dta", nogen keepusing(cmsa_pop)
  merge m:1 occ_code using "../input/occ_skillintensities.dta", nogen keep(3) keepusing(skillintensity)
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

qui permutation_data_occ, filename("../output/CAC_binned_occ")
