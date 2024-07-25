********************************************************************************
*Svars for Bolivia, Brazil, Chile, Colombia, Mexico, Peru with interest rates as control variable
********************************************************************************
********************************************************************************
*per capita
********************************************************************************

foreach i of numlist 2 4 5 13 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_CG_l1_int.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CG)
gen sp2 = log(percapita_health_CG)
gen sp3 = log(percapita_socialprot_CG)
gen intrt = log(interestrate5)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.intrt=0


varsoc cp1 intrt sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 intrt sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar


* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CG_l1_int.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CG_l1_int.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CG_l1_int.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CG_l1_int.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CG_l1_int.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CG_l1_int.png", replace


*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)
log close
}



foreach i of numlist 17 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_GG_l1_int.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_GG)
gen sp2 = log(percapita_health_GG)
gen sp3 = log(percapita_socialprot_GG)
gen intrt = log(interestrate5)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.intrt=0


varsoc cp1 intrt sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 intrt sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar


* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_GG_l1_int.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_GG_l1_int.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_GG_l1_int.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_GG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_GG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_GG_l1_int.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_GG_l1_int.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_GG_l1_int.png", replace


*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)
log close
}

foreach i of numlist 3 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_CG_l1_int.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CG)
gen sp2 = log(percapita_health_CG)
gen sp3 = log(percapita_socialprot_CG)
gen intrt = log(interestrate7)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.intrt=0


varsoc cp1 intrt sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 intrt sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar


* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CG_l1_int.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CG_l1_int.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CG_l1_int.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CG_l1_int.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CG_l1_int.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CG_l1_int.png", replace


*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)
log close
}



********************************************************************************
*percent of GDP
********************************************************************************

foreach i of numlist 2 4 5 13 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_CG_l1_int.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)
gen intrt = log(interestrate5)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.intrt=0


varsoc cp1 intrt sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 intrt sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar


* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CG_l1_int.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CG_l1_int.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CG_l1_int.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CG_l1_int.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CG_l1_int.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CG_l1_int.png", replace


*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)
log close
}



foreach i of numlist 17 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_GG_l1_int.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_GG)
gen sp2 = log(percent_health_GG)
gen sp3 = log(percent_socialprot_GG)
gen intrt = log(interestrate5)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.intrt=0


varsoc cp1 intrt sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 intrt sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar


* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_GG_l1_int.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_GG_l1_int.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_GG_l1_int.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_GG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_GG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_GG_l1_int.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_GG_l1_int.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_GG_l1_int.png", replace


*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)
log close
}

foreach i of numlist 3 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_CG_l1_int.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)
gen intrt = log(interestrate7)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.intrt=0


varsoc cp1 intrt sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 intrt sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar


* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CG_l1_int.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CG_l1_int.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CG_l1_int.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CG_l1_int.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CG_l1_int.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CG_l1_int.png", replace


*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)
log close
}

*******************************************************************************************

gr combine "$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_socialprot_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_socialprot_CG_l1_int.gph" , ///
graphregion(color(white)) row(2) ycommon title("Bolivia", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Bolivia_int.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Bolivia_int.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_socialprot_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_socialprot_CG_l1_int.gph" , ///
graphregion(color(white)) row(2) ycommon title("Colombia", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Colombia_int.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Colombia_int.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_socialprot_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_socialprot_CG_l1_int.gph" , ///
graphregion(color(white)) row(2) ycommon title("Chile", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Chile_int.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Chile_int.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_socialprot_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_socialprot_CG_l1_int.gph" , ///
graphregion(color(white)) row(2) ycommon title("Mexico", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Mexico_int.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Mexico_int.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_socialprot_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_education_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_health_CG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_socialprot_CG_l1_int.gph" , ///
graphregion(color(white)) row(2) ycommon title("Brazil", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Brazil_int.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Brazil_int.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Peru_VAR_perc_lv_education_GG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_perc_lv_health_GG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_perc_lv_socialprot_GG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_PC_lv_education_GG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_PC_lv_health_GG_l1_int.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_PC_lv_socialprot_GG_l1_int.gph" , ///
graphregion(color(white)) row(2) ycommon title("Peru", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Peru_int.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Peru_int.eps", replace


