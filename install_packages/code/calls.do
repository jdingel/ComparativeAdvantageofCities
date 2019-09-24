clear all

capture which _gxtile //This is the name of the ado file for the "egenmore" package
if _rc==111 ssc install egenmore
foreach package in outreg2 listtex parmest nearmrg reghdfe {
	capture which `package'
	if _rc==111 ssc install `package'
}


file open outfile using "stata_packages.txt", write replace text
file write outfile "Package installation commands ran." _n
file close outfile
