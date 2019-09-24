clear all


//**START OF  FIGURE 5 **//
cap program drop pairwisecomparisons_occskill
program define pairwisecomparisons_occskill
syntax using/, saveas(string)

tempfile tf_skill1 tf_skill2

//Creating occupational category skill differences
use "`using'", clear
ren occ_code occ_1
ren skillintensity skillintensity_1
save `tf_skill1', replace
use "`using'", clear
ren occ_code occ_2
ren skillintensity skillintensity_2
save `tf_skill2', replace
keep occ_2
gen occ_1 = occ_2
fillin occ_?
drop _fillin
merge m:1 occ_1 using `tf_skill1', nogen keep(1 3)
merge m:1 occ_2 using `tf_skill2', nogen keep(1 3)
gen skillintensity_difference = abs(skillintensity_1 - skillintensity_2)
keep occ_? skillintensity_difference
ren skillintensity_difference skill_diff
duplicates drop skill_diff, force
drop if skill_diff == 0

histogram skill_diff , density xtitle("Difference in schooling") graphregion(color(white)) ylabel(,nogrid)
graph export "`saveas'", replace as(pdf)

end

cap program drop pwc_occskill_bast
program define pwc_occskill_bast
syntax using/, saveas(string)

tempfile tf_skill1 tf_skill2

//Creating occupational category skill differences
use "`using'", clear
ren occ_code occ_1
ren skillintensity skillintensity_1
save `tf_skill1', replace
use "`using'", clear
ren occ_code occ_2
ren skillintensity skillintensity_2
save `tf_skill2', replace
keep occ_2
gen occ_1 = occ_2
fillin occ_?
drop _fillin
merge m:1 occ_1 using `tf_skill1', nogen keep(1 3)
merge m:1 occ_2 using `tf_skill2', nogen keep(1 3)
gen skillintensity_difference = abs(skillintensity_1 - skillintensity_2)
keep occ_? skillintensity_difference
ren skillintensity_difference skill_diff
//duplicates drop skill_diff, force
//drop if skill_diff == 0

histogram skill_diff , density xtitle("Difference in schooling") graphregion(color(white)) ylabel(,nogrid)
graph export "`saveas'", replace as(pdf)

end

pairwisecomparisons_occskill using "/Users/jdingel/Box Sync/Yarin-Dingel/CAC_USA/data_norm2/occ_ILF_skillintensities_noFE.dta", saveas("~/Desktop/check1.pdf")
pairwisecomparisons_occskill using "/Volumes/jdingel/cac-usa/tasks/skillintensities/output/occ_skillintensities.dta", saveas("~/Desktop/check2.pdf")
pairwisecomparisons_occskill using "/Users/jdingel/Box Sync/Yarin-Dingel/CAC_USA/data_norm2/occ_ILF_skillintensities.dta", saveas("~/Desktop/check3.pdf")

pwc_occskill_bast using "/Users/jdingel/Box Sync/Yarin-Dingel/CAC_USA/data_norm2/occ_ILF_skillintensities_noFE.dta", saveas("~/Desktop/check1b.pdf")
pwc_occskill_bast using "/Volumes/jdingel/cac-usa/tasks/skillintensities/output/occ_skillintensities.dta", saveas("~/Desktop/check2b.pdf")


use "/Users/jdingel/Box Sync/Yarin-Dingel/CAC_USA/data_norm2/occ_ILF_skillintensities_noFE.dta", clear
rename skillintensity skillintensity_noFE
merge 1:1 occ_code using "/Volumes/jdingel/cac-usa/tasks/skillintensities/output/occ_skillintensities.dta", assert(match) nogen
