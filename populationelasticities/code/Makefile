#Definitions
folders = ../input ../output slurmlogs

input=\
	../input/table1.dta \
	../input/tableE1_shares_1980.dta \
	../input/CMSA_POP2000.dta \
	../input/CAC_msaedufor_obs.dta \
	../input/CAC_FTFY_msaedufor_obs.dta \
	../input/PREP_CAC_1980.dta \
	../input/occ_skillintensities.dta \
	../input/occ_labels.dta \
	../input/CAC_CBP2000_naics2.dta \
	$(foreach dig,2 3,../input/naics$(dig)_skillintensities.dta) \
	../input/naics_labels.dta \
	../input/IPUMS2000.dta \
	../input/OCCSOC2000.dta \
	../input/MSA_EDU_2000SF3.dta

output=\
	../output/table3.tex \
	../output/table5.tex \
	../output/tableE1.tex \
	../output/tableE2_occupations.tex \
	../output/figure1_occupations.pdf \
	../output/tableE3_naics2.tex \
	../output/figure2_naics2.pdf \
	../output/tableE5_appendix.tex \
	../output/tableE6_appendix.tex \
	../output/figure1_edu.pdf \
	../output/figure2_occ.pdf \
	../output/figure3_naics2.pdf

TABLES = ../output/table3_clean.tex ../output/table5_clean.tex \
	../output/tableE2_occupations_clean.tex 

#Recipes
all: $(folders) $(input) run.sbatch $(output) $(TABLES) ../output/tableE3_naics2_clean.tex

../input ../output slurmlogs:
	mkdir $@

run.sbatch:
	if [ -e ../../commoncode/code/run.sbatch ] ; then ln -s ../../commoncode/code/run.sbatch . ; else exit 1; fi

$(output): $(input) calls.do programs.do run.sbatch | $(folders)
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='calls.do' --mem-per-cpu=5g --job-name=populationelasticities run.sbatch; else stata-se -e calls.do ; fi
	sed -i.bak 's/VARIABLES/Dependent variable: $$\\ln f(\\omega,c)$$/' ../output/tableE1.tex
	sed -i.bak 's/VARIABLES/Dependent variable: $$\\ln f(\\omega,c)$$/' ../output/tableE5_appendix.tex
	sed -i.bak 's/VARIABLES/Dependent variable: $$\\ln f(\\omega,c)$$/' ../output/tableE6_appendix.tex

$(TABLES): $(output) tables.do
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='tables.do' --mem-per-cpu=5g --job-name=popelast_tables run.sbatch; else stata-se -e tables.do ; fi

../output/tableE3_naics2_clean.tex: ../output/tableE3_naics2.tex
	bash tables.sh

../input/PUMA2000-MSA2000.dta ../input/OCCSOC2000.dta ../input/CAC_CBP2000_naics2.dta ../input/CAC_FTFY_msaedufor_obs.dta ../input/CAC_msaedufor_obs.dta ../input/MSA_EDU_2000SF3.dta ../input/CMSA_POP2000.dta ../input/PREP_CAC_1980.dta ../input/IPUMS2000.dta:
	if [ -e ../../initialdata/output/$(@F) ] ; then ln -s ../../initialdata/output/$(@F) ../input/ ; else exit 1; fi
../input/naics_labels.dta ../input/occ_labels.dta:
	if [ -e ../../initialdata/output/$(@F) ] ; then ln -s ../../initialdata/output/$(@F) ../input/ ; else exit 1; fi
../input/occ_skillintensities.dta $(foreach dig,2 3,../input/naics$(dig)_skillintensities.dta):
	if [ -e ../../skillintensities/output/$(@F) ] ; then ln -s ../../skillintensities/output/$(@F) ../input/ ; else exit 1; fi
../input/table1.dta ../input/tableE1_shares_1980.dta:
	if [ -e ../../shares/output/$(@F) ] ; then ln -s ../../shares/output/$(@F) ../input/ ; else exit 1; fi
