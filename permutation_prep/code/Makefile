#Definitions
FOLDERS = ../input ../output slurmlogs
INPUTS=../input/CAC_forpermutation.dta ../input/CMSA_POP2000.dta \
	../input/naics2_skillintensities.dta ../input/CAC_CBP2000_naics2.dta \
	../input/occ_skillintensities.dta ../input/OCCSOC2000.dta
POP_OUTPUTS=$(foreach size,270 276,../output/MSA_POPDIF$(size)_2000.dta)
EDU_DATA = ../output/CAC_binned_edu.dta ../output/CAC_binned_edu_US.dta ../output/CAC_binned_edu_US_popthresh.dta ../output/CAC_binned_edu_US_binassignments.dta
NAICS_DATA = ../output/CAC_binned_naics.dta ../output/CAC_binned_naics_popthresh.dta ../output/CAC_binned_naics_skilldiff.dta
OCC_DATA = ../output/CAC_binned_occ.dta ../output/CAC_binned_occ_popthresh.dta ../output/CAC_binned_occ_skilldiff.dta

#Recipes
all: $(FOLDERS) $(INPUTS) $(POP_OUTPUTS) ../output/CAC_binned_edu.dta ../output/CAC_binned_naics_popthresh.dta ../output/CAC_binned_occ_popthresh.dta

#Folder recipes
$(FOLDERS):
	mkdir $@

run.sbatch:
	if [ -e ../../commoncode/code/run.sbatch ] ; then ln -s ../../commoncode/code/run.sbatch . ; else exit 1; fi

#Inputs recipes
../input/CAC_forpermutation.dta ../input/MSA_EDU_2000SF3.dta ../input/CAC_FTFY_msaedufor_obs.dta ../input/CAC_msaedufor_obs.dta ../input/CMSA_POP2000.dta ../input/PREP_CAC_1980.dta ../input/IPUMS2000.dta ../input/PUMA2000-MSA2000.dta ../input/OCCSOC2000.dta ../input/CAC_CBP2000_naics2.dta ../input/naics_labels.dta ../input/occ_labels.dta: | $(FOLDERS)
	if [ -e ../../initialdata/output/$(@F) ] ; then ln -s ../../initialdata/output/$(@F) ../input/ ; else exit 1; fi
../input/occ_skillintensities.dta ../input/naics2_skillintensities.dta: | $(FOLDERS)
	if [ -e ../../skillintensities/output/$(@F) ] ; then ln -s ../../skillintensities/output/$(@F) ../input/ ; else exit 1; fi

# Outputs
$(POP_OUTPUTS): $(INPUTS) pop_calls.do programs.do run.sbatch
	command echo "Start time: `date +"%F %T"`"
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='pop_calls.do' --mem-per-cpu=5g --job-name=pop run.sbatch; else stata-se -e pop_calls.do ; fi
	command echo "End time: `date +"%F %T"`"

../output/CAC_binned_edu.dta: $(POP_OUTPUTS) edu_data.do programs.do run.sbatch
	command echo "Start time: `date +"%F %T"`"
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='edu_data.do' --mem-per-cpu=5g --job-name=edu run.sbatch; else stata-se -e edu_data.do ; fi
	command echo "End time: `date +"%F %T"`"

../output/CAC_binned_naics_popthresh.dta: ../input/naics2_skillintensities.dta ../input/CAC_CBP2000_naics2.dta naics_data.do run.sbatch
	command echo "Start time: `date +"%F %T"`"
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='naics_data.do' --mem-per-cpu=5g --job-name=naics run.sbatch; else stata-se -e naics_data.do ; fi
	command echo "End time: `date +"%F %T"`"

../output/CAC_binned_occ_popthresh.dta: ../input/OCCSOC2000.dta occ_data.do run.sbatch
	command echo "Start time: `date +"%F %T"`"
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='occ_data.do' --mem-per-cpu=5g --job-name=occ run.sbatch; else stata-se -e occ_data.do ; fi
	command echo "End time: `date +"%F %T"`"
