use "/Volumes/jdingel/CAC_USA/CAC_USA_forweb_replication/data_norm1/IPUMS_data_2000.dta" , clear  //10,427,994
cfout using "/Volumes/jdingel/cac-usa/tasks/initialdata/output/IPUMS_data_2000.dta", id(year datanum serial pernum)

use "/Volumes/jdingel/cac-usa/tasks/initialdata/output/IPUMS_data_2000.dta", clear // 14,081,466
count if inrange(age,18,.)==1

use year datanum serial pernum age using "/Volumes/jdingel/CAC_USA/CAC_USA_forweb_replication/data_norm1/IPUMS_data_2000.dta" , clear
merge 1:1 year datanum serial pernum using "/Volumes/jdingel/cac-usa/tasks/initialdata/output/IPUMS_data_2000.dta", keepusing(year datanum serial pernum age)
assert inrange(age,0,17)==1 if _merge!=3 

use "/Volumes/jdingel/cac-usa/tasks/skillintensities/output/occ_skillintensities.dta", clear
rename skillintensity skillintensity_new
//cfout using "/Volumes/jdingel/CAC_USA/CAC_USA_forweb_replication/data_norm2/occ_ILF_skillintensities.dta", id(occ_code)
merge 1:1 occ_code  using "/Volumes/jdingel/CAC_USA/CAC_USA_forweb_replication/data_norm2/occ_ILF_skillintensities.dta", assert(match) nogen
gen diff = skillintensity_new - skillintensity
summarize diff
