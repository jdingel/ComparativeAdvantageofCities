/****
Created by: Luis Costa/Jonathan Dingel
****/

/***********************
** PROGRAMS
***********************/

//**PROGRAM TO CONSTRUCT EDUCATIONAL GROUPS BASED ON 2000 SF3 DATA**//
cap program drop MSAEDU_2000SF3
program define MSAEDU_2000SF3

import delimited "../input/MSA_Edu_Census_SF3_2000.csv", clear varn(1)
drop if geoid2=="Id2"
destring geoid2 vd**, replace

ren vd01 pop25plus
ren geoid2 msa
ren geodisplaylabel msa_name

gen lessgrade9 = vd03 + vd04 + vd05 + vd06 + vd20 + vd21 + vd22 + vd23 //Below 9th grade
gen grade9to12 = vd07 + vd08 + vd09 + vd10 + vd24 + vd25 + vd26 + vd27 //Between 9th grade and 12th grade with no diploma
gen hs = vd11 + vd28 //High school diploma or equivalent (i.e. GED credential)
gen somecollege = vd12 + vd13 + vd29 + vd30 //Some college
gen associate = vd14 + vd31 //Associate's degree
gen ba = vd15 + vd32 //Bachelor's degree
gen master = vd16 + vd33 //Master's
gen prof = vd17 + vd34 //Professional school degree
gen phd = vd18 + vd35 //PhD

keep msa pop25plus msa_name lessgrade9 grade9to12 hs somecollege associate ba master prof phd

label var msa "Metropolitan Statistical Area (MSA) code"
label var msa_name "MSA name"
label var pop25plus "Population 25 and over"
label var lessgrade9 "Less than high school"
label var grade9to12 "High school dropout"
label var hs "High school graduate"
label var somecollege "College dropout"
label var associate "Associate's degree"
label var ba "Bachelor's degree"
label var master "Master's degree"
label var prof "Professional degree"
label var phd "PhD"

compress
desc
label data "Educational attainment data at the MSA level for the year 2000, using SF3 data."
saveold "../output/MSA_EDU_2000SF3.dta", replace

end
//**END OF PROGRAM TO CONSTRUCT EDUCATIONAL GROUPS BASED ON 2000 SF3 DATA**//

//**PROGRAM TO CONSTRUCT NECMA DELINEATIONS**//
cap program drop NECMA2000_delineations
program define NECMA2000_delineations

infix 14 firstlineoffile necma 1-4 str state 6-7 str county 9-11 str necma_name 15-110 str county_name 17-110 using "../input/Necmas-2000.txt", clear
drop if missing(necma)

//The data comes to us with two columns, one containing county and the other containing the state. I read them in as strings so as to not miss the leading 0's in the county codes, and then concatenate state and county to form count_fips.
egen fips = concat(state county)
destring fips, replace
drop state county
drop if regexm(necma_name,"Blank") == 1 //Drops two lines at the end of the data.
tempfile tf1
save `tf1', replace

keep if missing(fips) //These are the NECMAs
drop fips county_name

merge 1:m necma using `tf1', nogen
drop if missing(fips) //Now we have a file containing each NECMA and its county composition. These just drop the header lines with only NECMA.

label var necma "NECMA code"
label var necma_name "Necma name"

sort necma fips
order necma necma_name fips county_name

//Final arrangements and save
compress
desc
label data "NECMA Delineations: 2000"
saveold "../output/NECMA2000_delineations.dta", replace
end
//**END OF PROGRAM TO CONSTRUCT NECMA DELINEATIONS**//


//**PROGRAM TO CREATE 2000 NECMA POPULATIONS BY BUILDING UP FROM COUNTY POPULATION DATA**//
cap program drop NECMA2000_POP
program define NECMA2000_POP

//LOADING COUNTY DATA FOR THE YEAR 2000
import delimited "../input/county_population_1970to2014.csv", clear
keep *fips* *name* region division pop1970 pop2000 pop2010 pop2014
assert fips==county_fips | state_fips==2 | fips==12025| fips==30113| fips==51560| fips==51780 if missing(pop2000)==1 // missing(pop2000)==1 due to changes in county definitions or CSV's ugly two-records-per-county file structure
keep if missing(pop2000)==0
drop if county_fips==0 //Drop states
keep fips pop2000
rename (pop2000) (pop)
tempfile tf1
save `tf1', replace

//LOADING NECMA DELINEATIONS
use necma necma_name fips county_name if missing(necma)==0 using "../output/NECMA2000_delineations.dta", clear //Drops two counties that were assigned to NECMAS in 1993 and 2000 but not in 1983.
merge 1:1 fips using `tf1', gen(merge1)
drop if missing(necma) //Dropping counties that were not assigned to any NECMAs in 1983.
collapse (first) necma_name (sum) pop, by(necma)
ren necma_name necma_name
ren necma necma

sort necma
order necma_name necma pop

//Final arrangements and save
compress
desc
label data "NECMA Populations: 2000"
saveold "../output/NECMA2000_pop.dta", replace

end

//**END OF PROGRAM TO CONSTRUCT COUNTY POPULATION**//



//**PROGRAM TO CONSTRUCT MSA POPULATIONS FOR 1990 AND 2000, INCLUDING PMSA POPULATIONS**//
cap program drop msa_pop2000
program define msa_pop2000

tempfile tf1

//infix msa 1-4 pmsa 8-11 county 15-19 str msa_name 39-105 str pop 110-125 using "Population/Census/MSApop - 2000.txt", clear
infix 21 firstlineoffile msa 1-4 pmsa 8-11 county 15-19 str msa_name 39-105 str pop 110-125 using "../input/MSApop - 2000.txt", clear
replace pop = subinstr(pop,",","",.) //Must remove the commas from pop in order to allow it to be read as string
destring pop, force replace
keep if !missing(pop)

replace pmsa = msa if missing(pmsa)
duplicates drop pmsa, force
drop county

ren pop pmsa_pop

gsort msa -pmsa_pop

egen cmsa_pop = first(pmsa_pop), by(msa)

sort msa

compress
desc
label data "Population for MSAs in 2000 under 2000 delineations, including PMSA population"
saveold "../output/CMSA_PMSA_POP2000.dta", replace

//Dropping the PMSAs and keeping only the MSAs.
duplicates drop msa, force
keep msa msa_name cmsa_pop
generate logpop = log(cmsa_pop)
label data "Population for MSAs in 2000 under 2000 delineations"
saveold "../output/CMSA_POP2000.dta", replace

end
//**END OF PROGRAM TO CONSTRUCT MSA POPULATIONS FOR 1990 AND 2000, INCLUDING PMSA POPULATIONS**//



//**START OF PROGRAM TO PREPARE NAICS LABELS**//
cap program drop naics_labels
program define naics_labels

infix str naics 1-6 str naicsdescription 7-67 using "../input/naics_labels.txt", clear
drop if naics=="NAICS"|naicsdescription=="Total" //drop first and second lines
replace naics = subinstr(naics,"/","",.)
replace naics = subinstr(naics,"-","",.)
destring naics, replace
replace naicsdescription = subinstr(naicsdescription,"*","",.) if substr(naicsdescription,-1,1)=="*" //Trailing asterisk in NAICS descriptions
replace naicsdescription = subinstr(naicsdescription,"&","and",.)		//LaTeX doesn't like & in tables
save "../output/naics_labels.dta", replace

end
//**END OF PROGRAM TO PREPARE NAICS LABELS**//

//**START OF PROGRAM TO CREATE MAPPINGS FROM PUMAS TO MSAS**//
cap program drop PUMA2000_MSA2000
program define PUMA2000_MSA2000

//Loading PUMA-MSA mappings that will be used to merge with IPUMS individual data. This is for the 2000 PUMA delineations.
insheet using "../input/geocorr2k.csv", comma clear names
drop if pmsa=="pmsa" //this drops the first line of each variable, which are strings
destring state puma5 msacmsa pmsa pop2k afact, replace
ren state statefip
ren puma5 puma
bys statefip puma: egen double temp = max(afact) //Generates variable containing maximum afact value by statefip and puma. Afact measures the percentage of the population of a PUMA in an MSA.
drop if afact < temp - 0.0001
bys statefip puma: gen total = _N
drop if total>=2					/*This drops two PUMAs in Michigan that are tied for allocation to different CBSAs/non-CBSAs*/
drop temp pop2k total
sort statefip puma
ren msacmsa msa_code
drop if missing(msa_code) //Pumas that were not assigned to any CBSA in the 2000 census PUMA delineations.
keep statefip puma msa_code

label var statefip "State FIPS code"
label var puma "PUMA code"
label var msa_code "MSA FIPS code"

compress
desc
label data "One-to-one PUMA-CBSA mappings for 2000 PUMA delineations and 2000 MSA delineations."
saveold "../output/PUMA2000-MSA2000.dta", replace

end
//**END OF PROGRAM TO CREATE MAPPINGS FROM PUMAS TO MSAS**//




//PROGRAM THAT LOADS OCCUPATIONAL EMPLOYMENT STATISTICS
cap program drop load_OES_MSA
program define load_OES_MSA

//Loading data from the BLS. It comes in two files.
import excel "../input/msa_2000_dl_1.xls", clear cellrange(A43)
tempfile tf1
save `tf1', replace
import excel "../input/msa_2000_dl_2.xls", clear cellrange(A35)
append using `tf1'

//Clean variables
assert substr(B,-1,1)!="2"  //No CMSAs; all geographic units are PMSAs
rename (B C D E F G) (pmsa pmsa_name occ_code occ_title group tot_emp)
keep if group == "major" //Keeping major (two-digit) occupational groups
drop if strpos(pmsa_name,", PR ")!=0 //Drop Puerto Rican MSAs
assert substr(occ_code,3,5)=="-0000"
replace occ_code = substr(occ_code,1,2) //Drop trailing zeros from 2-digit OCC classifier
destring pmsa occ_code tot_emp, replace force
keep pmsa pmsa_name occ_code occ_title tot_emp

//Aggregate from PMSAs to CMSA
merge m:1 pmsa using "../output/CMSA_PMSA_POP2000.dta", keepusing(msa msa_name)
assert substr(string(pmsa),-1,1)=="2" | strpos(msa_name,", PR ")!=0 if _merge==2
drop if substr(string(pmsa),-1,1)=="2" | strpos(msa_name,", PR ")!=0 | _merge==2
drop msa_name _merge
collapse (first) occ_title (sum) emp_occgeo = tot_emp, by(msa occ_code)  //Collapse PMSAs into CMSAs where need be
drop if emp_occgeo==0

//Label variables
generate logemp = log(emp_occgeo)
label var occ_code "Occupational categories 2-digit code"
label var msa "(C)MSA FIPS code"
label var occ_title "Occupational category names"
label var emp_occgeo "Employment level of occupational category in given MSA"
label var logemp "Log of occupational category's employment level"

//Save
compress
desc
label data "OES data by (C)MSA in 2000 for 2-digit occupations"
saveold "../output/OCCSOC2000.dta", replace

//Save labels separately
collapse (firstnm)  occ_title, by(occ_code)
save "../output/occ_labels.dta", replace

end
//END OF PROGRAM THAT LOADS OCCUPATIONAL EMPLOYMENT STATISTICS


//**START OF PROGRAM TO LOAD AND CLEAN THE RAW IPUMS 2000 DATA**//
cap program drop IPUMS2000
program define IPUMS2000

use "../output/IPUMS_data_2000.dta", clear
drop if educd == 1 //Individuals whose educational attainment level is coded as N/A in the IPUMS (this is different than no sch at all).
//Creating years of schooling variable based on specifications provided by Dingel.

/*gen sch=.
recode sch .= 6 if educd==21
recode sch .= 8 if educd==24
recode sch .= 9 if educd==30
recode sch .= 10 if educd==40
recode sch .= 11 if educd==50
recode sch .= 12 if educd>=60 & educd<=71
recode sch .= 14 if educd>71 & educd<=83
recode sch .= 16 if educd==101 | educd==100
recode sch .= 18 if educd==114 | educd==110 | educd==111
recode sch .= 19 if educd==115 | educd==112
recode sch .= 21 if educd==116 | educd==113
*/
gen sch = educd
recode sch 2=0 10=3 21=6 24=8 30=9 40=10 50=11 60=12 61=12 62=12 ///
63=12 64=12 65=12 71=12 80=14 81=14 82=14 83=14 100=16 101=16 110=18 ///
114=18 112=19 115=19 113=21 116=21

//Creating foreign born dummies
gen foreign = 0
replace foreign = 1 if (bpl>=100 & bpl<=800)

//Creating educational groups
label define edu_labels 1 "Less than high school" 2 "High school dropout" 3 "High school graduate" 4 "College dropout" 5 "Associate's degree" 6 "Bachelor's degree" 7 "Master's degree" 8 "Professional degree" 9 "Doctorate"
gen edu = educd
recode edu 2=1 10=1 21=1 24=1 30=2 40=2 50=2 61=2 62=3 65=4 71=4 81=5 101=6 114=7 115=8 116=9
label values edu edu_labels

//Labelling variables
label var sch "Years of schooling (authors' calc from educd)"
label var foreign "Foreign-born person"

compress
desc
label data "Cleaned up IPUMS data for CAC paper replication"
saveold "../output/IPUMS2000.dta", replace

end
//**END OF PROGRAM TO LOAD AND CLEAN THE RAW IPUMS 2000 DATA**//


//COUNTY BUSINESS PATTERNS
cap program drop CBP_2000_naics2_norm
program define CBP_2000_naics2_norm

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

bys cmsa: egen cmsa_name=first(msa_name)
drop if substr(msa_name,-4,4)=="CMSA"	// Drop CMSA headings
gen msa=pmsa

save `tf1', replace //PMSA to CMSA reference

keep cmsa cmsa_name cmsa_pop
duplicates drop cmsa, force

save `tf2', replace //CMSA to NECMA reference

insheet using "../input/cbp00msa.txt", clear
keep if substr(naics,3,4)=="----" & naics~="------"	//Keep observations that are 2 digits
replace naics = substr(naics,1,2)	                //Data only contains observations at 2-digit aggregation
destring naics, replace				                //Convert 2-digit NAICS to numerical variable

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

merge m:1 msa using `tf1', keep(3) keepusing(cmsa) nogen
collapse (sum) aggreg_emp=emp est (max) censored, by(cmsa naics)
merge m:1 cmsa using `tf2', nogen keep(3)
gen msa = cmsa
recode msa 733 =730 743 =740 1303=1305 1123=1122 3283=3280 4243=4240 5523=5520 6323=6320 6403=6400 6483=6480 8003=8000

saveold "../output/CAC_CBP2000_naics2.dta", replace

end


//**START OF PROGRAM TO PREPARE FILE OF OBSERVATIONS WITH ALL LABOR-FORCE PARTICIPANTS OVER AGE 25 FOR THE YEAR 2000**//
cap program drop estimationarray
program define estimationarray

//Prepare file of observations with all labor-force participants over age 25
use "../output/IPUMS2000.dta", clear
keep if age >= 25 & empstat<=2  //Labor-force participants over age 25
drop if gq == 3 | gq == 4
keep year statefip puma edu foreign perwt
merge m:1 statefip puma using "../output/PUMA2000-MSA2000.dta", nogen keepusing(msa_code)
drop if missing(msa_code) | msa_code==9999 //This drops individuals who are located in PUMAs that are not assigned to any CBSA.
drop statefip puma
ren msa_code msa
merge m:1 msa using "../output/CMSA_POP2000.dta", nogen keep(1 3) keepusing(cmsa_pop)
label data "All labor-force participants over age 25 and the MSA population size"
save "../output/CAC_forpermutation.dta", replace
collapse (sum) perwt, by(year msa edu foreign)
label data "All labor-force participants over age 25"
save "../output/CAC_msaedufor_obs.dta", replace

end
//**END OF PROGRAM TO PREPARE FILE OF OBSERVATIONS WITH ALL LABOR-FORCE PARTICIPANTS OVER AGE 25 FOR THE YEAR 2000**//

//**START OF PROGRAM TO PREPARE FULL-TIME FULL-YEAR ESTIMATION ARRAY FOR APPENDIX TABLES**//
cap program drop FTFY_estimationarray
program define FTFY_estimationarray

//Prepare file of observations with all labor-force participants over age 25
use "../output/IPUMS2000.dta", clear
keep if age >= 25 & empstat<=2  //Labor-force participants over age 25
keep if wkswork>=40 & uhrswork>=35 //Full-time full-year specification only
drop if gq == 3 | gq == 4 //Drop those living in group quarters
keep year statefip puma edu foreign perwt
merge m:1 statefip puma using "../output/PUMA2000-MSA2000.dta", nogen keepusing(msa_code)
drop if missing(msa_code) | msa_code==9999 //This drops individuals who are located in PUMAs that are not assigned to any CBSA.
drop statefip puma
ren msa_code msa
merge m:1 msa using "../output/CMSA_POP2000.dta", nogen keep(1 3) keepusing(cmsa_pop)
collapse (sum) perwt, by(msa edu foreign)
label data "Full-time full-year workers over age 25"
save "../output/CAC_FTFY_msaedufor_obs.dta", replace

end
//**END OF PROGRAM TO PREPARE FULL-TIME FULL-YEAR ESTIMATION ARRAY FOR APPENDIX TABLES**//



//**START OF PROGRAM TO LOAD AND CLEAN THE RAW IPUMS 1980 DATA**//
cap program drop PREP_CAC_1980
program define PREP_CAC_1980

tempfile tf1  tf2 tf3 tf4 tf5 tf6 tf7

use "../output/IPUMS_data_1980.dta", clear
drop if metarea == 0 //Observations that weren't listed in an MSA in the IPUMS data

//Generating MSA populations
ren metarea msa
egen pop_msa = total(perwt), by(msa)

keep if age >= 25 & empstat<=2  //Labor-force participants over age 25
drop if gq == 3 | gq == 4
//Generating foreign born dummies
gen foreign = 0
replace foreign = 1 if (bpl>=100 & bpl<=800)
replace foreign = . if bpl==. | bpl==900 | bpl==950 | bpl==999
drop if missing(foreign)

//Generating educational category dummies.
generate edu = "Less than grade 9" if educ <= 2 //Below 9th grade
replace edu = "Grades 9 to 11" if educ<=5 & educ >= 3 //Between 9th grade and 11th grade
replace edu = "Grade 12" if educ == 6 //Grade 12
replace edu = "1 year college" if  educ == 7 //1 year of college
replace edu = "1 year college" if educd == 65 //People who have less than one year of college are in educ 6 but we want them to be in the 1 year of college category.
replace edu = "2-3 years college" if educ == 8 | educ == 9 //2 or 3 years of college
replace edu = "4 years college" if educ==10 //4 years of college
replace edu = "5+ years college" if educ==11 //5+ years of college

//This defines an order so that when we tabulate the variables are ordered not in alphabetical order but by level of education, as defined below.
label define ord 1 "Less than grade 9" 2 "Grades 9 to 11" 3 "Grade 12" 4 "1 year college" 5 "2-3 years college" 6 "4 years college" 7 "5+ years college"
encode edu, label(ord) gen(c2)
drop edu
ren c2 edu

//Labelling variables
label var foreign "Foreign-born person"
label var edu "Educational attainment level"

compress
desc
label data "Census 1980 data prepped for CAC paper replication"
saveold "../output/PREP_CAC_1980.dta", replace

end
//**END OF PROGRAM TO LOAD AND CLEAN THE RAW IPUMS 1980 DATA**//
