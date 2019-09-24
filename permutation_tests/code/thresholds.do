//generate recode code

local group = "`1'"

if "`group'"=="edu" {
  foreach stub in "_US" "" {
   local using =  "../input/CAC_binned_edu" + "`stub'"
   use "`using'_popthresh.dta", clear
   sort Rperwt
   qui levelsof Rperwt if inrange(_n,1,200)==1, local(threshes1)
   qui levelsof Rperwt if inrange(_n,200,.)==1, local(threshes2)
   local cutoff = Rperwt[200]
   local threshes1_commas =  subinstr("`threshes1'"," ",",",.)
   local threshes2_commas =  subinstr("`threshes2'"," ",",",.)
   shell echo "gen fakemsa1 = recode(Rperwt,`threshes1_commas')" > msarecode`stub'.do
   shell echo "gen fakemsa2 = recode(Rperwt,`threshes2_commas')" >> msarecode`stub'.do
   shell echo "gen new_pop = fakemsa1 if fakemsa1!=`cutoff'" >> msarecode`stub'.do
   shell echo "replace new_pop = fakemsa2 if fakemsa1==`cutoff'" >> msarecode`stub'.do
  }
}
else {
  use "../input/CAC_binned_`group'_popthresh.dta", clear
  sort Rperwt
  qui levelsof Rperwt if inrange(_n,1,200)==1, local(threshes1)
  qui levelsof Rperwt if inrange(_n,200,.)==1, local(threshes2)
  local cutoff = Rperwt[200]
  local threshes1_commas =  subinstr("`threshes1'"," ",",",.)
  local threshes2_commas =  subinstr("`threshes2'"," ",",",.)
  shell echo "gen fakemsa1 = recode(Rperwt,`threshes1_commas')" > msarecode_`group'.do
  shell echo "gen fakemsa2 = recode(Rperwt,`threshes2_commas')" >> msarecode_`group'.do
  shell echo "gen new_pop = fakemsa1 if fakemsa1!=`cutoff'" >> msarecode_`group'.do
  shell echo "replace new_pop = fakemsa2 if fakemsa1==`cutoff'" >> msarecode_`group'.do
}
