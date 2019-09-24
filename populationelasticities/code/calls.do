qui do "programs.do"

popelasticities_3skills, saveas(table3)
popelasticities_9skills, saveas(table5)
popelast_7skills_1980, saveas(tableE1)
popelasticites_occupations, tabsaveas(tableE2) figsaveas(figure1) figure(1)
popelasticities_industries using "../input/CAC_CBP2000_naics2.dta", tabsaveas(tableE3) figsaveas(figure2) figure(1) naics_digit(2)
popelast_3skills_alternative, saveas(tableE5_appendix)
popelast_9skills_alternative, saveas(tableE6_appendix)

edupop_graph, saveas(figure1_edu)
occpop_graph, saveas(figure2_occ)
naicspop_graph, saveas(figure3_naics2)
