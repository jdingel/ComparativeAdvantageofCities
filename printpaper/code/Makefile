# Definitions
folders=slurmlogs ../input ../output

input=\
	../input/table1.tex \
	../input/table2.tex \
	../input/table3_clean.tex \
	../input/table5_clean.tex \
	../input/table4.tex \
	../input/table6.tex \
	../input/table7.tex \
	../input/table8.tex \
	../input/figure4_occupations.pdf \
	../input/figure5_naics2.pdf \
	$(appendices)

appendices=\
	../input/figureE1C_skilldiff_naics2.pdf \
	../input/figureE1B_skilldiff_occ.pdf \
	../input/figureE1A_popdiff.pdf \
	../input/tableE1_withshares.tex \
	../input/tableE2_occupations_clean.tex \
	../input/tableE3_naics2_clean.tex \
	../input/tableE4_appendix.tex \
	../input/tableE5_appendix.tex \
	../input/tableE6_appendix.tex \
	../input/wagebins_table_clean.tex \
	../input/table4_appendix.tex \
	../input/table6_appendix.tex \
	../input/table7_appendix.tex \
	../input/table8_appendix.tex

# Recipes
all: $(folders) $(input) ../output/paper.pdf

$(folders):
	mkdir $@

../input/table1.tex ../input/tableE4_appendix.tex:
	if [ -e ../../shares/output/$(@F) ] ; then ln -s ../../shares/output/$(@F) ../input/ ; else exit 1; fi
../input/table2.tex:
	if [ -e ../../skillintensities/output/$(@F) ] ; then ln -s ../../skillintensities/output/$(@F) ../input/ ; else exit 1; fi
../input/table3_clean.tex ../input/table5_clean.tex ../input/figure4_occupations.pdf ../input/figure5_naics2.pdf:
	if [ -e ../../populationelasticities/output/$(@F) ] ; then ln -s ../../populationelasticities/output/$(@F) ../input/ ; else exit 1; fi
../input/tableE1_withshares.tex ../input/tableE2_occupations_clean.tex ../input/tableE3_naics2_clean.tex ../input/tableE5_appendix.tex ../input/tableE6_appendix.tex:
	if [ -e ../../populationelasticities/output/$(@F) ] ; then ln -s ../../populationelasticities/output/$(@F) ../input/ ; else exit 1; fi
../input/table4.tex ../input/table6.tex ../input/table4_appendix.tex ../input/table6_appendix.tex ../input/table7.tex ../input/table8.tex ../input/table7_appendix.tex ../input/table8_appendix.tex:
	if [ -e ../../pairwise_comparisons/output/$(@F) ] ; then ln -s ../../pairwise_comparisons/output/$(@F) ../input/ ; else exit 1; fi
../input/figureE1C_skilldiff_naics2.pdf ../input/figureE1B_skilldiff_occ.pdf ../input/figureE1A_popdiff.pdf:
	if [ -e ../../pairwise_comparisons/output/$(shell echo $(@F) | sed 's/figureE\([0-9]\)\([A-Z]\)/figureE\1.\2/') ] ; then ln -s ../../pairwise_comparisons/output/$(shell echo $(@F) | sed 's/figureE\([0-9]\)\([A-Z]\)/figureE\1.\2/') ../input/$(@F) ; else exit 1; fi
../input/wagebins_table_clean.tex:
	if [ -e ../../wage_regressions/output/$(@F) ] ; then ln -s ../../wage_regressions/output/$(@F) ../input/ ; else exit 1; fi

../output/paper.pdf: buildpaper.sh paper.tex $(input)
	bash buildpaper.sh
