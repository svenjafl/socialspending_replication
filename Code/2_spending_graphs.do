
use "$datapath/dataset_for_analysis.dta", clear

sort country year

* percentCG
local var "percent_education_CG percent_environment_CG percent_health_CG percent_housing_CG percent_recreation_CG percent_socialexp_CG percent_socialprot_CG percent_total_CG"
br country year `var' if cid==12

* percapitaCG
local var "percapita_education_CG percapita_environment_CG percapita_health_CG percapita_housing_CG percapita_recreation_CG percapita_socialexp_CG percapita_socialprot_CG percapita_total_CG"

* percentGG
local var "percent_education_GG percent_environment_GG percent_health_GG percent_housing_GG percent_recreation_GG percent_socialexp_GG percent_socialprot_GG percent_total_GG"

* percapita GG
local var "percapita_education_GG percapita_environment_GG percapita_health_GG percapita_housing_GG percapita_recreation_GG percapita_socialexp_GG percapita_socialprot_GG percapita_total_GG"

* percentNFPS
local var "percent_education_NFPS percent_environment_NFPS percent_health_NFPS percent_housing_NFPS percent_recreation_NFPS percent_socialexp_NFPS percent_socialprot_NFPS percent_total_NFPS"

* percapita NFPS
local var "percapita_education_NFPS percapita_environment_NFPS percapita_health_NFPS percapita_housing_NFPS percapita_recreation_NFPS percapita_socialexp_NFPS percapita_socialprot_NFPS percapita_total_NFPS"

*** Central Government Graphs ***
*** Percent of GDP ***

forval i = 1/19 {
local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
graph bar (sum) percent_education_CG percent_environment_CG percent_health_CG percent_housing_CG percent_recreation_CG percent_socialprot_CG if cid==`i', ///
over(year, sort(order) label(labsize(vsmall) angle(45))  gap(50)) outergap(50) stack ///
bar(1, color(227 5 19) lcolor(227 5 19) lwidth(vthin)) ///
bar(2, color(gs3) lcolor(gs3) lwidth(vthin)) ///
bar(3, color(239 124 0*0.5) lcolor(239 124 0*0.5) lwidth(vthin))	 ///
bar(4, color(239 124 0) lcolor(239 124 0) lwidth(vthin))	///
bar(5, color(cranberry) lcolor(gs9) lwidth(vthin))	///
bar(6, color(gs9) lcolor(gs9) lwidth(vthin))	///
title("`label' - Public social spending as % of GDP - Central Government", margin(small) size(medsmall) color(black)) ///
ytitle("Percent of GDP", size(medsmall) color(black)) ///
legend(label(1 "Education") label(2 "Environment") label(3 "Health") label(4 "Housing") label(5 "Recreation") label(6 "Social Protection") col(3) colgap(3.5) size(small) symxsize(7) keygap(1.5) bmargin(medsmall)) ///
	plotregion(lcolor(black) lwidth(thin) margin(zero)) ///
	graphregion(color(white))
graph save Graph "$datapath/graphs comparison/`label'_percent_CG.gph", replace
graph export "$datapath/graphs comparison/`label'_percent_CG.png", replace
}

*** Percapita ***

forval i = 1/19 {
local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
graph bar (sum) percapita_education_CG percapita_environment_CG percapita_health_CG percapita_housing_CG percapita_recreation_CG percapita_socialprot_CG if cid==`i', ///
over(year, sort(order) label(labsize(vsmall) angle(45))  gap(50)) outergap(50) stack ///
bar(1, color(227 5 19) lcolor(227 5 19) lwidth(vthin)) ///
bar(2, color(gs3) lcolor(gs3) lwidth(vthin)) ///
bar(3, color(239 124 0*0.5) lcolor(239 124 0*0.5) lwidth(vthin))	 ///
bar(4, color(239 124 0) lcolor(239 124 0) lwidth(vthin))	///
bar(5, color(cranberry) lcolor(gs9) lwidth(vthin))	///
bar(6, color(gs9) lcolor(gs9) lwidth(vthin))	///
title("`label' - Public social spending, per capita in USD  - Central Government", margin(small) size(medsmall) color(black)) ///
ytitle("Per capita spending, in USD", size(medsmall) color(black)) ///
legend(label(1 "Education") label(2 "Environment") label(3 "Health") label(4 "Housing") label(5 "Recreation") label(6 "Social Protection") col(3) colgap(3.5) size(small) symxsize(7) keygap(1.5) bmargin(medsmall)) ///
	plotregion(lcolor(black) lwidth(thin) margin(zero)) ///
	graphregion(color(white))
graph save Graph "$datapath/graphs comparison/`label'_percapita_CG.gph", replace
graph export "$datapath/graphs comparison/`label'_percapita_CG.png", replace
}

*** Argentina NFPS ***
forval i = 1/1 {
local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
graph bar (sum) percent_education_NFPS percent_environment_NFPS percent_health_NFPS percent_housing_NFPS percent_recreation_NFPS percent_socialprot_NFPS if cid==`i', ///
over(year, sort(order) label(labsize(vsmall) angle(45))  gap(50)) outergap(50) stack ///
bar(1, color(227 5 19) lcolor(227 5 19) lwidth(vthin)) ///
bar(2, color(gs3) lcolor(gs3) lwidth(vthin)) ///
bar(3, color(239 124 0*0.5) lcolor(239 124 0*0.5) lwidth(vthin))	 ///
bar(4, color(239 124 0) lcolor(239 124 0) lwidth(vthin))	///
bar(5, color(cranberry) lcolor(gs9) lwidth(vthin))	///
bar(6, color(gs9) lcolor(gs9) lwidth(vthin))	///
title("`label' - Public social spending as % of GDP - Non-financial public sector", margin(small) size(medsmall) color(black)) ///
ytitle("Percent of GDP", size(medsmall) color(black)) ///
legend(label(1 "Education") label(2 "Environment") label(3 "Health") label(4 "Housing") label(5 "Recreation") label(6 "Social Protection") col(3) colgap(3.5) size(small) symxsize(7) keygap(1.5) bmargin(medsmall)) ///
	plotregion(lcolor(black) lwidth(thin) margin(zero)) ///
	graphregion(color(white))
graph save Graph "$datapath/graphs comparison/`label'_percent_NFPS.gph", replace
graph export "$datapath/graphs comparison/`label'_percent_NFPS.png", replace
}

forval i = 1/1 {
local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
graph bar (sum) percapita_education_NFPS percapita_environment_NFPS percapita_health_NFPS percapita_housing_NFPS percapita_recreation_NFPS percapita_socialprot_NFPS if cid==`i', ///
over(year, sort(order) label(labsize(vsmall) angle(45))  gap(50)) outergap(50) stack ///
bar(1, color(227 5 19) lcolor(227 5 19) lwidth(vthin)) ///
bar(2, color(gs3) lcolor(gs3) lwidth(vthin)) ///
bar(3, color(239 124 0*0.5) lcolor(239 124 0*0.5) lwidth(vthin))	 ///
bar(4, color(239 124 0) lcolor(239 124 0) lwidth(vthin))	///
bar(5, color(cranberry) lcolor(gs9) lwidth(vthin))	///
bar(6, color(gs9) lcolor(gs9) lwidth(vthin))	///
title("`label' - Public social spending, per capita in USD - Non-financial public sector", margin(small) size(medsmall) color(black)) ///
ytitle("Per capita spending, in USD", size(medsmall) color(black)) ///
legend(label(1 "Education") label(2 "Environment") label(3 "Health") label(4 "Housing") label(5 "Recreation") label(6 "Social Protection") col(3) colgap(3.5) size(small) symxsize(7) keygap(1.5) bmargin(medsmall)) ///
	plotregion(lcolor(black) lwidth(thin) margin(zero)) ///
	graphregion(color(white))
graph save Graph "$datapath/graphs comparison/`label'_percapita_NFPS.gph", replace
graph export "$datapath/graphs comparison/`label'_percapita_NFPS.png", replace
}

*** Brazil GG ***
forval i = 3/3 {
local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
graph bar (sum) percent_education_GG percent_environment_GG percent_health_GG percent_housing_GG percent_recreation_GG percent_socialprot_GG if cid==`i' & year>1999, ///
over(year, sort(order) label(labsize(vsmall) angle(45))  gap(50)) outergap(50) stack ///
bar(1, color(227 5 19) lcolor(227 5 19) lwidth(vthin)) ///
bar(2, color(gs3) lcolor(gs3) lwidth(vthin)) ///
bar(3, color(239 124 0*0.5) lcolor(239 124 0*0.5) lwidth(vthin))	 ///
bar(4, color(239 124 0) lcolor(239 124 0) lwidth(vthin))	///
bar(5, color(cranberry) lcolor(gs9) lwidth(vthin))	///
bar(6, color(gs9) lcolor(gs9) lwidth(vthin))	///
title("`label' - Public social spending as % of GDP - General government", margin(small) size(medsmall) color(black)) ///
ytitle("Percent of GDP", size(medsmall) color(black)) ///
legend(label(1 "Education") label(2 "Environment") label(3 "Health") label(4 "Housing") label(5 "Recreation") label(6 "Social Protection") col(3) colgap(3.5) size(small) symxsize(7) keygap(1.5) bmargin(medsmall)) ///
	plotregion(lcolor(black) lwidth(thin) margin(zero)) ///
	graphregion(color(white))
graph save Graph "$datapath/graphs comparison/`label'_percent_GG.gph", replace
graph export "$datapath/graphs comparison/`label'_percent_GG.png", replace
}

forval i = 3/3 {
local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
graph bar (sum) percapita_education_GG percapita_environment_GG percapita_health_GG percapita_housing_GG percapita_recreation_GG percapita_socialprot_GG if cid==`i' & year>1999, ///
over(year, sort(order) label(labsize(vsmall) angle(45))  gap(50)) outergap(50) stack ///
bar(1, color(227 5 19) lcolor(227 5 19) lwidth(vthin)) ///
bar(2, color(gs3) lcolor(gs3) lwidth(vthin)) ///
bar(3, color(239 124 0*0.5) lcolor(239 124 0*0.5) lwidth(vthin))	 ///
bar(4, color(239 124 0) lcolor(239 124 0) lwidth(vthin))	///
bar(5, color(cranberry) lcolor(gs9) lwidth(vthin))	///
bar(6, color(gs9) lcolor(gs9) lwidth(vthin))	///
title("`label' - Public social spending, per capita in USD - General government", margin(small) size(medsmall) color(black)) ///
ytitle("Per capita spending, in USD", size(medsmall) color(black)) ///
legend(label(1 "Education") label(2 "Environment") label(3 "Health") label(4 "Housing") label(5 "Recreation") label(6 "Social Protection") col(3) colgap(3.5) size(small) symxsize(7) keygap(1.5) bmargin(medsmall)) ///
	plotregion(lcolor(black) lwidth(thin) margin(zero)) ///
	graphregion(color(white))
graph save Graph "$datapath/graphs comparison/`label'_percapita_GG.gph", replace
graph export "$datapath/graphs comparison/`label'_percapita_GG.png", replace
}

*** Peru GG ***
forval i = 17/17 {
local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
graph bar (sum) percent_education_GG percent_environment_GG percent_health_GG percent_housing_GG percent_recreation_GG percent_socialprot_GG if cid==`i', ///
over(year, sort(order) label(labsize(vsmall) angle(45))  gap(50)) outergap(50) stack ///
bar(1, color(227 5 19) lcolor(227 5 19) lwidth(vthin)) ///
bar(2, color(gs3) lcolor(gs3) lwidth(vthin)) ///
bar(3, color(239 124 0*0.5) lcolor(239 124 0*0.5) lwidth(vthin))	 ///
bar(4, color(239 124 0) lcolor(239 124 0) lwidth(vthin))	///
bar(5, color(cranberry) lcolor(gs9) lwidth(vthin))	///
bar(6, color(gs9) lcolor(gs9) lwidth(vthin))	///
title("`label' - Public social spending as % of GDP - General government", margin(small) size(medsmall) color(black)) ///
ytitle("Percent of GDP", size(medsmall) color(black)) ///
legend(label(1 "Education") label(2 "Environment") label(3 "Health") label(4 "Housing") label(5 "Recreation") label(6 "Social Protection") col(3) colgap(3.5) size(small) symxsize(7) keygap(1.5) bmargin(medsmall)) ///
	plotregion(lcolor(black) lwidth(thin) margin(zero)) ///
	graphregion(color(white))
graph save Graph "$datapath/graphs comparison/`label'_percent_GG.gph", replace
graph export "$datapath/graphs comparison/`label'_percent_GG.png", replace
}

forval i = 17/17 {
local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
graph bar (sum) percapita_education_GG percapita_environment_GG percapita_health_GG percapita_housing_GG percapita_recreation_GG percapita_socialprot_GG if cid==`i', ///
over(year, sort(order) label(labsize(vsmall) angle(45))  gap(50)) outergap(50) stack ///
bar(1, color(227 5 19) lcolor(227 5 19) lwidth(vthin)) ///
bar(2, color(gs3) lcolor(gs3) lwidth(vthin)) ///
bar(3, color(239 124 0*0.5) lcolor(239 124 0*0.5) lwidth(vthin))	 ///
bar(4, color(239 124 0) lcolor(239 124 0) lwidth(vthin))	///
bar(5, color(cranberry) lcolor(gs9) lwidth(vthin))	///
bar(6, color(gs9) lcolor(gs9) lwidth(vthin))	///
title("`label' - Public social spending, per capita in USD - General government", margin(small) size(medsmall) color(black)) ///
ytitle("Per capita spending, in USD", size(medsmall) color(black)) ///
legend(label(1 "Education") label(2 "Environment") label(3 "Health") label(4 "Housing") label(5 "Recreation") label(6 "Social Protection") col(3) colgap(3.5) size(small) symxsize(7) keygap(1.5) bmargin(medsmall)) ///
	plotregion(lcolor(black) lwidth(thin) margin(zero)) ///
	graphregion(color(white))
graph save Graph "$datapath/graphs comparison/`label'_percapita_GG.gph", replace
graph export "$datapath/graphs comparison/`label'_percapita_GG.png", replace
}

**********************************************************************************************************
*Argentina

* Education *
line edu_budgetaryCG year if id==8, lpattern(dot) lcolor(black) || ///
line edu_extrabudgetaryCG year if id==8, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==8, lpattern(longdash) lcolor(green) || ///
line edu_CGinlSocSec year if id==8, lpattern(dash_dot) lcolor(red) || ///
line edu_SG year if id==8, lpattern(shortdash) lcolor(black) || ///
line edu_SocSec year if id==8, lpattern(longdash_3dot ) lcolor(blue) || ///
line percent_education_CG year if id==8, lpattern(longdash_shortdash) lcolor(green) || ///
line percent_education_NFPS year if id==8, lpattern(solid) lcolor(red) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF Extrabudgetary CG") label(3 "IMF CG excl social security funds") label(4 "IMF CG incl social security funds") label(5 "IMF SG") label(6 "IMF Social security funds") ///
label(7 "ECLAC CG") label(8 "ECLAC NFPS")  size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Argentina_education.gph", replace
graph export "$datapath/graphs comparison/Argentina_education.png", replace

* Health *
line health_budgetaryCG year if id==8, lpattern(dot) lcolor(black) || ///
line health_extrabudgetaryCG year if id==8, lpattern(tight_dot) lcolor(black) || ///
line health_CGexlSocSec year if id==8, lpattern(longdash) lcolor(black) || ///
line health_CGinlSocSec year if id==8, lpattern(dash_dot) lcolor(black) || ///
line health_SG year if id==8, lpattern(shortdash) lcolor(black) || ///
line health_SocSec year if id==8, lpattern(longdash_3dot ) lcolor(black) || ///
line percent_health_CG year if id==8, lpattern(longdash_shortdash) lcolor(black) || ///
line percent_health_NFPS year if id==8, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF Extrabudgetary CG") label(3 "IMF CG excl social security funds") label(4 "IMF CG incl social security funds") label(5 "IMF SG") label(6 "IMF Social security funds") ///
label(7 "ECLAC CG") label(8 "ECLAC NFPS")  size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Argentina_health.gph", replace
graph export "$datapath/graphs comparison/Argentina_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==8, lpattern(dot) lcolor(black) || ///
line socialprot_extrabudgetaryCG year if id==8, lpattern(tight_dot) lcolor(black) || ///
line socialprot_CGexlSocSec year if id==8, lpattern(longdash) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==8, lpattern(dash_dot) lcolor(black) || ///
line socialprot_SG year if id==8, lpattern(shortdash) lcolor(black) || ///
line socialprot_SocSec year if id==8, lpattern(longdash_3dot ) lcolor(black) || ///
line percent_socialprot_CG year if id==8, lpattern(longdash_shortdash) lcolor(black) || ///
line percent_socialprot_NFPS year if id==8, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF Extrabudgetary CG") label(3 "IMF CG excl social security funds") label(4 "IMF CG incl social security funds") label(5 "IMF SG") label(6 "IMF Social security funds") ///
label(7 "ECLAC CG") label(8 "ECLAC NFPS")  size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Argentina_socialprot.gph", replace
graph export "$datapath/graphs comparison/Argentina_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==8, lpattern(dot) lcolor(black) || ///
line expenditure_extrabudgetaryCG year if id==8, lpattern(tight_dot) lcolor(black) || ///
line expenditure_CGexlSocSec year if id==8, lpattern(longdash) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==8, lpattern(dash_dot) lcolor(black) || ///
line expenditure_SG year if id==8, lpattern(shortdash) lcolor(black) || ///
line expenditure_SocSec year if id==8, lpattern(longdash_3dot ) lcolor(black) || ///
line percent_total_CG year if id==8, lpattern(longdash_shortdash) lcolor(black) || ///
line percent_total_NFPS year if id==8, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF Extrabudgetary CG") label(3 "IMF CG excl social security funds") label(4 "IMF CG incl social security funds") label(5 "IMF SG") label(6 "IMF Social security funds") ///
label(7 "ECLAC CG") label(8 "ECLAC NFPS")  size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Argentina_total.gph", replace
graph export "$datapath/graphs comparison/Argentina_total.png", replace

grc1leg "$datapath/graphs comparison/Argentina_total.gph" "$datapath/graphs comparison/Argentina_education.gph" ///
"$datapath/graphs comparison/Argentina_health.gph" "$datapath/graphs comparison/Argentina_socialprot.gph", legendfrom("$datapath/graphs comparison/Argentina_total.gph") ///
graphregion(color(white)) title("Argentina", color(black))
graph save Graph "$datapath/graphs comparison/Argentina.gph", replace
graph export "$datapath/graphs comparison/Argentina.png", replace

********************************************************************************************
*** Bolivia ***

* Education *
line edu_LG edu_SG edu_budgetaryCG edu_CGinlSocSec edu_CGexlSocSec percent_education_CG percent_education_GG  year if id==24,  /// 
legend(label(1 "IMF Local Gov") label(2 "IMF State Gov") label(3 "IMF Budgetary CG") label(4 "IMF CG incl social security funds") label(5 "IMF CG excl social security funds") label (6 "ECLAC CG") label(7 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Bolivia_education.gph", replace
graph export "$datapath/graphs comparison/Bolivia_education.png", replace

* Health
line health_LG health_SG health_budgetaryCG health_CGinlSocSec health_CGexlSocSec percent_health_CG percent_health_GG  year if id==24,  /// 
legend(label(1 "IMF Local Gov") label(2 "IMF State Gov") label(3 "IMF Budgetary CG") label(4 "IMF CG incl social security funds") label(5 "IMF CG excl social security funds") label (6 "ECLAC CG") label(7 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Bolivia_health.gph", replace
graph export "$datapath/graphs comparison/Bolivia_health.png", replace

* Social protection *
line socialprot_LG socialprot_SG socialprot_budgetaryCG expenditure_CGinlSocSec expenditure_CGexlSocSec percent_socialprot_CG percent_socialprot_GG  year if id==24,  /// 
legend(label(1 "IMF Local Gov") label(2 "IMF State Gov") label(3 "IMF Budgetary CG") label(4 "IMF CG incl social security funds") label(5 "IMF CG excl social security funds") label (6 "ECLAC CG") label(7 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Bolivia_socialprot.gph", replace
graph export "$datapath/graphs comparison/Bolivia_socialprot.png", replace

* Total *
line expenditure_LG expenditure_SG expenditure_budgetaryCG expenditure_CGinlSocSec expenditure_CGexlSocSec percent_total_CG percent_total_GG  year if id==24,  /// 
legend(label(1 "IMF Local Gov") label(2 "IMF State Gov") label(3 "IMF Budgetary CG") label(4 "IMF CG incl social security funds") label(5 "IMF CG excl social security funds") label (6 "ECLAC CG") label(7 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Bolivia_total.gph", replace
graph export "$datapath/graphs comparison/Bolivia_total.png", replace

grc1leg "$datapath/graphs comparison/Bolivia_total.gph" "$datapath/graphs comparison/Bolivia_education.gph" ///
"$datapath/graphs comparison/Bolivia_health.gph" "$datapath/graphs comparison/Bolivia_socialprot.gph", legendfrom("$datapath/graphs comparison/Bolivia_total.gph") ///
graphregion(color(white)) title("Bolivia", color(black))
graph save Graph "$datapath/graphs comparison/Bolivia.gph", replace
graph export "$datapath/graphs comparison/Bolivia.png", replace

********************************************************************************************
*** Brazil ***

* Education *
line edu_LG edu_SG edu_budgetaryCG edu_CGinlSocSec edu_CGexlSocSec edu_GG percent_education_CG percent_education_GG  year if id==27,  /// 
legend(label(1 "IMF Local Gov") label(2 "IMF State Gov") label(3 "IMF Budgetary CG") label(4 "IMF CG incl social security funds") label(5 "IMF CG excl social security funds") label(6 "IMF GG") label(7 "ECLAC CG") label(8 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Brazil_education.gph", replace
graph export "$datapath/graphs comparison/Brazil_education.png", replace

* Health
line health_LG health_SG health_budgetaryCG health_CGinlSocSec health_CGexlSocSec health_GG percent_health_CG percent_health_GG  year if id==27,  /// 
legend(label(1 "IMF Local Gov") label(2 "IMF State Gov") label(3 "IMF Budgetary CG") label(4 "IMF CG incl social security funds")label(5 "IMF CG excl social security funds") label(6 "IMF GG") label(7 "ECLAC CG") label(8 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Brazil_health.gph", replace
graph export "$datapath/graphs comparison/Brazil_health.png", replace

* Social protection *
line socialprot_LG socialprot_SG socialprot_budgetaryCG socialprot_CGinlSocSec socialprot_CGexlSocSec socialprot_GG percent_socialprot_CG percent_socialprot_GG  year if id==27,  /// 
legend(label(1 "IMF Local Gov") label(2 "IMF State Gov") label(3 "IMF Budgetary CG") label(4 "IMF CG incl social security funds") label(5 "IMF CG excl social security funds") label(6 "IMF GG") label(7 "ECLAC CG") label(8 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Brazil_socialprot.gph", replace
graph export "$datapath/graphs comparison/Brazil_socialprot.png", replace

* Total *
line expenditure_LG expenditure_SG expenditure_budgetaryCG expenditure_CGinlSocSec expenditure_CGexlSocSec expenditure_GG percent_total_CG percent_total_GG  year if id==27,  /// 
legend(label(1 "IMF Local Gov") label(2 "IMF State Gov") label(3 "IMF Budgetary CG") label(4 "IMF CG incl social security funds") label(5 "IMF CG excl social security funds") label(6 "IMF GG") label(7 "ECLAC CG") label(8 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Brazil_total.gph", replace
graph export "$datapath/graphs comparison/Brazil_total.png", replace

grc1leg "$datapath/graphs comparison/Brazil_total.gph" "$datapath/graphs comparison/Brazil_education.gph" ///
"$datapath/graphs comparison/Brazil_health.gph" "$datapath/graphs comparison/Brazil_socialprot.gph", legendfrom("$datapath/graphs comparison/Brazil_total.gph") ///
graphregion(color(white)) title("Brazil", color(black))
graph save Graph "$datapath/graphs comparison/Brazil.gph", replace
graph export "$datapath/graphs comparison/Brazil.png", replace

********************************************************************************************
*** Colombia ***

* Education *
line edu_budgetaryCG year if id==24, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==24, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==24, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==24, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==24, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==24, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==24, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==24, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==24, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==24, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Colombia_education.gph", replace
graph export "$datapath/graphs comparison/Colombia_education.png", replace

* Health *
line health_budgetaryCG year if id==24, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==24, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==24, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==24, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==24, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==24, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==24, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==24, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==24, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==24, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Colombia_health.gph", replace
graph export "$datapath/graphs comparison/Colombia_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==24, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==24, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==24, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==24, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==24, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==24, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==24, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==24, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==24, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==24, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Colombia_socialprot.gph", replace
graph export "$datapath/graphs comparison/Colombia_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==24, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==24, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==24, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==24, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==24, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==24, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==24, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==24, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==24, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==24, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Colombia_total.gph", replace
graph export "$datapath/graphs comparison/Colombia_total.png", replace

grc1leg "$datapath/graphs comparison/Colombia_total.gph" "$datapath/graphs comparison/Colombia_education.gph" ///
"$datapath/graphs comparison/Colombia_health.gph" "$datapath/graphs comparison/Colombia_socialprot.gph", legendfrom("$datapath/graphs comparison/Colombia_total.gph") ///
graphregion(color(white)) title("Colombia", color(black))
graph save Graph "$datapath/graphs comparison/Colombia.gph", replace
graph export "$datapath/graphs comparison/Colombia.png", replace

********************************************************************************************
*** Costa Rica ***

* Education *
line edu_budgetaryCG year if id==46, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==46, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==46, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==46, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==46, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==46, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==46, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==46, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==46, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==46, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Costa Rica_education.gph", replace
graph export "$datapath/graphs comparison/Costa Rica_education.png", replace

* Health *
line health_budgetaryCG year if id==46, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==46, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==46, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==46, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==46, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==46, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==46, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==46, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==46, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==46, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Costa Rica_health.gph", replace
graph export "$datapath/graphs comparison/Costa Rica_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==46, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==46, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==46, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==46, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==46, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==46, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==46, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==46, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==46, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==46, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Costa Rica_socialprot.gph", replace
graph export "$datapath/graphs comparison/Costa Rica_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==46, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==46, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==46, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==46, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==46, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==46, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==46, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==46, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==46, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==46, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Costa Rica_total.gph", replace
graph export "$datapath/graphs comparison/Costa Rica_total.png", replace

grc1leg "$datapath/graphs comparison/Costa Rica_total.gph" "$datapath/graphs comparison/Costa Rica_education.gph" ///
"$datapath/graphs comparison/Costa Rica_health.gph" "$datapath/graphs comparison/Costa Rica_socialprot.gph", legendfrom("$datapath/graphs comparison/Costa Rica_total.gph") ///
graphregion(color(white)) title("Costa Rica", color(black))
graph save Graph "$datapath/graphs comparison/Costa Rica.gph", replace
graph export "$datapath/graphs comparison/Costa Rica.png", replace

********************************************************************************************
*** Dominican Republic ***

* Education *
line edu_budgetaryCG year if id==56, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==56, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==56, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==56, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==56, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==56, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==56, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==56, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==56, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==56, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Dominican Republic_education.gph", replace
graph export "$datapath/graphs comparison/Dominican Republic_education.png", replace

* Health *
line health_budgetaryCG year if id==56, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==56, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==56, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==56, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==56, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==56, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==56, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==56, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==56, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==56, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Dominican Republic_health.gph", replace
graph export "$datapath/graphs comparison/Dominican Republic_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==56, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==56, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==56, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==56, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==56, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==56, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==56, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==56, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==56, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==56, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Dominican Republic_socialprot.gph", replace
graph export "$datapath/graphs comparison/Dominican Republic_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==56, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==56, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==56, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==56, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==56, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==56, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==56, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==56, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==56, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==56, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Dominican Republic_total.gph", replace
graph export "$datapath/graphs comparison/Dominican Republic_total.png", replace

grc1leg "$datapath/graphs comparison/Dominican Republic_total.gph" "$datapath/graphs comparison/Dominican Republic_education.gph" ///
"$datapath/graphs comparison/Dominican Republic_health.gph" "$datapath/graphs comparison/Dominican Republic_socialprot.gph", legendfrom("$datapath/graphs comparison/Dominican Republic_total.gph") ///
graphregion(color(white)) title("Dominican Republic", color(black))
graph save Graph "$datapath/graphs comparison/Dominican Republic.gph", replace
graph export "$datapath/graphs comparison/Dominican Republic.png", replace

********************************************************************************************
*** Ecuador ***

* Education *
line edu_budgetaryCG year if id==57, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==57, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==57, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==57, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==57, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==57, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==57, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==57, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==57, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==57, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Ecuador_education.gph", replace
graph export "$datapath/graphs comparison/Ecuador_education.png", replace

* Health *
line health_budgetaryCG year if id==57, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==57, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==57, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==57, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==57, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==57, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==57, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==57, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==57, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==57, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Ecuador_health.gph", replace
graph export "$datapath/graphs comparison/Ecuador_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==57, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==57, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==57, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==57, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==57, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==57, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==57, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==57, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==57, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==57, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Ecuador_socialprot.gph", replace
graph export "$datapath/graphs comparison/Ecuador_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==57, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==57, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==57, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==57, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==57, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==57, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==57, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==57, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==57, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==57, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Ecuador_total.gph", replace
graph export "$datapath/graphs comparison/Ecuador_total.png", replace

grc1leg "$datapath/graphs comparison/Ecuador_total.gph" "$datapath/graphs comparison/Ecuador_education.gph" ///
"$datapath/graphs comparison/Ecuador_health.gph" "$datapath/graphs comparison/Ecuador_socialprot.gph", legendfrom("$datapath/graphs comparison/Ecuador_total.gph") ///
graphregion(color(white)) title("Ecuador", color(black))
graph save Graph "$datapath/graphs comparison/Ecuador.gph", replace
graph export "$datapath/graphs comparison/Ecuador.png", replace

********************************************************************************************
*** El Salvador ***

* Education *
line edu_budgetaryCG year if id==59, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==59, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==59, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==59, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==59, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==59, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==59, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==59, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==59, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==59, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/El Salvador_education.gph", replace
graph export "$datapath/graphs comparison/El Salvador_education.png", replace

* Health *
line health_budgetaryCG year if id==59, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==59, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==59, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==59, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==59, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==59, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==59, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==59, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==59, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==59, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/El Salvador_health.gph", replace
graph export "$datapath/graphs comparison/El Salvador_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==59, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==59, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==59, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==59, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==59, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==59, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==59, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==59, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==59, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==59, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/El Salvador_socialprot.gph", replace
graph export "$datapath/graphs comparison/El Salvador_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==59, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==59, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==59, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==59, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==59, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==59, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==59, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==59, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==59, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==59, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/El Salvador_total.gph", replace
graph export "$datapath/graphs comparison/El Salvador_total.png", replace

grc1leg "$datapath/graphs comparison/El Salvador_total.gph" "$datapath/graphs comparison/El Salvador_education.gph" ///
"$datapath/graphs comparison/El Salvador_health.gph" "$datapath/graphs comparison/El Salvador_socialprot.gph", legendfrom("$datapath/graphs comparison/El Salvador_total.gph") ///
graphregion(color(white)) title("El Salvador", color(black))
graph save Graph "$datapath/graphs comparison/El Salvador.gph", replace
graph export "$datapath/graphs comparison/El Salvador.png", replace

********************************************************************************************
*** Guatemala ***

* Education *
line edu_budgetaryCG year if id==78, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==78, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==78, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==78, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==78, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==78, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==78, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==78, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==78, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==78, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Guatemala_education.gph", replace
graph export "$datapath/graphs comparison/Guatemala_education.png", replace

* Health *
line health_budgetaryCG year if id==78, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==78, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==78, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==78, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==78, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==78, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==78, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==78, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==78, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==78, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Guatemala_health.gph", replace
graph export "$datapath/graphs comparison/Guatemala_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==78, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==78, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==78, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==78, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==78, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==78, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==78, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==78, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==78, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==78, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Guatemala_socialprot.gph", replace
graph export "$datapath/graphs comparison/Guatemala_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==78, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==78, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==78, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==78, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==78, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==78, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==78, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==78, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==78, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==78, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Guatemala_total.gph", replace
graph export "$datapath/graphs comparison/Guatemala_total.png", replace

grc1leg "$datapath/graphs comparison/Guatemala_total.gph" "$datapath/graphs comparison/Guatemala_education.gph" ///
"$datapath/graphs comparison/Guatemala_health.gph" "$datapath/graphs comparison/Guatemala_socialprot.gph", legendfrom("$datapath/graphs comparison/Guatemala_total.gph") ///
graphregion(color(white)) title("Guatemala", color(black))
graph save Graph "$datapath/graphs comparison/Guatemala.gph", replace
graph export "$datapath/graphs comparison/Guatemala.png", replace

********************************************************************************************
*** Honduras ***

* Education *
line edu_budgetaryCG year if id==83, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==83, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==83, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==83, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==83, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==83, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==83, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==83, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==83, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==83, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Honduras_education.gph", replace
graph export "$datapath/graphs comparison/Honduras_education.png", replace

* Health *
line health_budgetaryCG year if id==83, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==83, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==83, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==83, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==83, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==83, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==83, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==83, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==83, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==83, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Honduras_health.gph", replace
graph export "$datapath/graphs comparison/Honduras_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==83, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==83, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==83, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==83, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==83, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==83, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==83, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==83, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==83, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==83, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Honduras_socialprot.gph", replace
graph export "$datapath/graphs comparison/Honduras_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==83, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==83, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==83, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==83, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==83, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==83, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==83, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==83, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==83, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==83, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Honduras_total.gph", replace
graph export "$datapath/graphs comparison/Honduras_total.png", replace

grc1leg "$datapath/graphs comparison/Honduras_total.gph" "$datapath/graphs comparison/Honduras_education.gph" ///
"$datapath/graphs comparison/Honduras_health.gph" "$datapath/graphs comparison/Honduras_socialprot.gph", legendfrom("$datapath/graphs comparison/Honduras_total.gph") ///
graphregion(color(white)) title("Honduras", color(black))
graph save Graph "$datapath/graphs comparison/Honduras.gph", replace
graph export "$datapath/graphs comparison/Honduras.png", replace

********************************************************************************************
*** Mexico ***

* Education *
line edu_budgetaryCG year if id==126, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==126, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==126, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==126, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==126, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==126, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==126, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==126, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==126, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==126, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Mexico_education.gph", replace
graph export "$datapath/graphs comparison/Mexico_education.png", replace

* Health *
line health_budgetaryCG year if id==126, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==126, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==126, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==126, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==126, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==126, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==126, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==126, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==126, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==126, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Mexico_health.gph", replace
graph export "$datapath/graphs comparison/Mexico_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==126, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==126, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==126, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==126, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==126, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==126, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==126, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==126, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==126, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==126, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Mexico_socialprot.gph", replace
graph export "$datapath/graphs comparison/Mexico_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==126, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==126, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==126, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==126, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==126, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==126, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==126, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==126, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==126, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==126, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Mexico_total.gph", replace
graph export "$datapath/graphs comparison/Mexico_total.png", replace

grc1leg "$datapath/graphs comparison/Mexico_total.gph" "$datapath/graphs comparison/Mexico_education.gph" ///
"$datapath/graphs comparison/Mexico_health.gph" "$datapath/graphs comparison/Mexico_socialprot.gph", legendfrom("$datapath/graphs comparison/Mexico_total.gph") ///
graphregion(color(white)) title("Mexico", color(black))
graph save Graph "$datapath/graphs comparison/Mexico.gph", replace
graph export "$datapath/graphs comparison/Mexico.png", replace

********************************************************************************************
*** Nicaragua ***

* Education *
line edu_budgetaryCG year if id==140, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==140, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==140, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==140, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==140, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==140, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==140, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==140, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==140, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==140, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Nicaragua_education.gph", replace
graph export "$datapath/graphs comparison/Nicaragua_education.png", replace

* Health *
line health_budgetaryCG year if id==140, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==140, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==140, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==140, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==140, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==140, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==140, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==140, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==140, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==140, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Nicaragua_health.gph", replace
graph export "$datapath/graphs comparison/Nicaragua_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==140, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==140, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==140, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==140, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==140, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==140, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==140, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==140, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==140, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==140, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Nicaragua_socialprot.gph", replace
graph export "$datapath/graphs comparison/Nicaragua_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==140, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==140, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==140, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==140, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==140, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==140, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==140, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==140, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==140, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==140, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Nicaragua_total.gph", replace
graph export "$datapath/graphs comparison/Nicaragua_total.png", replace

grc1leg "$datapath/graphs comparison/Nicaragua_total.gph" "$datapath/graphs comparison/Nicaragua_education.gph" ///
"$datapath/graphs comparison/Nicaragua_health.gph" "$datapath/graphs comparison/Nicaragua_socialprot.gph", legendfrom("$datapath/graphs comparison/Nicaragua_total.gph") ///
graphregion(color(white)) title("Nicaragua", color(black))
graph save Graph "$datapath/graphs comparison/Nicaragua.gph", replace
graph export "$datapath/graphs comparison/Nicaragua.png", replace

********************************************************************************************
*** Panama ***

* Education *
line edu_budgetaryCG year if id==148, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==148, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==148, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==148, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==148, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==148, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==148, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==148, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==148, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==148, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Panama_education.gph", replace
graph export "$datapath/graphs comparison/Panama_education.png", replace

* Health *
line health_budgetaryCG year if id==148, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==148, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==148, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==148, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==148, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==148, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==148, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==148, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==148, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==148, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Panama_health.gph", replace
graph export "$datapath/graphs comparison/Panama_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==148, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==148, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==148, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==148, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==148, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==148, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==148, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==148, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==148, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==148, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Panama_socialprot.gph", replace
graph export "$datapath/graphs comparison/Panama_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==148, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==148, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==148, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==148, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==148, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==148, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==148, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==148, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==148, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==148, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Panama_total.gph", replace
graph export "$datapath/graphs comparison/Panama_total.png", replace

grc1leg "$datapath/graphs comparison/Panama_total.gph" "$datapath/graphs comparison/Panama_education.gph" ///
"$datapath/graphs comparison/Panama_health.gph" "$datapath/graphs comparison/Panama_socialprot.gph", legendfrom("$datapath/graphs comparison/Panama_total.gph") ///
graphregion(color(white)) title("Panama", color(black))
graph save Graph "$datapath/graphs comparison/Panama.gph", replace
graph export "$datapath/graphs comparison/Panama.png", replace

********************************************************************************************
*** Paraguay ***

* Education *
line edu_budgetaryCG year if id==150, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==150, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==150, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==150, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==150, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==150, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==150, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==150, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==150, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==150, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Paraguay_education.gph", replace
graph export "$datapath/graphs comparison/Paraguay_education.png", replace

* Health *
line health_budgetaryCG year if id==150, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==150, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==150, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==150, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==150, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==150, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==150, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==150, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==150, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==150, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Paraguay_health.gph", replace
graph export "$datapath/graphs comparison/Paraguay_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==150, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==150, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==150, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==150, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==150, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==150, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==150, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==150, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==150, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==150, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Paraguay_socialprot.gph", replace
graph export "$datapath/graphs comparison/Paraguay_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==150, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==150, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==150, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==150, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==150, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==150, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==150, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==150, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==150, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==150, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Paraguay_total.gph", replace
graph export "$datapath/graphs comparison/Paraguay_total.png", replace

grc1leg "$datapath/graphs comparison/Paraguay_total.gph" "$datapath/graphs comparison/Paraguay_education.gph" ///
"$datapath/graphs comparison/Paraguay_health.gph" "$datapath/graphs comparison/Paraguay_socialprot.gph", legendfrom("$datapath/graphs comparison/Paraguay_total.gph") ///
graphregion(color(white)) title("Paraguay", color(black))
graph save Graph "$datapath/graphs comparison/Paraguay.gph", replace
graph export "$datapath/graphs comparison/Paraguay.png", replace

********************************************************************************************
*** Peru ***

* Education *
line edu_budgetaryCG year if id==151, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==151, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==151, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==151, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==151, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==151, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==151, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==151, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==151, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==151, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Peru_education.gph", replace
graph export "$datapath/graphs comparison/Peru_education.png", replace

* Health *
line health_budgetaryCG year if id==151, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==151, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==151, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==151, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==151, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==151, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==151, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==151, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==151, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==151, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Peru_health.gph", replace
graph export "$datapath/graphs comparison/Peru_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==151, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==151, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==151, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==151, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==151, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==151, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==151, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==151, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==151, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==151, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Peru_socialprot.gph", replace
graph export "$datapath/graphs comparison/Peru_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==151, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==151, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==151, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==151, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==151, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==151, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==151, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==151, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==151, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==151, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Peru_total.gph", replace
graph export "$datapath/graphs comparison/Peru_total.png", replace

grc1leg "$datapath/graphs comparison/Peru_total.gph" "$datapath/graphs comparison/Peru_education.gph" ///
"$datapath/graphs comparison/Peru_health.gph" "$datapath/graphs comparison/Peru_socialprot.gph", legendfrom("$datapath/graphs comparison/Peru_total.gph") ///
graphregion(color(white)) title("Peru", color(black))
graph save Graph "$datapath/graphs comparison/Peru.gph", replace
graph export "$datapath/graphs comparison/Peru.png", replace

********************************************************************************************
*** Uruguay ***

* Education *
line edu_budgetaryCG year if id==206, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==206, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==206, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==206, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==206, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==206, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==206, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==206, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==206, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==206, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Uruguay_education.gph", replace
graph export "$datapath/graphs comparison/Uruguay_education.png", replace

* Health *
line health_budgetaryCG year if id==206, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==206, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==206, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==206, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==206, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==206, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==206, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==206, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==206, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==206, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Uruguay_health.gph", replace
graph export "$datapath/graphs comparison/Uruguay_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==206, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==206, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==206, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==206, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==206, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==206, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==206, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==206, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==206, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==206, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Uruguay_socialprot.gph", replace
graph export "$datapath/graphs comparison/Uruguay_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==206, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==206, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==206, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==206, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==206, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==206, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==206, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==206, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==206, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==206, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Uruguay_total.gph", replace
graph export "$datapath/graphs comparison/Uruguay_total.png", replace

grc1leg "$datapath/graphs comparison/Uruguay_total.gph" "$datapath/graphs comparison/Uruguay_education.gph" ///
"$datapath/graphs comparison/Uruguay_health.gph" "$datapath/graphs comparison/Uruguay_socialprot.gph", legendfrom("$datapath/graphs comparison/Uruguay_total.gph") ///
graphregion(color(white)) title("Uruguay", color(black))
graph save Graph "$datapath/graphs comparison/Uruguay.gph", replace
graph export "$datapath/graphs comparison/Uruguay.png", replace

********************************************************************************************
*** Venezuela ***

* Education *
line edu_budgetaryCG year if id==209, lpattern(dot) lcolor(black) || ///
line edu_CGinlSocSec year if id==209, lpattern(tight_dot) lcolor(blue) || ///
line edu_CGexlSocSec year if id==209, lpattern(longdash) lcolor(green) || ///
line edu_extrabudgetaryCG year if id==209, lpattern(dash_dot) lcolor(red) || ///
line edu_GG year if id==209, lpattern(shortdash) lcolor(black) || ///
line edu_LG year if id==209, lpattern(longdash_3dot ) lcolor(blue) || ///
line edu_SocSec year if id==209, lpattern(longdash_shortdash) lcolor(green) || ///
line edu_SG year if id==209, lpattern(solid) lcolor(red) ||  /// 
line percent_education_CG year if id==209, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_education_GG year if id==209, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Education", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Venezuela_education.gph", replace
graph export "$datapath/graphs comparison/Venezuela_education.png", replace

* Health *
line health_budgetaryCG year if id==209, lpattern(dot) lcolor(black) || ///
line health_CGinlSocSec year if id==209, lpattern(tight_dot) lcolor(blue) || ///
line health_CGexlSocSec year if id==209, lpattern(longdash) lcolor(green) || ///
line health_extrabudgetaryCG year if id==209, lpattern(dash_dot) lcolor(red) || ///
line health_GG year if id==209, lpattern(shortdash) lcolor(black) || ///
line health_LG year if id==209, lpattern(longdash_3dot ) lcolor(blue) || ///
line health_SocSec year if id==209, lpattern(longdash_shortdash) lcolor(green) || ///
line health_SG year if id==209, lpattern(solid) lcolor(red) ||  /// 
line percent_health_CG year if id==209, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_health_GG year if id==209, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Health", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Venezuela_health.gph", replace
graph export "$datapath/graphs comparison/Venezuela_health.png", replace

* Social protection *
line socialprot_budgetaryCG year if id==209, lpattern(dot) lcolor(black) || ///
line socialprot_CGinlSocSec year if id==209, lpattern(tight_dot) lcolor(blue) || ///
line socialprot_CGexlSocSec year if id==209, lpattern(longdash) lcolor(green) || ///
line socialprot_extrabudgetaryCG year if id==209, lpattern(dash_dot) lcolor(red) || ///
line socialprot_GG year if id==209, lpattern(shortdash) lcolor(black) || ///
line socialprot_LG year if id==209, lpattern(longdash_3dot ) lcolor(blue) || ///
line socialprot_SocSec year if id==209, lpattern(longdash_shortdash) lcolor(green) || ///
line socialprot_SG year if id==209, lpattern(solid) lcolor(red) ||  /// 
line percent_socialprot_CG year if id==209, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_socialprot_GG year if id==209, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Social Protection", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Venezuela_socialprot.gph", replace
graph export "$datapath/graphs comparison/Venezuela_socialprot.png", replace

* Total *
line expenditure_budgetaryCG year if id==209, lpattern(dot) lcolor(black) || ///
line expenditure_CGinlSocSec year if id==209, lpattern(tight_dot) lcolor(blue) || ///
line expenditure_CGexlSocSec year if id==209, lpattern(longdash) lcolor(green) || ///
line expenditure_extrabudgetaryCG year if id==209, lpattern(dash_dot) lcolor(red) || ///
line expenditure_GG year if id==209, lpattern(shortdash) lcolor(black) || ///
line expenditure_LG year if id==209, lpattern(longdash_3dot ) lcolor(blue) || ///
line expenditure_SocSec year if id==209, lpattern(longdash_shortdash) lcolor(green) || ///
line expenditure_SG year if id==209, lpattern(solid) lcolor(red) ||  /// 
line percent_total_CG year if id==209, lpattern(longdash_3dot) lcolor(black) ||  /// 
line percent_total_GG year if id==209, lpattern(solid) lcolor(black) || , /// 
legend(label(1 "IMF Budgetary CG") label(2 "IMF CG incl social security funds") label(3 "IMF CG excl social security funds") label(4 "IMF Extrabudgetary CG") label(5 "IMF GG") label(6 "IMF LG") label(7 "IMF Social security funds")  ///
label(8 "IMF SG")  label(9 "ECLAC CG") label(10 "ECLAC GG") size(small)) ///
graphregion(color(white)) title("Total public spending", color(black) size(medlarge)) xtitle("") ytitle("% of GDP", size(small))
graph save Graph "$datapath/graphs comparison/Venezuela_total.gph", replace
graph export "$datapath/graphs comparison/Venezuela_total.png", replace

grc1leg "$datapath/graphs comparison/Venezuela_total.gph" "$datapath/graphs comparison/Venezuela_education.gph" ///
"$datapath/graphs comparison/Venezuela_health.gph" "$datapath/graphs comparison/Venezuela_socialprot.gph", legendfrom("$datapath/graphs comparison/Venezuela_total.gph") ///
graphregion(color(white)) title("Venezuela", color(black))
graph save Graph "$datapath/graphs comparison/Venezuela.gph", replace
graph export "$datapath/graphs comparison/Venezuela.png", replace


