#Definitions
folders = ../input ../output slurmlogs

OES_data  = ../input/msa_2000_dl_1.xls ../input/msa_2000_dl_2.xls
downloads = ../input/cbp00msa.txt $(OES_data)

input=\
	../input/IPUMS_1980.dat \
	../input/IPUMS_2000.dat \
	../input/MSA_Edu_Census_SF3_2000.csv \
	../input/Necmas-2000.txt \
	../input/county_population_1970to2014.csv \
	../input/naics_labels.txt \
	../input/geocorr2k.csv \
	$(downloads)

output=\
	../output/IPUMS_data_1980.dta \
	../output/IPUMS_data_2000.dta \
	../output/MSA_EDU_2000SF3.dta \
	../output/NECMA2000_delineations.dta \
	../output/NECMA2000_pop.dta \
	../output/CMSA_PMSA_POP2000.dta \
	../output/CMSA_POP2000.dta \
	../output/naics_labels.dta \
	../output/occ_labels.dta \
	../output/PUMA2000-MSA2000.dta \
	../output/OCCSOC2000.dta \
	../output/PREP_CAC_1980.dta \
	../output/IPUMS2000.dta \
	../output/CAC_CBP2000_naics2.dta \
	../output/CAC_forpermutation.dta \
	../output/CAC_msaedufor_obs.dta \
	../output/CAC_FTFY_msaedufor_obs.dta

#Recipes
all: $(folders) $(input) run.sbatch $(output)

slurmlogs ../input ../output:
	mkdir $@

run.sbatch:
	if [ -e ../../commoncode/code/run.sbatch ] ; then ln -s ../../commoncode/code/run.sbatch . ; else exit 1; fi

#Inputs recipes
../input/msa_2000_dl_1.xls ../input/msa_2000_dl_2.xls ../input/cbp00msa.txt:
	if [ -e ../../downloaddata/output/$(@F) ] ; then ln -s ../../downloaddata/output/$(@F) ../input/ ; else exit 1; fi

#Relabel and Clean
$(output): $(input) calls.do CAC_PREP_IPUMS_1980.do CAC_PREP_IPUMS_2000.do programs.do run.sbatch | $(folders)
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='calls.do' --mem-per-cpu=4g --job-name=initialdata run.sbatch; else stata-se -e calls.do ; fi
