/*******************************************************************************
**  SVAR levels per capita estimation
*******************************************************************************/

**** Central Government Spending ****

forval i = 1/13 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$datapath/Data and analysis/Results/logfiles_loops/`label'_VAR_perc_lv_CG.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L2.sp1=0
constraint define 5 [cp1]L2.sp2=0
constraint define 6 [cp1]L2.sp3=0	
	
*Estimating the VAR
var cp1 sp1 sp2 sp3, lags (1/2) constraints(1/6) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CG.gph", replace

irf graph oirf, impulse(cp1) response(sp2) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CG.gph", replace

irf graph oirf, impulse(cp1) response(sp3) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CG.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CG.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_CG.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_CG.png", replace

*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)

* graph FEVD
irf table fevd
* table FEVD
irf graph fevd, impulse(cp1) response(sp1 sp2 sp3) name(cp1FEVD, replace)

log close
}

forval i = 15/15 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$datapath/Data and analysis/Results/logfiles_loops/`label'_VAR_perc_lv_CG.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L2.sp1=0
constraint define 5 [cp1]L2.sp2=0
constraint define 6 [cp1]L2.sp3=0	
	
*Estimating the VAR
var cp1 sp1 sp2 sp3, lags (1/2) constraints(1/6) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CG.gph", replace

irf graph oirf, impulse(cp1) response(sp2) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CG.gph", replace

irf graph oirf, impulse(cp1) response(sp3) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CG.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CG.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_CG.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_CG.png", replace

*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)

* graph FEVD
irf table fevd
* table FEVD
irf graph fevd, impulse(cp1) response(sp1 sp2 sp3) name(cp1FEVD, replace)

log close
}


forval i = 18/19 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$datapath/Data and analysis/Results/logfiles_loops/`label'_VAR_perc_lv_CG.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L2.sp1=0
constraint define 5 [cp1]L2.sp2=0
constraint define 6 [cp1]L2.sp3=0	
	
*Estimating the VAR
var cp1 sp1 sp2 sp3, lags (1/2) constraints(1/6) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CG.gph", replace

irf graph oirf, impulse(cp1) response(sp2) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CG.gph", replace

irf graph oirf, impulse(cp1) response(sp3) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CG.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CG.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CG.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CG.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_CG.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_CG.png", replace

*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)

* graph FEVD
irf table fevd
* table FEVD
irf graph fevd, impulse(cp1) response(sp1 sp2 sp3) name(cp1FEVD, replace)

log close
}

**** Argentina NFPS ****

forval i = 1/1 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$datapath/Data and analysis/Results/logfiles_loops/`label'_VAR_perc_lv_NFPS.log", replace	
	
keep if cid==`i'
keep if year <= 2019
tsset year

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_NFPS)
gen sp2 = log(percent_health_NFPS)
gen sp3 = log(percent_socialprot_NFPS)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L2.sp1=0
constraint define 5 [cp1]L2.sp2=0
constraint define 6 [cp1]L2.sp3=0	
	
*Estimating the VAR
var cp1 sp1 sp2 sp3, lags (1/2) constraints(1/6) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_NFPS.gph", replace

irf graph oirf, impulse(cp1) response(sp2) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_NFPS.gph", replace

irf graph oirf, impulse(cp1) response(sp3) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_NFPS.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_NFPS.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_NFPS.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_NFPS.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_NFPS.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_NFPS.png", replace

*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)


* graph FEVD
irf table fevd
* table FEVD
irf graph fevd, impulse(cp1) response(sp1 sp2 sp3) name(cp1FEVD, replace)
log close

}

**** Peru GG ****

forval i = 17/17 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$datapath/Data and analysis/Results/logfiles_loops/`label'_VAR_perc_lv_GG.log", replace	

keep if cid==`i'
keep if year <= 2019
tsset year

summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_GG)
gen sp2 = log(percent_health_GG)
gen sp3 = log(percent_socialprot_GG)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L2.sp1=0
constraint define 5 [cp1]L2.sp2=0
constraint define 6 [cp1]L2.sp3=0	
	
*Estimating the VAR
var cp1 sp1 sp2 sp3, lags (1/2) constraints(1/6) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_GG.gph", replace

irf graph oirf, impulse(cp1) response(sp2) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_GG.gph", replace

irf graph oirf, impulse(cp1) response(sp3) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_GG.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_GG.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_GG.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_GG.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/`label'_VAR_perc_lv_GG.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_GG.png", replace

*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)

* graph FEVD
irf table fevd
* table FEVD
irf graph fevd, impulse(cp1) response(sp1 sp2 sp3) name(cp1FEVD, replace)
log close
}

******************************************************
**** Data from 2021 ****
**** 1990-2015 CG Ecuador
**** 1990-2015 CG Honduras

forval i = 83/83 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if id==`i'
replace cid=11 if id==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$datapath/Data and analysis/Results/logfiles_loops/`label'_VAR_perc_lv_CGold.log", replace	

keep if id==`i' 
keep if year <= 2019
tsset year

summarize 

rename percentpercent_CGold_SOCIALPROT percent_CGold_SOCIALPROT
gen percent_education_CGold = real(percent_CGold_EDUCATION)
gen percent_health_CGold = real(percent_CGold_HEALTH)
gen percent_socialprot_CGold = real(percent_CGold_SOCIALPROT)

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CGold)
gen sp2 = log(percent_health_CGold)
gen sp3 = log(percent_socialprot_CGold)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L2.sp1=0
constraint define 5 [cp1]L2.sp2=0
constraint define 6 [cp1]L2.sp3=0	
	
*Estimating the VAR
var cp1 sp1 sp2 sp3, lags (1/2) constraints(1/6) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CGold.gph", replace

irf graph oirf, impulse(cp1) response(sp2) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CGold.gph", replace

irf graph oirf, impulse(cp1) response(sp3) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CGold.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CGold.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CGold.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CGold.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_CGold.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_CGold.png", replace

*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)

* graph FEVD
irf table fevd
* table FEVD
irf graph fevd, impulse(cp1) response(sp1 sp2 sp3) name(cp1FEVD, replace)

log close
}

****

forval i = 57/57 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if id==`i'
replace cid=8 if id==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$datapath/Data and analysis/Results/logfiles_loops/`label'_VAR_perc_lv_CGold.log", replace	

keep if id==`i' 
keep if year <= 2019
tsset year

summarize 

rename percentpercent_CGold_SOCIALPROT percent_CGold_SOCIALPROT
gen percent_education_CGold = real(percent_CGold_EDUCATION)
gen percent_health_CGold = real(percent_CGold_HEALTH)
gen percent_socialprot_CGold = real(percent_CGold_SOCIALPROT)

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CGold)
gen sp2 = log(percent_health_CGold)
gen sp3 = log(percent_socialprot_CGold)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L2.sp1=0
constraint define 5 [cp1]L2.sp2=0
constraint define 6 [cp1]L2.sp3=0	
	
*Estimating the VAR
var cp1 sp1 sp2 sp3, lags (1/2) constraints(1/6) dfk small

*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CGold.gph", replace

irf graph oirf, impulse(cp1) response(sp2) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CGold.gph", replace

irf graph oirf, impulse(cp1) response(sp3) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CGold.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_education_CGold.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_health_CGold.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_socialprot_CGold.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_CGold.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_perc_lv_CGold.png", replace

*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)

* graph FEVD
irf table fevd
* table FEVD
irf graph fevd, impulse(cp1) response(sp1 sp2 sp3) name(cp1FEVD, replace)

log close
}


