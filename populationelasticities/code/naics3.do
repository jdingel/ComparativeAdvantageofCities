
cap program drop popelast_naics3 //CAC_table11
program define popelast_naics3 //CAC_table11

syntax, figure(integer) tabsaveas(string) figsaveas(string)

use "../input/CAC_CBP2000_naics3.dta", clear
rename aggreg_emp emp_indgeo
keep naics msa emp_indgeo cmsa_pop censored
generate logpop = log(cmsa_pop)
generate logemp = log(emp_indgeo)

drop if naics==95 | naics==99
merge m:1 naics using "../input/naics3_skillintensities.dta", nogen keep(1 3) //naics==95 is auxiliary establishments in CBP; naics==99 is unclassified

//Generate skill-intensity ranks
tempfile tf1 tf2
save `tf1'.dta, replace
collapse (firstnm) skillintensity, by(naics)
drop if missing(skillintensity)
egen skillintensityrank = rank(skillintensity)
save `tf2'.dta, replace
use `tf1'.dta, clear
merge m:1 naics using `tf2'.dta, keepusing(skillintensityrank) nogen
merge m:1 naics using "../input/naics_labels.dta", nogen keep(1 3) keepusing(naicsdescription)

//Generate regressors
summ skillintensityrank
local groups = r(max)
forvalues x = 1/`groups'{
	gen logpop_`x' = logpop * (skillintensityrank==`x')
	gsort -logpop_`x'
	local naicslabel = naicsdescrip[1]
	label var logpop_`x' "\$\beta_{\sigma`x'}\$ `naicslabel'"
}
//Regression including all observations
areg logemp logpop_* , vce(cluster msa) absorb(naics)
outreg2 using "../output/`tabsaveas'_naics3.tex", replace label nocons noaster nonotes tex(pr landscape frag)  ctitle(All) addtext(Industry fixed effects, Yes)
mat fails = (0)
forvalues x = 1/`groups'{
	forvalues y = `x'/`groups'{
		if _b[logpop_`x'] > _b[logpop_`y'] {
			qui test (logpop_`x' = logpop_`y')
			local result = r(p)
			if `result' <= .05 mat fails = fails + (1)
		}
	}
}
mat list fails

//Regression including only uncensored observations
areg logemp logpop_* if censored == 0, vce(cluster msa) absorb(naics)
outreg2 using "../output/`tabsaveas'_naics3.tex", append label nocons noaster nonotes tex(pr landscape frag) ctitle(Uncensored) addtext(Industry fixed effects, Yes, Only uncensored observations, Yes)
mat fails = (0)
forvalues x = 1/`groups'{
	forvalues y = `x'/`groups'{
		if _b[logpop_`x'] > _b[logpop_`y'] {
			qui test (logpop_`x' = logpop_`y')
			local result = r(p)
			if `result' <= .05 mat fails = fails + (1)
		}
	}
}
mat list fails

if `figure' == 1{
//Regression including all observations: Scatterplot
areg logemp logpop_* , vce(cluster msa) absorb(naics)
parmest, norestore
drop if parm=="_cons"
ren estimate populationelasticity
gen str skillintensityrank=subinstr(parm,"logpop_","",1) if substr(parm,1,7)=="logpop_"
destring skillintensityrank, replace
merge 1:1 skillintensityrank using `tf2'.dta, nogen keep(1 3) keepusing(naics skillintensity)
merge 1:1 naics using "../input/naics_labels.dta", nogen keep(1 3) keepusing(naicsdescription)
gen labelposition = 3
replace labelposition = 9 if naics==61|naics==54|naics==55|naics==72|naics==48
replace labelposition = 8 if naics==42
replace labelposition = 2 if naics==52|naics==51
replace labelposition = 1 if naics==56
replace labelposition = 11 if naics==52
twoway (scatter populationelasticity skillintensity, mlabel(naicsdescription) mlabvposition(labelposition) mlabsize(vsmall) mlabcolor(gs8) msymbol(Oh) mcolor(black)), xtitle("Skill intensity (employees' average years of schooling)") graphregion(color(white)) ylabel(,nogrid)
graph export "../output/`figsaveas'_naics3.pdf", as(pdf) replace
}
end


popelast_naics3, tabsaveas(table_naics3) figsaveas(fig_naics3) figure(1)
