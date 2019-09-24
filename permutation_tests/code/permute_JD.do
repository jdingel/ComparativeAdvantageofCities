local using "../input/CAC_binned_edu_US"
use "`using'_popthresh.dta", clear
sort Rperwt
qui levelsof Rperwt if inrange(_n,1,200)==1, local(threshes1)
qui levelsof Rperwt if inrange(_n,200,.)==1, local(threshes2)
local cutoff = Rperwt[200]
local threshes1_commas =  subinstr("`threshes1'"," ",",",.)
local threshes2_commas =  subinstr("`threshes2'"," ",",",.)
shell echo "gen fakemsa1 = recode(cum_pop,`threshes1_commas')" > fakemsarecode.do
shell echo "gen fakemsa2 = recode(cum_pop,`threshes2_commas')" >> fakemsarecode.do
shell echo "gen fakemsa = fakemsa1 if fakemsa1!=`cutoff'" >> fakemsarecode.do
shell echo "replace fakemsa = fakemsa2 if fakemsa1==`cutoff'" >> fakemsarecode.do

local using "../input/CAC_binned_edu_US"
timer on 3
use "`using'", clear
drop msa cmsa_pop
set seed 1
gen double shuffle = runiform()
sort shuffle
gen cum_pop = sum(perwt)
do fakemsarecode.do
timer off 3
gen id = _n

timer list