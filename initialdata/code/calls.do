set more off
do "programs.do"
qui do "CAC_PREP_IPUMS_2000.do"
qui do "CAC_PREP_IPUMS_1980.do"

// import IPUMS data
IPUMS_data_1980
IPUMS_data_2000

// clean data
MSAEDU_2000SF3
NECMA2000_delineations
NECMA2000_POP
msa_pop2000
naics_labels
PUMA2000_MSA2000
load_OES_MSA
IPUMS2000
CBP_2000_naics2_norm

// prepare estimation arrays
estimationarray
PREP_CAC_1980
FTFY_estimationarray

*CBP_CAC_estimationarray
use "../output/CAC_CBP2000_naics2.dta", clear
merge m:1 msa using "../output/CMSA_POP2000.dta", nogen assert(match using) keep(match) keepusing(msa_name cmsa_pop logpop)
saveold "../output/CAC_CBP2000_naics2.dta", replace
