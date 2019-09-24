set more off
qui do "programs.do"

wagebins_estarray, saveas(../output/CAC_wagebins_obs.dta)
wagebins_estarray, saveas(../output/CAC_wagebinsdeflate_obs.dta) deflate

popelasticities_wagebins using "../output/CAC_wagebins_obs.dta", saveas("../output/wagebins_table")
popelasticities_wagebins using "../output/CAC_wagebinsdeflate_obs.dta", saveas("../output/wagebins_table") append
