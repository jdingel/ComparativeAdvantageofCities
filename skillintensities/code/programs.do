//**START OF PROGRAM TO GENERATE SKILL INTENSITY MEASURES FOR 2-DIGIT OCCUPATIONS AN 2- AND 3- DIGIT INDUSTRIES USING THE "IN LABOR FORCE" IPUMS OBSERVATIONS**//
cap program drop skillintensities
program define skillintensities

//Prepare file of observations with all labor-force participants over age 25
tempfile tf0
use "../input/IPUMS2000.dta", clear
keep if inrange(age,25,.) & empstat<=2  //Labor-force participants over age 25
drop if gq == 3 | gq == 4
keep year statefip puma edu foreign perwt sch indnaics occsoc
merge m:1 statefip puma using "../input/PUMA2000-MSA2000.dta", nogen keepusing(msa_code)
drop if missing(msa_code) | msa_code==9999 //This drops individuals who are located in PUMAs that are not assigned to any CBSA.
drop if indnaics=="9920" //Unemployed, with no work experience in past 5 years -- don't want skill intensities for unemployed
keep sch indnaics occsoc msa_code perwt
label variable sch "Years of schooling (authors' calc from educd)"
compress
save `tf0', replace

//3-digit NAICS skill intensities
use `tf0', clear
gen naics = substr(indnaics,1,3)
destring naics, replace force
tab indnaics if missing(naics) | naics<100
drop if missing(naics) | naics<100
bys msa_code naics: egen numer = sum(sch*perwt)
by msa_code naics: egen denom = sum(perwt)
gen schooling_msanaics = numer / denom
collapse (firstnm) schooling_msanaics denom, by(msa naics)
reghdfe schooling_msanaics [pw=denom], a(skillintensity = naics msa_fe = msa_code) nocons
collapse (firstnm) skillintensity, by(naics)
label variable skillintensity "Employees' average years of schooling in 3-digit NAICS (IPUMS) [ILF sample]"
compress
label data "Industry skill intensities"
saveold "../output/naics3_skillintensities.dta", replace

//2-digit NAICS skill intensities
use `tf0', clear
gen naics = substr(indnaics,1,2)
destring naics, replace force
recode naics 32=31 33=31 45=44 49=48
tab indnaics if missing(naics)
drop if missing(naics)
bys msa_code naics: egen numer = sum(sch*perwt)
by msa_code naics: egen denom = sum(perwt)
gen schooling_msanaics = numer / denom
collapse (firstnm) schooling_msanaics denom, by(msa naics)
reghdfe schooling_msanaics [pw=denom], a(skillintensity = naics msa_fe = msa_code) nocons
collapse (firstnm) skillintensity, by(naics)
label variable skillintensity "Employees' average years of schooling in 2-digit NAICS (IPUMS) [ILF sample]"
compress
label data "Industry skill intensities"
saveold "../output/naics2_skillintensities.dta", replace

//2-digit occupations
use `tf0', clear
gen occ = substr(occsoc,1,2)
destring occ, replace force
drop if missing(occ)
bys msa_code occ: egen numer = sum(sch*perwt)
by msa_code occ: egen denom = sum(perwt)
gen schooling_msaocc = numer / denom
su sch [aw=perwt] if occ!=55
local occ_mean = `r(mean)'
collapse (firstnm) schooling_msaocc denom, by(msa occ)
drop if occ == 55 //This is a category for military specific occupations and unemployed people. We do not consider it in the paper.
reghdfe schooling_msaocc [pw=denom], a(skillintensity = occ msa_fe = msa_code) nocons
collapse (firstnm) skillintensity, by(occ)
ren occ occ_code
label variable skillintensity "Employees' average years of schooling in 2-digit OCC (IPUMS) [ILF sample]"
compress
label data "Occupation skill intensities"
saveold "../output/occ_skillintensities.dta", replace

end
//**END OF PROGRAM TO GENERATE SKILL INTENSITY MEASURES FOR 2-DIGIT OCCUPATIONS AN 2- AND 3- DIGIT INDUSTRIES USING THE "IN LABOR FORCE" IPUMS OBSERVATIONS**//


cap program drop sectoralskillintensities
program define sectoralskillintensities
syntax, saveas(string)

tempfile tf1 tf_occ_titles

//Occupation titles
use "../input/OCCSOC2000.dta", clear
collapse (firstnm) occ_title, by(occ_code)
save `tf_occ_titles', replace

//Load skill intensities for occupations
use "../output/occ_skillintensities.dta", clear
egen rankocc = rank(skillintensity)
summ rankocc
local max = r(max)
keep if rankocc <= 5 | rankocc >= `max'-4
egen rowtab = rank(skillintensity)
ren skillintensity skill_occ
merge 1:m occ_code using `tf_occ_titles', nogen keep(1 3) keepusing(occ_title)
save `tf1', replace
//Load skill intensities for industries
use "../output/naics2_skillintensities.dta", clear
drop if naics==92 //County Business Patterns don't include public administration or armed forces, so we drop them here
egen ranknaics = rank(skill)
summ ranknaics
local max = r(max)
keep if ranknaics <= 5 | ranknaics >= `max'-4
egen rowtab = rank(skillintensity)
ren skillintensity skill_naics
merge m:1 naics using "../input/naics_labels.dta", nogen keep(1 3) keepusing(naicsdescription)

//Merge and produce table
merge 1:1 rowtab using `tf1', nogen
compress
desc
label data "Skill intensities for Table 2 for ILF sample"
saveold "../output/`saveas'.dta", replace

//Switch to strings
foreach var of varlist skill_occ skill_naics {
	generate `var'_str = string(`var',"%3.1f")
}
foreach var of varlist occ_code naics {
	generate `var'_str = string(`var',"%3.0f")
}
//Add table header
local obs = 12
set obs `obs'
recode rowtab .=0 if _n == `obs'
recode rowtab .=-1 if _n == `obs' - 1
sort rowtab
replace occ_code_str = "\begin{tabular}{|clc|clc|} \hline" if rowtab==-1
replace occ_title="" if rowtab==-1
replace skill_occ_str="Skill" if rowtab==-1
replace naics_str="" if rowtab==-1
replace naicsdescription="" if rowtab==-1
replace skill_naics_str="Skill" if rowtab==-1
replace occ_code_str = "SOC" if rowtab==0
replace occ_title="Occupational category" if rowtab==0
replace skill_occ_str="intensity" if rowtab==0
replace naics_str="NAICS" if rowtab==0
replace naicsdescription="Industry" if rowtab==0
replace skill_naics_str="intensity" if rowtab==0
gen str lineender = "\\"
replace lineender = "\\ \hline" if rowtab==0 | rowtab==5
replace lineender = "\\ \hline\end{tabular}" if rowtab==10
replace skill_naics_str = skill_naics_str + " " + lineender
//Clean up
replace occ_title = subinstr(occ_title,"Building and Grounds Cleaning and Maintenance Occupations","Cleaning and Maintenance",1)
replace occ_title = subinstr(occ_title," Occupations","",1) if occ_title~="Legal Occupations"
replace naicsdescription = subinstr(naicsdescription,"services","",1) if naicsdescription=="Admin, support, waste mgt, remediation services"
replace occ_title = subinstr(occ_title,", and"," \&",1)
replace occ_title = subinstr(occ_title," and"," \&",.)
replace naicsdescription = subinstr(naicsdescription,", and"," \&",1)
replace naicsdescription = subinstr(naicsdescription," and"," \&",.)
drop ranknaics rankocc rowtab
keep  occ_code_str occ_title skill_occ_str naics_str naicsdescription skill_naics_str
order occ_code_str occ_title skill_occ_str naics_str naicsdescription skill_naics_str

export delimited occ_code_str occ_title skill_occ_str naics_str naicsdescription skill_naics_str using "../output/`saveas'.tex", delimiter("&") replace novarnames

end
