// define programs
cap program drop pairwise_comparison_edu_table
program define pairwise_comparison_edu_table
syntax, tabnum(integer) saveas(string) var(string)

  foreach type in "all" "US" {
    tempfile tf_`type'
    use "../output/table`tabnum'_`type'_pvalues.dta", clear
    keep if type==lower("`type'")
    ren (`var' `var'_pvalue) (`var'_`type'0 `var'_`type'1)
    save `tf_`type'', replace
  }
  use bins comparisons `var'_all0 `var'_all1 using `tf_all', clear
  merge 1:1 bins using `tf_US', assert(match) keepusing(`var'_US0 `var'_US1) nogen
  reshape long `var'_all `var'_US, i(bins) j(stat)
  format comparisons %13.0fc
  format `var'_all `var'_US %3.2f
  gsort -bins stat
  replace comparisons=. if mod(_n,2)==0
  replace bins=. if mod(_n,2)==0
  drop stat
  order bins comparisons `var'_all `var'_US
  listtex bins comparisons `var'_all `var'_US using "../output/table`tabnum'.tex", replace rstyle(tabular) ///
  head("\begin{tabular}{cccc} \toprule" ///
  "     & Total       & Success rate & Success rate \\" ///
  "Bins & comparisons & All          & US-born  \\ \midrule") ///
  foot("\bottomrule \end{tabular}")

end


cap program drop pairwise_comparison_indocc_table
program define pairwise_comparison_indocc_table
syntax using/, tabnum(integer) saveas(string) var(string)

  use bins comparisons *`var'* using `using', clear
  ren *pvalue val1
  ren `var'* val0
  reshape long val, i(bins) j(stat)
  format val %3.2f
  format comparisons %13.0fc
  gsort -bins stat
  replace comparisons=. if mod(_n,2)==0
  replace bins=. if mod(_n,2)==0
  drop stat
  order bins comparisons val
  list
  listtex bins comparisons val using "../output/table`tabnum'.tex", replace rstyle(tabular) ///
  head("\begin{tabular}{ccc}" ///
  "     & Total       &  \\" ///
  "Bins & comparisons & Success rate \\ \toprule") ///
  foot("\bottomrule \end{tabular}")

end

// calls
pairwise_comparison_edu_table, tabnum(4) saveas("../output/table4.tex") var(outcome_popdiff)
pairwise_comparison_edu_table, tabnum(6) saveas("../output/table6.tex") var(outcome_popedu)
pairwise_comparison_indocc_table using "../output/table7_pvalues.dta", ///
                                 var(outcome_popdiffskilldif) ///
                                 tabnum(7) saveas("../output/table7.tex")
pairwise_comparison_indocc_table using "../output/table8_pvalues.dta", ///
                                 var(outcome_popdiffskilldif) ///
                                 tabnum(8) saveas("../output/table8.tex")
