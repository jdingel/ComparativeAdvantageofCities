#Definitions
FOLDERS = ../input ../output slurmlogs

INPUTS=\
	../input/CAC_forpermutation.dta	\
	../input/CMSA_POP2000.dta \
	../input/CAC_msaedufor_obs.dta \
	../input/CAC_FTFY_msaedufor_obs.dta \
	../input/PREP_CAC_1980.dta \
	../input/occ_skillintensities.dta \
	../input/occ_labels.dta \
	../input/CAC_CBP2000_naics2.dta \
	../input/naics2_skillintensities.dta \
	../input/naics_labels.dta \
	../input/OCCSOC2000.dta \
	../input/MSA_EDU_2000SF3.dta \
	../input/CAC_binned_edu.dta ../input/CAC_binned_edu_US.dta \
	$(foreach stub,weights_edushares binassignments popthresh,../input/CAC_binned_edu_$(stub).dta ../input/CAC_binned_edu_US_$(stub).dta) \
	$(foreach size,270 276,../input/MSA_POPDIF$(size)_2000.dta) \
	$(foreach group,naics occ,../input/CAC_binned_$(group).dta) $(foreach group,naics occ,../input/CAC_binned_$(group)_popthresh.dta) $(foreach group,naics occ,../input/CAC_binned_$(group)_skilldiff.dta) \
	$(foreach bin, 2 3 5 10 30 90 270, ../input/cdf_edu3_bin$(bin).dta) \
	$(foreach bin, 2 3 5 10 30 90 270, ../input/cdf_edu3_US_bin$(bin).dta) \
	$(foreach bin, 2 3 5 10 30 90 270, ../input/cdf_edu9_bin$(bin).dta) \
	$(foreach bin, 2 3 5 10 30 90 270, ../input/cdf_edu9_US_bin$(bin).dta) \
	$(foreach bin, 2 3 5 10 30 90 276, ../input/cdf_naics_bin$(bin).dta) \
	$(foreach bin, 2 3 5 10 30 90 276, ../input/cdf_occ_bin$(bin).dta)

OUTPUTS=\
	../output/table4.dta \
	../output/table6.dta \
	../output/table7_occupations.dta \
	../output/table8_naics2.dta \
	$(addsuffix .dta, $(addprefix ../output/table4_,pvalues all_pvalues US_pvalues)) \
	$(addsuffix .dta, $(addprefix ../output/table6_,pvalues all_pvalues US_pvalues)) \
	../output/table7_pvalues.dta \
	../output/table8_pvalues.dta \
	$(foreach tab,main appendix,../output/table4_$(tab).tex) \
	$(foreach tab,main appendix,../output/table6_$(tab).tex) \
	$(foreach tab,main appendix, ../output/table7_$(tab).tex) \
	$(foreach tab,main appendix, ../output/table8_$(tab).tex) \
	../output/figureE1.A_popdiff.pdf \
	../output/figureE1.B_skilldiff_occ.pdf \
	../output/figureE1.C_skilldiff_naics2.pdf

TABLES = \
	../output/table4.tex \
	../output/table6.tex \
	../output/table7.tex \
	../output/table8.tex

#Recipes
all: $(FOLDERS) $(INPUTS) run.sbatch $(OUTPUTS) $(TABLES)

$(FOLDERS):
	mkdir $@

run.sbatch:
	if [ -e ../../commoncode/code/run.sbatch ] ; then ln -s ../../commoncode/code/run.sbatch . ; else exit 1; fi

$(OUTPUTS): $(INPUTS) calls.do programs.do run.sbatch | $(FOLDERS)
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='calls.do' --mem-per-cpu=20g --job-name=pairwise_comparisons run.sbatch; else stata-se -e calls.do ; fi
	sed -i 's/\&\&\(.*\)\&\(.*\)\&\(.*\)\&\(.*\)\\\\/\&\&\\footnotesize{\1}\&\\footnotesize{\2}\&\\footnotesize{\3}\&\\footnotesize{\4}\\\\/g' ../output/table4_appendix.tex
	sed -i 's/\&\&\(.*\)\&\(.*\)\&\(.*\)\&\(.*\)\&\(.*\)\&\(.*\)\\\\/\&\&\\footnotesize{\1}\&\\footnotesize{\2}\&\\footnotesize{\3}\&\\footnotesize{\4}\&\\footnotesize{\5}\&\\footnotesize{\6}\\\\/g' ../output/table6_appendix.tex

$(TABLES): $(OUTPUTS) tables.do run.sbatch
	if command -v sbatch > /dev/null ; then sbatch -W --export=dofile='tables.do' --mem-per-cpu=2g --job-name=tables run.sbatch; else stata-se -e tables.do ; fi
	sed -i 's/\&\&\(.*\)&\(.*\)\\\\/\&\&\\footnotesize{(\1)}\&\\footnotesize{(\2)}\\\\/g' ../output/table4.tex
	sed -i 's/\&\&\(.*\)&\(.*\)\\\\/\&\&\\footnotesize{(\1)}\&\\footnotesize{(\2)}\\\\/g' ../output/table6.tex
	sed -i 's/\&\&\(.*\)\\\\/\&\&\\footnotesize{(\1)}\\\\/g' ../output/table7.tex
	sed -i 's/\&\&\(.*\)\\\\/\&\&\\footnotesize{(\1)}\\\\/g' ../output/table8.tex

../input/CAC_forpermutation.dta:
	if [ -e ../../initialdata/output/CAC_forpermutation.dta ] ; then ln -s ../../initialdata/output/CAC_forpermutation.dta ../input/ ; else exit 1; fi
../input/MSA_EDU_2000SF3.dta:
	if [ -e ../../initialdata/output/$(@F) ] ; then ln -s ../../initialdata/output/$(@F) ../input/ ; else exit 1; fi
../input/CAC_FTFY_msaedufor_obs.dta ../input/CAC_msaedufor_obs.dta:
	if [ -e ../../initialdata/output/$(@F) ] ; then ln -s ../../initialdata/output/$(@F) ../input/ ; else exit 1; fi
../input/CMSA_POP2000.dta ../input/PREP_CAC_1980.dta:
	if [ -e ../../initialdata/output/$(@F) ] ; then ln -s ../../initialdata/output/$(@F) ../input/ ; else exit 1; fi
../input/IPUMS2000.dta ../input/PUMA2000-MSA2000.dta ../input/OCCSOC2000.dta ../input/CAC_CBP2000_naics2.dta:
	if [ -e ../../initialdata/output/$(@F) ] ; then ln -s ../../initialdata/output/$(@F) ../input/ ; else exit 1; fi
../input/naics_labels.dta ../input/occ_labels.dta:
	if [ -e ../../initialdata/output/$(@F) ] ; then ln -s ../../initialdata/output/$(@F) ../input/ ; else exit 1; fi
../input/occ_skillintensities.dta ../input/naics2_skillintensities.dta:
	if [ -e ../../skillintensities/output/$(@F) ] ; then ln -s ../../skillintensities/output/$(@F) ../input/ ; else exit 1; fi
$(foreach bin, 2 3 5 10 30 90 270, ../input/cdf_edu3_bin$(bin).dta) $(foreach bin, 2 3 5 10 30 90 270, ../input/cdf_edu3_US_bin$(bin).dta): | $(FOLDERS)
	if [ -e ../../permutation_tests/output/$(@F) ] ; then ln -s ../../permutation_tests/output/$(@F) ../input/ ; else exit 1; fi
$(foreach bin, 2 3 5 10 30 90 270, ../input/cdf_edu9_bin$(bin).dta) $(foreach bin, 2 3 5 10 30 90 270, ../input/cdf_edu9_US_bin$(bin).dta): | $(FOLDERS)
	if [ -e ../../permutation_tests/output/$(@F) ] ; then ln -s ../../permutation_tests/output/$(@F) ../input/ ; else exit 1; fi
$(foreach bin, 2 3 5 10 30 90 276, ../input/cdf_naics_bin$(bin).dta) $(foreach bin, 2 3 5 10 30 90 276, ../input/cdf_occ_bin$(bin).dta): | $(FOLDERS)
	if [ -e ../../permutation_tests/output/$(@F) ] ; then ln -s ../../permutation_tests/output/$(@F) ../input/ ; else exit 1; fi
../input/CAC_binned_edu.dta ../input/CAC_binned_edu_US.dta: | $(FOLDERS)
	if [ -e ../../permutation_prep/output/$(@F) ] ; then ln -s ../../permutation_prep/output/$(@F) ../input/ ; else exit 1; fi
$(foreach stub,weights_edushares binassignments popthresh,../input/CAC_binned_edu_$(stub).dta ../input/CAC_binned_edu_US_$(stub).dta): | $(FOLDERS)
	if [ -e ../../permutation_prep/output/$(@F) ] ; then ln -s ../../permutation_prep/output/$(@F) ../input/ ; else exit 1; fi
$(foreach size,270 276,../input/MSA_POPDIF$(size)_2000.dta): | $(FOLDERS)
	if [ -e ../../permutation_prep/output/$(@F) ] ; then ln -s ../../permutation_prep/output/$(@F) ../input/ ; else exit 1; fi
$(foreach group,naics occ,../input/CAC_binned_$(group).dta) $(foreach group,naics occ,../input/CAC_binned_$(group)_popthresh.dta) $(foreach group,naics occ,../input/CAC_binned_$(group)_skilldiff.dta):
	if [ -e ../../permutation_prep/output/$(@F) ] ; then ln -s ../../permutation_prep/output/$(@F) ../input/ ; else exit 1; fi
