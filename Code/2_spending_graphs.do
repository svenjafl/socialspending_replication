
use "$datapath/dataset_for_analysis.dta", clear

drop if year>2019

sort country year

*** Spending percent, boom countries ***
graph tw line percent_total_NFPS year if cid==1, lcolor(black) lpattern(solid) text(27.5 2023 "Argentina", color(black) size(small)) || ///
line percent_total_CG year if cid==2, lcolor(black) lpattern(dash) text(13 2021.5 "Bolivia", color(black) size(small)) || ///
line percent_total_CG year if cid==3, lcolor(black) lpattern(tight_dot) text(18 2021 "Brazil", color(black) size(small))  || ///
line percent_total_CG year if cid==4, lcolor(black) lpattern(dash_dot) text(17 2021 "Chile", color(black) size(small))  || ///
line percent_total_CG year if cid==5, lcolor(black) lpattern(shortdash) text(12 2022 "Colombia", color(black) size(small))  || ///
line percent_CGold_TOTAL year if cid==8, lcolor(black) lpattern(shortdash_dot_dot) text(8 2015 "Ecuador", color(black) size(small)) || ///
line percent_total_CG year if cid==13, lcolor(black) lpattern(longdash) text(9 2021.5 "Mexico", color(black) size(small))  || ///
line percent_total_GG year if cid==17, lcolor(black) lpattern(longdash_dot) text(11 2021 "Peru", color(black) size(small))  || ///
line percent_total_CG year if cid==19, lcolor(black) lpattern(dash3dot) text(19 2017 "Venezuela", color(black) size(small))  ||, ///
graphregion(color(white)) legend(off)  ytitle("Public social spending as % of GDP", color(black)) xtitle("") ///
title("Countries with commodity price boom", color(black) size(medlarge)) xsc(r(1990 2025)) 
graph save Graph "$outputpath/graphs comparison/percent_boomcountries.gph", replace
graph export "$outputpath/graphs comparison/percent_boomcountries.eps", replace

*** Spending percent, non-boom countries ***
graph tw line percent_total_CG year if cid==6, lcolor(black) lpattern(solid) text(11.9 2023 "Costa Rica", color(black) size(small)) || ///
line percent_total_CG year if cid==7, lcolor(black) lpattern(dash) text(7 2021.5 "Dominican Republic", color(black) size(small)) || ///
line percent_total_CG year if cid==9, lcolor(black) lpattern(tight_dot) text(8.4 2022 "El Salvador", color(black) size(small))  || ///
line percent_total_CG year if cid==10, lcolor(black) lpattern(dash_dot) text(7.8 2022 "Guatemala", color(black) size(small))  || ///
line percent_CGold_TOTAL year if cid==11, lcolor(black) lpattern(shortdash_dot_dot) text(8 2015 "Honduras", color(black) size(small)) || ///
line percent_total_CG year if cid==14, lcolor(black) lpattern(shortdash) text(10.7 2022 "Nicaragua", color(black) size(small))  || ///
line percent_total_CG year if cid==15, lcolor(black) lpattern(longdash) text(8.9 2021.5 "Panama", color(black) size(small))  || ///
line percent_total_CG year if cid==16, lcolor(black) lpattern(longdash_dot) lcolor(black) text(9.6 2022 "Paraguay", color(black) size(small))  || ///
line percent_total_CG year if cid==18, lcolor(black) lpattern(dash3dot) text(16.1 2022 "Uruguay", color(black) size(small))  ||, ///
graphregion(color(white)) legend(off) ytitle(" ")  xtitle("")  ///
title("Countries without commodity price boom", color(black) size(medlarge)) xsc(r(1990 2025)) 
graph save Graph "$outputpath/graphs comparison/percent_nonboomcountries.gph", replace
graph export "$outputpath/graphs comparison/percent_nonboomcountries.eps", replace

*** Spending per-cent (Figure 1) ***
gr combine "$outputpath/graphs comparison/percent_boomcountries.gph" ///
"$outputpath/graphs comparison/percent_nonboomcountries.gph", ///
graphregion(color(white)) row(1) ycommon 
graph save Graph "$outputpath/graphs comparison/Figure1.gph", replace
graph export "$outputpath/graphs comparison/Figure1.eps", replace

*** Spending per capita, boom countries ***
graph tw line percapita_total_NFPS year if cid==1, lcolor(black) lpattern(solid) text(3150 2022 "Argentina", color(black) size(small)) || ///
line percapita_total_CG year if cid==2, lcolor(black) lpattern(dash) text(450 2022 "Bolivia", color(black) size(small)) || ///
line percapita_total_CG year if cid==3, lcolor(black) lpattern(tight_dot) text(1600 2021 "Brazil", color(black) size(small))  || ///
line percapita_total_CG year if cid==4, lcolor(black) lpattern(dash_dot) text(2750 2021 "Chile", color(black) size(small))  || ///
line percapita_total_CG year if cid==5, lcolor(black) lpattern(shortdash) text(890 2023 "Colombia", color(black) size(small))  || ///
line percapita_CGold_TOTAL year if cid==8, lcolor(black) lpattern(shortdash_dot_dot) text(500 2017.5 "Ecuador", color(black) size(small)) || ///
line percapita_total_CG year if cid==13, lcolor(black) lpattern(longdash) text(1000 2022 "Mexico", color(black) size(small))  || ///
line percapita_total_GG year if cid==17, lcolor(black) lpattern(longdash_dot) text(750 2022 "Peru", color(black) size(small))  ||, ///
graphregion(color(white)) legend(off)  ytitle("Public social spending in per-capita US dollar (2010)", color(black)) xtitle("") ///
title("Countries with commodity price boom", color(black) size(medlarge)) xsc(r(1990 2025)) 
graph save Graph "$outputpath/graphs comparison/percapita_boomcountries.gph", replace
graph export "$outputpath/graphs comparison/percapita_boomcountries.eps", replace

*** Spending per capita, non-boom countries ***
graph tw line percapita_total_CG year if cid==6, lcolor(black) lpattern(solid) text(1500 2023 "Costa Rica", color(black) size(small)) || ///
line percapita_total_CG year if cid==7, lcolor(black) lpattern(dash) text(680 2023 "Dominican Republic", color(black) size(small)) || ///
line percapita_total_CG year if cid==9, lcolor(black) lpattern(tight_dot) text(400 2022.25 "El Salvador", color(black) size(small))  || ///
line percapita_total_CG year if cid==10, lcolor(black) lpattern(dash_dot) text(320 2022 "Guatemala", color(black) size(small))  || ///
line percapita_CGold_TOTAL year if cid==11, lcolor(black) lpattern(shortdash_dot_dot) text(125 2015 "Honduras", color(black) size(small)) || ///
line percapita_total_CG year if cid==14, lcolor(black) lpattern(shortdash) text(200 2022 "Nicaragua", color(black) size(small))  || ///
line percapita_total_CG year if cid==15, lcolor(black) lpattern(longdash) text(1400 2022 "Panama", color(black) size(small))  || ///
line percapita_total_CG year if cid==16, lcolor(black) lpattern(longdash_dot) lcolor(black) text(546 2022 "Paraguay", color(black) size(small))  || ///
line percapita_total_CG year if cid==18, lcolor(black) lpattern(dash3dot) text(3000 2022 "Uruguay", color(black) size(small))  ||, ///
graphregion(color(white)) legend(off) xtitle("") ytitle(" ") ///
title("Countries without commodity price boom", color(black) size(medlarge)) xsc(r(1990 2025)) 
graph save Graph "$outputpath/graphs comparison/percapita_nonboomcountries.gph", replace
graph export "$outputpath/graphs comparison/percapita_nonboomcountries.eps", replace

*** Spending per-capita (Figure 2) ***
gr combine "$outputpath/graphs comparison/percapita_boomcountries.gph" ///
"$outputpath/graphs comparison/percapita_nonboomcountries.gph", ///
graphregion(color(white)) row(1) ycommon 
graph save Graph "$outputpath/graphs comparison/Figure2.gph", replace
graph export "$outputpath/graphs comparison/Figure2.eps", replace

********* Figures for Appendix E *********

use "$datapath/dataset_for_analysis.dta", clear

sort country year

*** Percent of GDP ***

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
graph save Graph "$outputpath/graphs comparison/`label'_percent_NFPS.gph", replace
graph export "$outputpath/graphs comparison/`label'_percent_NFPS.eps", replace
}

forval i = 2/13 {
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
graph save Graph "$outputpath/graphs comparison/`label'_percent_CG.gph", replace
graph export "$outputpath/graphs comparison/`label'_percent_CG.eps", replace
}

forval i = 15/15 {
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
graph save Graph "$outputpath/graphs comparison/`label'_percent_CG.gph", replace
graph export "$outputpath/graphs comparison/`label'_percent_CG.eps", replace
}

forval i = 18/18 {
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
graph save Graph "$outputpath/graphs comparison/`label'_percent_CG.gph", replace
graph export "$outputpath/graphs comparison/`label'_percent_CG.eps", replace
}

forval i = 8/8 {
local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
graph bar (sum) percent_CGold_EDUCATION percent_CGold_ENVIRONMENT percent_CGold_HEALTH percent_CGold_HOUSING percent_CGold_RECREATION percent_CGold_SOCIALPROT if cid==`i', ///
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
graph save Graph "$outputpath/graphs comparison/`label'_percent_CG.gph", replace
graph export "$outputpath/graphs comparison/`label'_percent_CG.eps", replace
}


forval i = 11/11 {
local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
graph bar (sum) percent_CGold_EDUCATION percent_CGold_ENVIRONMENT percent_CGold_HEALTH percent_CGold_HOUSING percent_CGold_RECREATION percent_CGold_SOCIALPROT if cid==`i', ///
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
graph save Graph "$outputpath/graphs comparison/`label'_percent_CG.gph", replace
graph export "$outputpath/graphs comparison/`label'_percent_CG.eps", replace
}

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
title("`label' - Public social spending as % of GDP - General Government", margin(small) size(medsmall) color(black)) ///
ytitle("Percent of GDP", size(medsmall) color(black)) ///
legend(label(1 "Education") label(2 "Environment") label(3 "Health") label(4 "Housing") label(5 "Recreation") label(6 "Social Protection") col(3) colgap(3.5) size(small) symxsize(7) keygap(1.5) bmargin(medsmall)) ///
	plotregion(lcolor(black) lwidth(thin) margin(zero)) ///
	graphregion(color(white))
graph save Graph "$outputpath/graphs comparison/`label'_percent_CG.gph", replace
graph export "$outputpath/graphs comparison/`label'_percent_CG.eps", replace
}

*** Percapita ***

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
graph save Graph "$outputpath/graphs comparison/`label'_percapita_NFPS.gph", replace
graph export "$outputpath/graphs comparison/`label'_percapita_NFPS.eps", replace
}

forval i = 2/13 {
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
graph save Graph "$outputpath/graphs comparison/`label'_percapita_CG.gph", replace
graph export "$outputpath/graphs comparison/`label'_percapita_CG.eps", replace
}

forval i = 15/15 {
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
graph save Graph "$outputpath/graphs comparison/`label'_percapita_CG.gph", replace
graph export "$outputpath/graphs comparison/`label'_percapita_CG.eps", replace
}

forval i = 18/18 {
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
graph save Graph "$outputpath/graphs comparison/`label'_percapita_CG.gph", replace
graph export "$outputpath/graphs comparison/`label'_percapita_CG.eps", replace
}

forval i = 8/8 {
local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
graph bar (sum) percapita_CGold_EDUCATION percapita_CGold_ENVIRONMENT percapita_CGold_HEALTH percapita_CGold_HOUSING percapita_CGold_RECREATION percapita_CGold_SOCIALPROT if cid==`i', ///
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
graph save Graph "$outputpath/graphs comparison/`label'_percapita_CG.gph", replace
graph export "$outputpath/graphs comparison/`label'_percapita_CG.eps", replace
}

forval i = 11/11 {
local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
graph bar (sum) percapita_CGold_EDUCATION percapita_CGold_ENVIRONMENT percapita_CGold_HEALTH percapita_CGold_HOUSING percapita_CGold_RECREATION percapita_CGold_SOCIALPROT if cid==`i', ///
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
graph save Graph "$outputpath/graphs comparison/`label'_percapita_CG.gph", replace
graph export "$outputpath/graphs comparison/`label'_percapita_CG.eps", replace
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
title("`label' - Public social spending, per capita in USD  - General Government", margin(small) size(medsmall) color(black)) ///
ytitle("Per capita spending, in USD", size(medsmall) color(black)) ///
legend(label(1 "Education") label(2 "Environment") label(3 "Health") label(4 "Housing") label(5 "Recreation") label(6 "Social Protection") col(3) colgap(3.5) size(small) symxsize(7) keygap(1.5) bmargin(medsmall)) ///
	plotregion(lcolor(black) lwidth(thin) margin(zero)) ///
	graphregion(color(white))
graph save Graph "$outputpath/graphs comparison/`label'_percapita_CG.gph", replace
graph export "$outputpath/graphs comparison/`label'_percapita_CG.eps", replace
}

