#Definitions
folders = ../input ../output slurmlogs

input=\
	../input/MSA_EDU_2000SF3.dta \
	../input/CAC_FTFY_msaedufor_obs.dta \
	../input/CAC_msaedufor_obs.dta \
	../input/CMSA_POP2000.dta \
	../input/PREP_CAC_1980.dta \
	../input/IPUMS2000.dta \
	../input/PUMA2000-MSA2000.dta \
	../input/OCCSOC2000.dta \
	../input/CAC_CBP2000_naics2.dta \
	../input/naics_labels.dta

output=\
	../output/table1.tex \
	../output/table1.dta \
	../output/tableE1_shares_1980.dta \
	../output/tableE4_appendix.tex

#Recipes
all: $(folders) $(input) run.sbatch $(output)

../input ../output slurmlogs:
	mkdir $@

run.sbatch:
	if [ -e ../../commoncode/code/run.sbatch ] ; then ln -s ../../commoncode/code/run.sbatch . ; else exit 1; fi

$(output): $(input) calls.do programs.do run.sbatch | $(folders)
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='calls.do' --mem-per-cpu=1g --job-name=shares run.sbatch; else stata-se -e calls.do ; fi
	sed -i.bak 's/^\(\&\&\&Associate\)/\\hline \1/' ../output/table1.tex
	sed -i.bak 's/^\(\&\&\&Master\)/\\hline \1/' ../output/table1.tex

../input/MSA_EDU_2000SF3.dta ../input/CAC_FTFY_msaedufor_obs.dta ../input/CAC_msaedufor_obs.dta ../input/CMSA_POP2000.dta ../input/PREP_CAC_1980.dta ../input/IPUMS2000.dta ../input/PUMA2000-MSA2000.dta ../input/OCCSOC2000.dta ../input/CAC_CBP2000_naics2.dta ../input/naics_labels.dta:
	if [ -e ../../initialdata/output/$(@F) ] ; then ln -s ../../initialdata/output/$(@F) ../input/ ; else exit 1; fi
