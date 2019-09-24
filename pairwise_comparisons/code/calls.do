qui do "programs.do"

// Pairwise comparisons
pairwisecomparisons_3skills, using(../input/CMSA_POP2000.dta) ///
  msapopdif(../input/MSA_POPDIF270_2000.dta) ///
  eduforfile(../input/CAC_msaedufor_obs.dta) saveas(table4)

pairwisecomparisons_9skills, using(../input/CMSA_POP2000.dta) ///
 msapopdif(../input/MSA_POPDIF270_2000.dta) ///
 eduforfile(../input/CAC_msaedufor_obs.dta) saveas(table6)

pairwisecomparisons_occupations, using(../input/CMSA_POP2000.dta) ///
  skillint(../input/occ_skillintensities.dta) ///
  secusing(../input/OCCSOC2000.dta) ///
  msapopdif(../input/MSA_POPDIF276_2000.dta) ///
  saveas(table7)

pairwisecomparisons_industries, using(../input/CMSA_POP2000.dta) ///
  skillint(../input/naics2_skillintensities.dta) ///
  secusing(../input/CAC_CBP2000_naics2.dta) ///
  msapopdif(../input/MSA_POPDIF276_2000.dta) saveas(table8)

// attaching p-values
//All
permutation_results, resultstable(../output/table4_reshape.dta) extravar(type) ///
  keepif(type=="all") ///
  permutationstem(../input/cdf_edu3_bin) ///
  filename(../output/table4_all_pvalues) ///
  highestbin(270)
//US
permutation_results, resultstable(../output/table4_reshape.dta) extravar(type) ///
  keepif(type=="us") ///
  permutationstem(../input/cdf_edu3_US_bin) ///
  filename(../output/table4_US_pvalues) ///
  highestbin(270)
//All
permutation_results, resultstable(../output/table6.dta) extravar(type) ///
  keepif(type=="all") ///
  permutationstem(../input/cdf_edu9_bin) ///
  filename(../output/table6_all_pvalues) ///
  highestbin(270) thirdweight(popedu)
//US
permutation_results, resultstable(../output/table6.dta) extravar(type) ///
  keepif(type=="us") ///
  permutationstem(../input/cdf_edu9_US_bin) ///
  filename(../output/table6_US_pvalues) ///
  highestbin(270) thirdweight(popedu)
//Combine  US-All p-values from Tables 4 and 6
combineusforeign, saveas_3skill(table4) saveas_9skill(table6)
//Occ
permutation_results, resultstable(../output/table7_occupations.dta) ///
  permutationstem(../input/cdf_occ_bin) ///
  filename(../output/table7_pvalues.dta) ///
  highestbin(276) thirdweight(popdiffskilldif)
//Ind
permutation_results, resultstable(../output/table8_naics2.dta) ///
  permutationstem(../input/cdf_naics_bin) ///
  filename(../output/table8_pvalues.dta) ///
  highestbin(276) thirdweight(popdiffskilldif)

//Export TeX tables
pairwisecomp_edu_appendix_tex using "../output/table4_pvalues.dta", tabnum(4) filename(../output/table4)
pairwisecomp_edu_appendix_tex using "../output/table6_pvalues.dta", tabnum(6) filename(../output/table6)
//IndOcc
pairwisecomp_indocc_pvalues_tex using "../output/table7_pvalues.dta", filename(../output/table7)
pairwisecomp_indocc_pvalues_tex using "../output/table8_pvalues.dta", filename(../output/table8)
// end of attaching p-values

pairwisecomparisons_msapop, saveas(figureE1.A_popdiff)
pairwisecomparisons_occskill, saveas(figureE1.B_skilldiff_occ)
pairwisecomparisons_naicskill, saveas(figureE1.C_skilldiff_naics2)
