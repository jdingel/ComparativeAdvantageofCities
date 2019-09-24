

//COUNTY BUSINESS PATTERNS
cap program drop CBP_2000_naics3_norm
program define CBP_2000_naics3_norm

tempfile tf1 tf2 tf3 tf5

//LOADING NECMA POPULATION DATA AND APPENDING IT TO PMSA/CMSA POPULATION DATA
use "../output/NECMA2000_pop.dta", clear
ren necma_name msa_name //This is for the append command below, so that they are in the same column.
ren pop cmsa_pop //In order for columns to match in the append below.

append using "../output/CMSA_PMSA_POP2000.dta"
drop if regexm(msa_name,", PR") == 1 //Dropping Puerto-rican CMSAs
ren msa cmsa

//CREATING NECMA-CMSA MAPPINGS
replace pmsa=necma if pmsa==.

replace cmsa=necma if cmsa==.
replace cmsa=5602 if cmsa==5483		// New Haven NECMA is associated w/ New York CMSA
gsort cmsa -pmsa_pop

bys cmsa: egen cmsa_name=first(msa_name) //You need to install egenmore for this command to work (ssc install egenmore)
drop if substr(msa_name,-4,4)=="CMSA"	// Drop CMSA headings
gen msa=pmsa

save `tf1', replace //PMSA to CMSA reference

keep cmsa cmsa_name cmsa_pop
duplicates drop cmsa, force

save `tf2', replace //CMSA to NECMA reference

insheet using "../input/cbp00msa.txt", clear
keep if substr(naics,4,3)=="///" 	//Keep observations that are 3 digits
replace naics = substr(naics,1,3)	//Data only contains observations at 3-digit aggregation
destring naics, replace				//Convert 3-digit NAICS to numerical variable

/* CENSORING: Assign bin midpoint value to censored data for censoring flag A-L.
For flag M (100,000 or more), assign mean of observations with 100,000 or more employees.
*/
gen censored = (empflag!="")
replace emp = 10 if empflag=="A"
replace emp = 60 if empflag=="B"
replace emp = 175 if empflag=="C"
replace emp = 375 if empflag=="E"
replace emp = 750 if empflag=="F"
replace emp = 1750 if empflag=="G"
replace emp = 3750 if empflag=="H"
replace emp = 7500 if empflag=="I"
replace emp = 17500 if empflag=="J"
replace emp = 37500 if empflag=="K"
replace emp = 75000 if empflag=="L"
sum emp if emp>=100000
global M_mean = r(mean)
replace emp = $M_mean if empflag=="M" //Imputing mean when we have more than 100,000 employees.

merge m:1 msa using `tf1', keep(match) keepusing(cmsa) nogen
collapse (sum) aggreg_emp=emp est (max) censored, by(cmsa naics)
merge m:1 cmsa using `tf2', nogen keep(match)
gen msa = cmsa
recode msa 733 =730 743 =740 1303=1305 1123=1122 3283=3280 4243=4240 5523=5520 6323=6320 6403=6400 6483=6480 8003=8000

saveold "../output/CAC_CBP2000_naics3.dta", replace

end

//CALL
CBP_2000_naics3_norm

