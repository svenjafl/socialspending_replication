* Estimation of the SVARS and IRFs for per capita spending with GDP as control variable
* Most countries (watch out for Ecuador and Honduras, included here but the estimations used in the paper with data from 1990-2015 are estimated below)

cd "$outputpath"

forval i = 1/13 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_CG_l1_GDP.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CG)
gen sp2 = log(percapita_health_CG)
gen sp3 = log(percapita_socialprot_CG)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

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
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CG_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CG_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CG_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CG_l1_GDP.png", replace


*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)
log close
}

*Panama CG

forval i = 15/15 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_CG_l1_GDP.log", replace	
	
keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CG)
gen sp2 = log(percapita_health_CG)
gen sp3 = log(percapita_socialprot_CG)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

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
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CG_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CG_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CG_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CG_l1_GDP.png", replace


*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)

log close
}

*Uruguay CG

forval i = 18/18 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_CG_l1_GDP.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CG)
gen sp2 = log(percapita_health_CG)
gen sp3 = log(percapita_socialprot_CG)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

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
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CG_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CG_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CG_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CG_l1_GDP.png", replace


*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)
log close
}


*Ecuador CG data from 1990-2015

forval i = 8/8 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_CG_l1_GDP.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

gen percapita_education_CGold = percapita_CGold_EDUCATION
gen percapita_health_CGold = percapita_CGold_HEALTH
gen percapita_socialprot_CGold = percapita_CGold_SOCIALPROT

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CGold)
gen sp2 = log(percapita_health_CGold)
gen sp3 = log(percapita_socialprot_CGold)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

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
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CGold_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CGold_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CGold_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CGold_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CGold_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CGold_l1_GDP.png", replace

log close
}

*Honduras CG data from 1990-2015

forval i = 83/83 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if id==`i'
replace cid=11 if id==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$outputpath/logfiles_loops/`label'_VAR_PC_lv_CGold_l1_GDP.log", replace	

keep if id==`i' 
keep if year <= 2019
tsset year

summarize 

rename percapita_CGold_SOCIALPROT percapita_CGold_SOCIALPROT
gen percapita_education_CGold = real(percapita_CGold_EDUCATION)
gen percapita_health_CGold = real(percapita_CGold_HEALTH)
gen percapita_socialprot_CGold = real(percapita_CGold_SOCIALPROT)

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_CGold)
gen sp2 = log(percapita_health_CGold)
gen sp3 = log(percapita_socialprot_CGold)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small
*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CGold_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CGold_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CGold_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_CGold_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CGold_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_CGold_l1_GDP.png", replace

log close
}

*Peru GG
forval i = 17/17 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_GG_l1_GDP.log", replace	

keep if cid==`i'
keep if year <= 2019
tsset year

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_GG)
gen sp2 = log(percapita_health_GG)
gen sp3 = log(percapita_socialprot_GG)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

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
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_GG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_GG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_GG_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_GG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_GG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_GG_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_GG_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_GG_l1_GDP.png", replace

*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)

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

log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_NFPS_l1_GDP.log", replace	

keep if cid==`i'
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percapita_education_NFPS)
gen sp2 = log(percapita_health_NFPS)
gen sp3 = log(percapita_socialprot_NFPS)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

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
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_NFPS_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_NFPS_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - Per capita, USD", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_NFPS_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_education_NFPS_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_health_NFPS_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_socialprot_NFPS_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_NFPS_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_PC_lv_NFPS_l1_GDP.png", replace

*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)

log close
}



* Estimation of the SVARS and IRFs for percentage of GDP spending with GDP as control variable
*Most countries (watch out for Ecuador and Honduras, included here but the estimations used in the paper with data from 1990-2015 are estimated below)

cd "$outputpath"

forval i = 2/13 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_CG_l1_GDP.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

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
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CG_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CG_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CG_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CG_l1_GDP.png", replace


*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)
log close
}

*Panama CG

forval i = 15/15 {


use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_CG_l1_GDP.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

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
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CG_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CG_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CG_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CG_l1_GDP.png", replace


*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)
log close
}

*Uruguay CG

forval i = 18/18 {


use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_CG_l1_GDP.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CG)
gen sp2 = log(percent_health_CG)
gen sp3 = log(percent_socialprot_CG)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

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
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CG_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CG_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CG_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CG_l1_GDP.png", replace


*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)
log close
}


*Ecuador CG data from 1990-2015

forval i = 8/8 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"
	
log using "$outputpath/logfiles_loops/`label'_VAR_percapita_lv_CG_l1_GDP.log", replace	

keep if cid==`i' 
keep if year <= 2019
tsset year


rename percent_CGold_SOCIALPROT percent_socialprot_CGold
rename percent_CGold_HEALTH percent_health_CGold
rename percent_CGold_EDUCATION percent_education_CGold

*gen percent_education_CGold = real(percent_CGold_EDUCATION)
*gen percent_health_CGold = real(percent_CGold_HEALTH)
*gen percent_socialprot_CGold = real(percent_CGold_SOCIALPROT)

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CGold)
gen sp2 = log(percent_health_CGold)
gen sp3 = log(percent_socialprot_CGold)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

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
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CGold_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CGold_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CGold_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CGold_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CGold_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CGold_l1_GDP.png", replace

log close
}

*Honduras CG data from 1990-2015

forval i = 83/83 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if id==`i'
replace cid=11 if id==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$outputpath/logfiles_loops/`label'_VAR_Perc_lv_CGold_l1_GDP.log", replace	

keep if id==`i' 
keep if year <= 2019
tsset year

summarize 

rename percent_CGold_SOCIALPROT percent_socialprot_CGold
rename percent_CGold_HEALTH percent_health_CGold
rename percent_CGold_EDUCATION percent_education_CGold

*gen percent_education_CGold = real(percent_CGold_EDUCATION)
*gen percent_health_CGold = real(percent_CGold_HEALTH)
*gen percent_socialprot_CGold = real(percent_CGold_SOCIALPROT)

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_CGold)
gen sp2 = log(percent_health_CGold)
gen sp3 = log(percent_socialprot_CGold)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small
*Test if the VAR is stable
varstable

*Correlation between variables of the VAR
vargranger

*test for autocorrelation
varlmar, 

* Compute IRF
irf create cp1irf, step(15) bs rep(500) set(cp1irf, replace)

*grapf IRF
irf graph oirf, impulse(cp1) response(sp1) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Education - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CGold_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CGold_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CGold_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_CGold_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CGold_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_CGold_l1_GDP.png", replace

log close
}

*Peru GG
forval i = 17/17 {

use "$datapath/dataset_for_analysis.dta", clear

tab country if cid==`i'

local t = cid
local forlab: value label cid
	local label: label `forlab' `i'
	di "`label'"

log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_GG_l1_GDP.log", replace	

keep if cid==`i'
keep if year <= 2019
tsset year

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_GG)
gen sp2 = log(percent_health_GG)
gen sp3 = log(percent_socialprot_GG)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

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
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_GG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_GG_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_GG_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_GG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_GG_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_GG_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_GG_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_GG_l1_GDP.png", replace

*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)

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

log using "$outputpath/logfiles_loops/`label'_VAR_percent_lv_NFPS_l1_GDP.log", replace	

keep if cid==`i'
keep if year <= 2019
tsset year

*summarize 

gen cp1 = log(commprice1)
gen sp1 = log(percent_education_NFPS)
gen sp2 = log(percent_health_NFPS)
gen sp3 = log(percent_socialprot_NFPS)
gen gdp = log(GDPpc)

* define restrictons for the estimation
constraint define 1 [cp1]L1.sp1=0
constraint define 2 [cp1]L1.sp2=0
constraint define 3 [cp1]L1.sp3=0
constraint define 4 [cp1]L1.gdp=0


varsoc cp1 gdp sp1 sp2 sp3, maxlag(2)

*Estimating the VAR
var cp1 gdp sp1 sp2 sp3, lags (1) constraints(1/4) dfk small

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
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_NFPS_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp2) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Health - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_NFPS_l1_GDP.gph", replace

irf graph oirf, impulse(cp1) response(sp3) plot1opts(lcolor(black) lwidth(thick)) ci1opts(fcolor(gs15) lwidth(thin) lcolor(gs14)) ///
ytitle("Orthogonalized impulse response") xtitle("Time horizon (years)") subtitle("Social Protection - % of GDP", nobox) /// 
byopts(note("") graphregion(color(white)) legend(off)) 
graph save "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_NFPS_l1_GDP.gph", replace
*/
gr combine "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_education_NFPS_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_health_NFPS_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_socialprot_NFPS_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("`label'", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_NFPS_l1_GDP.gph", replace
graph export "$outputpath/VAR_Graphs/loops/`label'_VAR_Perc_lv_NFPS_l1_GDP.png", replace

*table IRF
irf table oirf, irf(cp1irf) impulse(cp1) response(sp1 sp2 sp3 cp1)

log close
}

gr combine "$outputpath/VAR_Graphs/loops/Argentina_VAR_perc_lv_education_NFPS_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_perc_lv_health_NFPS_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_perc_lv_socialprot_NFPS_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_PC_lv_education_NFPS_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_PC_lv_health_NFPS_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Argentina_VAR_PC_lv_socialprot_NFPS_l1_gdp.gph" , ///
graphregion(color(white)) row(2) ycommon title("Argentina", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Argentina_gdp.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Argentina_gdp.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Peru_VAR_perc_lv_education_GG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_perc_lv_health_GG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_perc_lv_socialprot_GG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_PC_lv_education_GG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_PC_lv_health_GG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Peru_VAR_PC_lv_socialprot_GG_l1_gdp.gph" , ///
graphregion(color(white)) row(2) ycommon title("Peru", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Peru_gdp.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Peru_gdp.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_education_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_health_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_perc_lv_socialprot_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_education_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_health_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Bolivia_VAR_PC_lv_socialprot_CG_l1_gdp.gph" , ///
graphregion(color(white)) row(2) ycommon title("Bolivia", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Bolivia_gdp.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Bolivia_gdp.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_education_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_health_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_perc_lv_socialprot_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_education_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_health_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Colombia_VAR_PC_lv_socialprot_CG_l1_gdp.gph" , ///
graphregion(color(white)) row(2) ycommon title("Colombia", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Colombia_gdp.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Colombia_gdp.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_education_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_health_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_perc_lv_socialprot_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_education_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_health_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Chile_VAR_PC_lv_socialprot_CG_l1_gdp.gph" , ///
graphregion(color(white)) row(2) ycommon title("Chile", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Chile_gdp.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Chile_gdp.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_education_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_health_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_perc_lv_socialprot_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_education_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_health_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Mexico_VAR_PC_lv_socialprot_CG_l1_gdp.gph" , ///
graphregion(color(white)) row(2) ycommon title("Mexico", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Mexico_gdp.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Mexico_gdp.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_education_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_health_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_perc_lv_socialprot_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_education_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_health_CG_l1_gdp.gph" ///
"$outputpath/VAR_Graphs/loops/Brazil_VAR_PC_lv_socialprot_CG_l1_gdp.gph" , ///
graphregion(color(white)) row(2) ycommon title("Brazil", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Brazil_gdp.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Brazil_gdp.eps", replace

gr combine "$outputpath/VAR_Graphs/loops/Ecuador_VAR_Perc_lv_education_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_Perc_lv_health_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_Perc_lv_socialprot_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_PC_lv_education_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_PC_lv_health_CGold_l1_GDP.gph" ///
"$outputpath/VAR_Graphs/loops/Ecuador_VAR_PC_lv_socialprot_CGold_l1_GDP.gph" , ///
graphregion(color(white)) row(2) ycommon title("Ecuador", color(black))
graph save Graph "$outputpath/VAR_Graphs/loops/Ecuador_gdp.gph", replace
graph export "$outputpath/VAR_Graphs/loops/Ecuador_gdp.eps", replace

