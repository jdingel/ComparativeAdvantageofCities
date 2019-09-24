#Definitions
folders = ../input ../output slurmlogs

input=\
	../input/IPUMS2000.dta \
	../input/PUMA2000-MSA2000.dta \
	../input/OCCSOC2000.dta \
	../input/naics_labels.dta

output=\
	../output/naics3_skillintensities.dta \
	../output/naics2_skillintensities.dta \
	../output/occ_skillintensities.dta \
	../output/table2_raw.tex \
	../output/table2_raw.dta

#Recipes
all: $(folders) $(input) run.sbatch $(output) ../output/table2.tex

../input ../output slurmlogs:
	mkdir $@

run.sbatch:
	if [ -e ../../commoncode/code/run.sbatch ] ; then ln -s ../../commoncode/code/run.sbatch . ; else exit 1; fi

$(output): $(input) calls.do programs.do run.sbatch | $(folders)
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='calls.do' --mem-per-cpu=5g --job-name=skillintensities run.sbatch; else stata-se -e calls.do ; fi

../output/table2.tex: ../output/table2_raw.tex
	sed 's/"//g' $< > $@

../input/IPUMS2000.dta ../input/PUMA2000-MSA2000.dta ../input/OCCSOC2000.dta ../input/naics_labels.dta:
	if [ -e ../../initialdata/output/$(@F) ] ; then ln -s ../../initialdata/output/$(@F) ../input/ ; else exit 1; fi
