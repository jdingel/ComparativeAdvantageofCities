#Definitions
FOLDERS = ../input ../output slurmlogs
start_iters := $(shell seq 1 100 901)
iter_bins := 99
iter := 1000
empty:=
space:= $(empty) $(empty)

POP_OUTPUTS=$(foreach size,270 276,../input/MSA_POPDIF$(size)_2000.dta)
EDU_DATA = ../input/CAC_binned_edu.dta ../input/CAC_binned_edu_US.dta \
	../input/CAC_binned_edu_US_binassignments.dta ../input/CAC_binned_edu_binassignments.dta \
	../input/CAC_binned_edu_US_weights_edushares.dta ../input/CAC_binned_edu_weights_edushares.dta \
	../input/CAC_binned_edu_US_popthresh.dta ../input/CAC_binned_edu_popthresh.dta
NAICS_DATA = ../input/CAC_binned_naics.dta ../input/CAC_binned_naics_popthresh.dta ../input/CAC_binned_naics_skilldiff.dta
OCC_DATA = ../input/CAC_binned_occ.dta ../input/CAC_binned_occ_popthresh.dta ../input/CAC_binned_occ_skilldiff.dta

INPUTS=\
	../input/CAC_forpermutation.dta ../input/CMSA_POP2000.dta \
	../input/CAC_msaedufor_obs.dta \
	../input/CAC_FTFY_msaedufor_obs.dta \
	../input/PREP_CAC_1980.dta \
	../input/occ_skillintensities.dta ../input/occ_labels.dta \
	../input/CAC_CBP2000_naics2.dta \
	../input/naics2_skillintensities.dta ../input/naics_labels.dta \
	../input/OCCSOC2000.dta \
	../input/MSA_EDU_2000SF3.dta \
	$(POP_OUTPUTS) \
	$(EDU_DATA) $(NAICS_DATA) $(OCC_DATA)

RECODE = msarecode.do msarecode_naics.do msarecode_occ.do
EDU_PERMUTATIONS = $(foreach starts,$(start_iters),../output/edu9_270_$(starts).dta)
NAICS_PERMUTATIONS = $(foreach starts,$(start_iters),../output/naics_276_$(starts).dta)
OCC_PERMUTATIONS = $(foreach starts,$(start_iters),../output/occ_276_$(starts).dta)

#Recipes
all: $(FOLDERS) $(INPUTS) run.sbatch $(RECODE) $(EDU_PERMUTATIONS) $(NAICS_PERMUTATIONS) $(OCC_PERMUTATIONS) ../output/cdf_edu9_US.dta ../output/cdf_naics.dta ../output/cdf_occ.dta

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
../input/CAC_binned_edu.dta ../input/CAC_binned_edu_US.dta: | $(FOLDERS)
	if [ -e ../../permutation_prep/output/$(@F) ] ; then ln -s ../../permutation_prep/output/$(@F) ../input/ ; else exit 1; fi
$(foreach stub,weights_edushares binassignments popthresh,../input/CAC_binned_edu_$(stub).dta ../input/CAC_binned_edu_US_$(stub).dta): | $(FOLDERS)
	if [ -e ../../permutation_prep/output/$(@F) ] ; then ln -s ../../permutation_prep/output/$(@F) ../input/ ; else exit 1; fi
$(foreach size,270 276,../input/MSA_POPDIF$(size)_2000.dta): | $(FOLDERS)
	if [ -e ../../permutation_prep/output/$(@F) ] ; then ln -s ../../permutation_prep/output/$(@F) ../input/ ; else exit 1; fi
$(foreach group,naics occ,../input/CAC_binned_$(group).dta) $(foreach group,naics occ,../input/CAC_binned_$(group)_popthresh.dta) $(foreach group,naics occ,../input/CAC_binned_$(group)_skilldiff.dta):
	if [ -e ../../permutation_prep/output/$(@F) ] ; then ln -s ../../permutation_prep/output/$(@F) ../input/ ; else exit 1; fi

#Code
msarecode.do: ../input/CAC_binned_edu_US_popthresh.dta thresholds.do
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='thresholds.do "edu"' --mem-per-cpu=1g --job-name=threshes run.sbatch; else stata-se -e thresholds.do "edu" ; fi

msarecode_naics.do: ../input/CAC_binned_naics_popthresh.dta thresholds.do
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='thresholds.do "naics"' --mem-per-cpu=1g --job-name=threshes run.sbatch; else stata-se -e thresholds.do "naics" ; fi

msarecode_occ.do: ../input/CAC_binned_edu_US_popthresh.dta thresholds.do
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='thresholds.do "occ"' --mem-per-cpu=1g --job-name=threshes run.sbatch; else stata-se -e thresholds.do "occ" ; fi

#Outputs
$(EDU_PERMUTATIONS) : ../output/edu%.dta : $(RECODE) $(EDU_DATA) edu.do programs.do run.sbatch
	$(eval args := $(subst _,$(space),$*))
	$(eval startiter := $(word 3,$(args)))
	$(eval enditer := $(shell echo $$(( $(startiter) + $(iter_bins) )) ))
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='edu.do $(startiter) $(enditer)' --mem-per-cpu=20g --job-name=edu_$(startiter) run.sbatch; else stata-se -e edu.do $(startiter) $(enditer) ; fi

../output/cdf_edu9_US.dta: $(EDU_PERMUTATIONS) edu_out.do
	command echo "Start time: `date +"%F %T"`"
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='edu_out.do $(iter)' --mem-per-cpu=20g --job-name=edu_out run.sbatch; else stata-se -e edu.do $(iter) ; fi
	command echo "End time: `date +"%F %T"`"

$(NAICS_PERMUTATIONS) : ../output/naics_%.dta : naics.do msarecode_naics.do $(NAICS_DATA) programs.do run.sbatch
	$(eval args := $(subst _,$(space),$*))
	$(eval startiter := $(word 2,$(args)))
	$(eval enditer := $(shell echo $$(( $(startiter) + $(iter_bins) )) ))
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='naics.do $(startiter) $(enditer)' --mem-per-cpu=20g --job-name=naics_$(startiter) run.sbatch; else stata-se -e naics.do $(startiter) $(enditer) ; fi

../output/cdf_naics.dta: $(NAICS_PERMUTATIONS) naics_out.do programs.do run.sbatch
	command echo "Start time: `date +"%F %T"`"
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='naics_out.do $(iter)' --mem-per-cpu=20g --job-name=naics_out run.sbatch; else stata-se -e naics_out.do $(iter) ; fi
	command echo "End time: `date +"%F %T"`"

$(OCC_PERMUTATIONS) : ../output/occ_%.dta : occ.do msarecode_occ.do $(OCC_DATA) programs.do run.sbatch
	$(eval args := $(subst _,$(space),$*))
	$(eval startiter := $(word 2,$(args)))
	$(eval enditer := $(shell echo $$(( $(startiter) + $(iter_bins) )) ))
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='occ.do $(startiter) $(enditer)' --mem-per-cpu=20g --job-name=occ_$(startiter) run.sbatch; else stata-se -e occ.do $(startiter) $(enditer) ; fi

../output/cdf_occ.dta: $(OCC_PERMUTATIONS) occ_out.do programs.do run.sbatch
	command echo "Start time: `date +"%F %T"`"
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='occ_out.do $(iter)' --mem-per-cpu=20g --job-name=occ_out run.sbatch; else stata-se -e occ_out.do $(iter) ; fi
	command echo "End time: `date +"%F %T"`"
