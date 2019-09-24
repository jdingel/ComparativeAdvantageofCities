#Definitions
folders = ../input ../output slurmlogs

input=\
	../input/IPUMS2000.dta \
	../input/PUMA2000-MSA2000.dta \
	../input/CMSA_POP2000.dta

output=\
	../output/CAC_wagebins_obs.dta \
	../output/CAC_wagebinsdeflate_obs.dta \
	../output/wagebins_table.tex

#Recipes
all: $(folders) $(input) run.sbatch $(output) ../output/wagebins_table_clean.tex

$(folders):
	mkdir $@

run.sbatch:
	if [ -e ../../commoncode/code/run.sbatch ] ; then ln -s ../../commoncode/code/run.sbatch . ; else exit 1; fi

$(output): $(input) calls.do programs.do run.sbatch clean_tables.sh | $(folders)
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='calls.do' --mem-per-cpu=4g --job-name=wage_regressions run.sbatch; else stata-se -e calls.do ; fi

../output/wagebins_table_clean.tex: clean_tables.sh ../output/wagebins_table.tex
	bash clean_tables.sh

../input/CMSA_POP2000.dta ../input/IPUMS2000.dta ../input/PUMA2000-MSA2000.dta:
	if [ -e ../../initialdata/output/$(@F) ] ; then ln -s ../../initialdata/output/$(@F) $@ ; else exit 1; fi
